package action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ModiResService;
import vo.ActionForward;
import vo.ReserveBean;


public class ModiResAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		System.out.println("ModiResAction");
		System.out.println(request.getParameter("setA"));
		String reserve_code=request.getParameter("reserve_code");
		String store_name = request.getParameter("store_name");
		String load_address = request.getParameter("load_address");
		String address = request.getParameter("address");
		String store_number = request.getParameter("store_number");
		String reserve_date = request.getParameter("date");
//		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
////		String dtDate = format.format(strDate);
//		Date date = format.parse(strDate);
//		String reserve_date = format.format(date);
//		System.out.println(reserve_date);
		String reserve_time = request.getParameter("reserve_time");
		int people = Integer.parseInt(request.getParameter("people"));
		String customerNeeds = request.getParameter("customerNeeds");
		int setA = Integer.parseInt(request.getParameter("setA")); 
		int setB = Integer.parseInt(request.getParameter("setB"));
		String total_order_menu = "set A : " + setA + ", set B : " +setB;
		ReserveBean bean = new ReserveBean(store_name, load_address, address, store_number, reserve_date, reserve_time, people, customerNeeds,total_order_menu, reserve_code);
		System.out.println(bean.toString() + " setA , setB 값 없음");
		
		ModiResService service = new ModiResService();
		
		boolean isModiSuccess = service.modiResService(bean);
		if(isModiSuccess) {
			System.out.println("ModiResAction 수정 성공");
			forward.setPath("./modify_reserve.jsp");
			forward.setRedirect(false);
		}else {
			 System.out.println("ModiResAction 수정 실패");
			 response.setContentType("text/html; charset=UTF-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>");
	         out.println("alert('수정 실패.')");
	         out.println("history.back()");
	         out.println("</script>");
		}
		return forward;
	}

}

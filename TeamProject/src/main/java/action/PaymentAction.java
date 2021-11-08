package action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.PaymentService;
import vo.ActionForward;
import vo.ReserveBean;

public class PaymentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String reserve_user = request.getParameter("reserve_user");
		String category = request.getParameter("category");
		String storeName = request.getParameter("storeName");
		String loadAddress = request.getParameter("loadAddress");
		String address = request.getParameter("address");
		String storeNumber = request.getParameter("storeNumber");
		String reserve_date = request.getParameter("reserve_date");
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSZ");
//		Date reserve_date = sdf.parse(strDate);
		String reserve_time = request.getParameter("reserve_time");
		int reserve_people = Integer.parseInt(request.getParameter("reserve_people"));
		String reserve_needs = request.getParameter("reserve_needs");
		int payment_price = Integer.parseInt(request.getParameter("payment_price"));
		String used_coupon_code = request.getParameter("used_coupon_code");
		String total_order_menu =request.getParameter("total_order_menu");
		
		ReserveBean reserve = new ReserveBean(category,storeName, loadAddress, address, storeNumber, reserve_user, reserve_date, reserve_time, reserve_people, reserve_needs, total_order_menu,payment_price);
		System.out.println(reserve.toString());
		
		PaymentService service = new PaymentService();
		boolean isPaySuccess = service.payAction(reserve,used_coupon_code);
		if(isPaySuccess) {
			System.out.println("isPaySuccess : " + isPaySuccess + "결제 완료!");
			forward = new ActionForward();
			forward.setPath("./reserve/reserve_main2.jsp");
			forward.setRedirect(false);
		}else {
			 System.out.println("PaymentAction ��������");
			 response.setContentType("text/html; charset=UTF-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>");
	         out.println("alert('결제에 실패했습니다.')");
	         out.println("history.back()");
	         out.println("</script>");
		}
		
		return forward;
	}

}

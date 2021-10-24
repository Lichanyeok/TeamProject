package action;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;
import vo.ReserveBean;

public class payAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		String storeName = request.getParameter("storeName");
		String loadAddress = request.getParameter("loadAddress");
		String address = request.getParameter("address");
		String storeNumber = request.getParameter("storeNumber");
		
		//date 타입으로 변환
		String strDate = request.getParameter("date");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String id = request.getParameter("id");
		Date date = format.parse(strDate);
		String time = request.getParameter("time");
		int people = Integer.parseInt(request.getParameter("people"));
		String customerNeeds = request.getParameter("customerNeeds");
		int setA = Integer.parseInt(request.getParameter("setA")); 
		int setB = Integer.parseInt(request.getParameter("setB"));
		
		ReserveBean reserve = new ReserveBean(storeName, loadAddress, address, storeNumber, id,date, time, people, customerNeeds, setA, setB);
		System.out.println(reserve.toString());
		request.setAttribute("reserveBean", reserve);
		forward.setPath("./reserve/pay_form.jsp");
		forward.setRedirect(false);
		return forward;
	}

}

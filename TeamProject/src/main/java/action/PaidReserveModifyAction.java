package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.PaidReserveModifyService;
import vo.ActionForward;
import vo.ReserveBean;

public class PaidReserveModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		System.out.println("PaidReserveModifyAction");
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
		String reserve_code = request.getParameter("reserve_code");
		String total_order_menu =request.getParameter("total_order_menu");
		ReserveBean reserve = new ReserveBean(category,storeName, loadAddress, address, storeNumber, reserve_user, reserve_date, reserve_time, reserve_people, reserve_needs, total_order_menu,payment_price);
		System.out.println(reserve.toString());
		PaidReserveModifyService service = new PaidReserveModifyService();
		boolean isModifySuccess = service.paidReserveModify(reserve,used_coupon_code,reserve_code);
		
		if(isModifySuccess) {
			System.out.println("선결제 예약 변경 성공");
			forward.setPath("./reserve/paid_modify_reserve.jsp");
			forward.setRedirect(false);
		}else {
			System.out.println("선결제 예약 변경 실패");
		}
		return forward;
	}

}

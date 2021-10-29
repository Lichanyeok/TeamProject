package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.GetCouponListService;
import vo.ActionForward;
import vo.CouponBean;

public class GetCouponListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String id = request.getParameter("id");
		System.out.println("GetCouponListAction : " + id);
		GetCouponListService service = new GetCouponListService();
		
		ArrayList<CouponBean> couponList = service.getCouponList(id);
		request.setAttribute("couponList", couponList);
		
		forward = new ActionForward();
		forward.setPath("/reserve/coupon_list.jsp");
		forward.setRedirect(false);
		return forward;
	}

}

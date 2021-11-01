package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.GetCouponListService;
import vo.ActionForward;
import vo.CouponBean;

public class GetListCouponAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		String id = session.getAttribute("sId").toString();
		System.out.println("getListCouponAction id : " + id);
		GetCouponListService service = new GetCouponListService();
		
		ArrayList<CouponBean> list = service.getCouponList(id);
		if(list!=null) {
			request.setAttribute("list", list);
			forward.setPath("./member/coupon_list.jsp");
			forward.setRedirect(false);
		}
		return forward;
	}

}

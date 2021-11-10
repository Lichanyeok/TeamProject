package action;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BoardDAO;
import dao.MemberDAO;
import svc.PublishService;
import vo.ActionForward;
import vo.CouponBean;

import static db.jdbcUtil.*;
public class PublishAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		int coupon_name = Integer.parseInt(request.getParameter("coupon_name"));
		int coupon_value = Integer.parseInt(request.getParameter("coupon_value"));
		int coupon_price = Integer.parseInt(request.getParameter("coupon_price"));
		int coupon_target = Integer.parseInt(request.getParameter("coupon_target"));
		System.out.println(coupon_name + "," + coupon_value + "," + coupon_price + "," + coupon_target);
		
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		ArrayList<String> list = dao.selectMemberCount(coupon_target);
		ArrayList<CouponBean> couponList = new ArrayList<CouponBean>();
		
		String name =""; 
		String value="";
		int price = 0;
		
		switch (coupon_name) {
		case 2: name = "우수고객 정기 할인쿠폰";break;
		case 3: name = "단골고객 정기 할인쿠폰";break;
		case 4: name = "더우수고객 정기 할인쿠폰";break;
		}
		switch (coupon_value) {
		case 2: value = "1000원 할인";break;
		case 3: value = "2000원 할인";break;
		case 4: value = "3000원 할인";break;
		}
		switch (coupon_price) {
		case 2: price = 1000;break;
		case 3: price = 2000;break;
		case 4: price = 3000 ;break;
		}


		Set<String> arrRandom = new HashSet<String>(); 
		while(arrRandom.size()<list.size()) {
			arrRandom.add(BoardDAO.getRandomStr(8));
		}
		System.out.println("난수 크기 : " + arrRandom.size() + "선택된 인원 :  " + list.size());
		Iterator<String> it = arrRandom.iterator();		
		CouponBean couponB = null;
		PublishService service = new PublishService();
		for(int i = 0; i<list.size();i++) {
			couponB = new CouponBean(name, value, price, it.next(), list.get(i));
			couponList.add(couponB);
			service.publishCoupon(couponB);
		}
		request.setAttribute("couponList", couponList);
		
		forward.setPath("./admin/publish_coupon_result.jsp");
		forward.setRedirect(false);
		return forward;
	}

}

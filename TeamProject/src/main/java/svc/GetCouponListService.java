package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MemberDAO;
import vo.CouponBean;
import static db.jdbcUtil.*;
public class GetCouponListService {

	

	public ArrayList<CouponBean> getCouponList(String id) {
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		ArrayList<CouponBean> couponList = dao.getUserCouponList(id);
		System.out.println("GetCouponListService : " + couponList.size());
		close(con);
		return couponList;
	}

	

}

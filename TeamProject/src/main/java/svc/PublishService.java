package svc;

import java.sql.Connection;

import dao.MemberDAO;
import vo.CouponBean;
import static db.jdbcUtil.*;
public class PublishService {

	public void publishCoupon(CouponBean couponB) {
		System.out.println("publishService - " + couponB.getUser_id());
		int isSuccess = 0;
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		isSuccess = dao.insertCoupon(couponB);
		
		if(isSuccess>0) {
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
	}

}

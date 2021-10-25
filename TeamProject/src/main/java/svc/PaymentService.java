package svc;

import java.sql.Connection;

import dao.ReserveDAO;
import vo.ReserveBean;
import static db.jdbcUtil.*;

public class PaymentService {

	public boolean payAction(ReserveBean reserve,String used_coupon_code) {
		boolean isPaySuccess = false;
		System.out.println("payAction - Service : " + used_coupon_code);
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		isPaySuccess = dao.insertReserve(reserve);
		
		if(isPaySuccess) {
			System.out.println("insertReserve DAO : " + isPaySuccess);
			boolean isRemoveSuccess = dao.removeCoupon(used_coupon_code);
			if(isRemoveSuccess) {
				System.out.println("removeCoupon - DAO : " + isRemoveSuccess);
				isPaySuccess = true;
				commit(con);
				close(con);
			}else {
				System.out.println("쿠폰 삭제 실패");
				rollback(con);
			}
		}else {
			System.out.println("결제 실패");
			rollback(con);
		}
		
		return isPaySuccess;
	}

}

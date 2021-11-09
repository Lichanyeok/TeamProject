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
		String res_code = dao.insertReserve(reserve);
		
		if(res_code!=null) {
			System.out.println("insertReserve DAO : " + res_code);
			boolean isUsedSuccess = dao.usedCoupon(used_coupon_code,res_code);
			commit(con);
			if(isUsedSuccess) {
				System.out.println("쿠폰변경완료 - DAO : " + isUsedSuccess);
				isPaySuccess = true;
				commit(con);
				close(con);
			}else {
				System.out.println("쿠폰 정보가 올바르지 않습니다.");
				rollback(con);
			}
		}else {
			System.out.println("저장 실패");
			rollback(con);
		}
		
		return isPaySuccess;
	}

	public int localPayment(ReserveBean reserve) {
		int isInsertSuccess = 0;
		System.out.println("localPayment - Service ");
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		isInsertSuccess = dao.insertLocalPayment(reserve);
		if(isInsertSuccess>0) {
			System.out.println("현장결제 완료");
			commit(con);
		}else {
			rollback(con);
			System.out.println("현장결제 실패");
		}
		close(con);
		return isInsertSuccess;
	}

}

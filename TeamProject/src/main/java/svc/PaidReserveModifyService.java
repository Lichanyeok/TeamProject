package svc;

import dao.ReserveDAO;
import vo.ReserveBean;
import static db.jdbcUtil.*;

import java.sql.Connection;

public class PaidReserveModifyService {

	public boolean paidReserveModify(ReserveBean reserve, String used_coupon_code, String reserve_code) {
		boolean allSuccess=false;
		boolean isModifySuccess = false;
		boolean couponRestoreSuccess=false;
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		if(!used_coupon_code.equals("")) {
			//coupon 복구
			boolean isRestore = dao.couponRestore(used_coupon_code,reserve_code);
			System.out.println("쿠폰 복구 : " + isRestore);
			//coupon 사용
			if(isRestore) {
				boolean isUseSuccess = dao.usedCoupon(used_coupon_code,reserve_code);
				if(isUseSuccess) {
					System.out.println("복구/사용 성공");
					commit(con);
					couponRestoreSuccess=true;
				}else {
					System.out.println("쿠폰 복구/사용 실패");
					rollback(con);
				}
			}else {
				System.out.println("복구 실패");
				rollback(con);
			}
		}else {
			couponRestoreSuccess=true;
		}
		
		isModifySuccess = dao.paidModiRes(reserve,reserve_code);
		if(isModifySuccess) {
			commit(con);
			System.out.println("선결제 예약 변경 성공");
		}else {
			rollback(con);
			System.out.println("선결제 예약 변경 실패");
		}
		
		if(isModifySuccess && couponRestoreSuccess) {
			allSuccess = true;
		}else {
			allSuccess = false;
		}
		close(con);
		return allSuccess;
	}

}

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
			commit(con);
			if(isRemoveSuccess) {
				System.out.println("removeCoupon - DAO : " + isRemoveSuccess);
				isPaySuccess = true;
				commit(con);
				close(con);
			}else {
				System.out.println("���� ���� ����");
				rollback(con);
			}
		}else {
			System.out.println("���� ����");
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
			System.out.println("���༺��");
			commit(con);
		}else {
			rollback(con);
			System.out.println("���� ����");
		}
		close(con);
		return isInsertSuccess;
	}

}

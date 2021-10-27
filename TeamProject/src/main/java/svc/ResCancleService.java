package svc;

import java.sql.Connection;

import dao.ReserveDAO;
import static db.jdbcUtil.*;
public class ResCancleService {

	public boolean resCancle(String reserve_code) {
		boolean isCancleSuccess = false;
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		isCancleSuccess = dao.reserveCancle(reserve_code);
		
		close(con);
		return isCancleSuccess;
	}

}

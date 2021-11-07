package svc;

import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.ReserveDAO;
import vo.ReserveBean;
import static db.jdbcUtil.*;
public class ModiResService {

	public boolean modiResService(ReserveBean bean) {
		boolean modiResSuccess = false;
		
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		modiResSuccess = dao.modiRes(bean);
		
		if(modiResSuccess) {
			System.out.println("modiResService :success");
			commit(con);
			modiResSuccess=true;
		}else {
			System.out.println("modiResService : fail");
			rollback(con);
		}
		close(con);
		return modiResSuccess;
	}

}

package svc;

import java.sql.Connection;
import static db.jdbcUtil.*;
import dao.MemberDAO;

public class UpdatePassService {

	public boolean updatePass(String pass,String id) {
		boolean isUpdateSuccess = false;
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		int updateCount = dao.updatePass(pass,id);
		
		if(updateCount>0) {
			isUpdateSuccess = true;
		}
		close(con);
		return isUpdateSuccess;
	}

}

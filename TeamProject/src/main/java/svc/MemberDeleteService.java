package svc;

import java.sql.Connection;

import dao.MemberDAO;
import static db.jdbcUtil.*;

public class MemberDeleteService {

	public int memberDelete(String id) {
		int deleteSuccess = 0;
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		deleteSuccess = dao.deleteMember(id);
		
		if(deleteSuccess>0){
			commit(con);	
		}else {
			rollback(con);
		}
		
		close(con);
		return deleteSuccess;
	}

}

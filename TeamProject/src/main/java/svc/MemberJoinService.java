package svc;

import java.sql.Connection;

import static db.jdbcUtil.*;
import dao.MemberDAO;
import vo.MemberBean;

public class MemberJoinService {

	public boolean joinMember(MemberBean bean) {
		System.out.println("MemberJoinService - Service");
		boolean isJoinSuccess = false;
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		isJoinSuccess = dao.insertMember(bean);
		
		if(isJoinSuccess) {
			commit(con);
			close(con);
			
		}else {
			rollback(con);
			isJoinSuccess=false;
		}
		
		close(con);
		return isJoinSuccess;
	}

}

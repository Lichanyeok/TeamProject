package svc;

import dao.MemberDAO;
import vo.MemberBean;

import static db.jdbcUtil.*;

import java.sql.Connection; 

public class MemberLoginProService {

	public int loginMember(MemberBean bean) {
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		int isLoginSuccess = dao.selectMember(bean);
		
		if(isLoginSuccess == 2) {
			dao.updateDate(bean);
			commit(con);
		}else if (isLoginSuccess == 0 || isLoginSuccess == 1) {
			rollback(con);
		}
		close(con);
		return isLoginSuccess;
	}

}

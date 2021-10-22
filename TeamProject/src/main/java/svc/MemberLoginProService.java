package svc;

import dao.MemberDAO;
import vo.MemberBean;

import static db.jdbcUtil.*;

import java.sql.Connection; 

public class MemberLoginProService {

	public boolean loginMember(MemberBean bean) {
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		boolean isLoginSuccess = dao.selectMember(bean);
		
		if(isLoginSuccess) {
			dao.updateDate(bean);
			commit(con);
			isLoginSuccess = true;
		}else {
			rollback(con);
			isLoginSuccess = false;
		}
		close(con);
		return isLoginSuccess;
	}

}

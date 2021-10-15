package svc;

import dao.MemberDAO;
import vo.MemberBean;

import java.sql.Connection;

import static db.jdbcUtil.*;

public class MemberManagementService {

	public boolean checkMember(String pass) {
		boolean isManagementSuccess = false;
		
		Connection con = getConnection();
		
		MemberDAO dao = MemberDAO.getInstance();
		
		dao.setConnection(con);

		int insertCount = dao.menagementMember(pass);
		
		if(insertCount > 0) {
			commit(con);
			isManagementSuccess = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isManagementSuccess;
	}

	public MemberBean getArticle(String pass) {
		MemberBean article = null;

		Connection con = getConnection();

		MemberDAO dao = MemberDAO.getInstance();

		dao.setConnection(con);

		article = dao.selectArticle(pass);

		close(con);

		return article;
	}
	
}















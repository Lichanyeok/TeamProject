package svc;

import vo.MemberBean;
import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.MemberDAO;
public class FindPassService {

	public boolean FindPass(MemberBean bean) {
		boolean isRightInfo = false;
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		isRightInfo = dao.getPass(bean);
		
		
		close(con);
		return isRightInfo;
	}

}

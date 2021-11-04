package svc;

import java.sql.Connection;

import dao.MemberDAO;
import static db.jdbcUtil.*;
import vo.MemberBean;

public class FindIdService {

	public String findId(String name, String email) {

		String id = null;
		
		MemberBean bean = new MemberBean();
		bean.setName(name);
		bean.setEmail(email);
		
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		id = dao.getId(bean);
		
		return id;
	}

}

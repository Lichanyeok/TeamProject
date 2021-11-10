package svc;

import java.sql.Connection;
import java.util.ArrayList;
import static db.jdbcUtil.*;
import dao.MemberDAO;
import vo.MemberBean;

public class MemberDetailService {

	public ArrayList<MemberBean> getMemberinfo(String id, String pass) {
		ArrayList<MemberBean> list = null;
		
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		list = dao.getMemberDetail(id,pass);
//		System.out.println("getMemberinfo : list size :" + list.size());
		close(con);
		return list;
	}

}

package svc;

import java.sql.Connection;
import java.util.ArrayList;

import static db.jdbcUtil.*;


import dao.MemberDAO;
import vo.MemberBean;

public class MemberAlignService {

	public ArrayList<MemberBean> memberAlign(String alignType) {
		System.out.println("memberAlign");
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		ArrayList<MemberBean> list = null;
		if(alignType.equals("name")) {
			list = dao.nameAlign();
		}else if(alignType.equals("date")) {
			list = dao.dateAlign();
		}else if(alignType.equals("grade")) {
			list = dao.gradeAlign();
		}
		
		close(con);
		return list;
	}

	public int getListCount() {
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		int listCount=0;
		System.out.println("getListCount");
		
		listCount = dao.selectListCount();
//		System.out.println(listCount);
		close(con);
		return listCount;
		
	}

}

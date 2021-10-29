package svc;

import java.sql.Connection;
import java.util.ArrayList;


import dao.ReserveDAO;
import vo.ReserveBean;
import static db.jdbcUtil.*;
public class ReserveListService {

	public int getListCount(String sId) {
		Connection con = getConnection();
		ReserveDAO dao = ReserveDAO.getInstance();
		dao.setConnection(con);
		int listCount = dao.selectListCount(sId);
		System.out.println("listCount = " + listCount);
		close(con);
		
		return listCount;
	}
	
	public ArrayList<ReserveBean> getReserveList(String sId,int page, int limit) {
		ArrayList<ReserveBean> reserveList = null;
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		reserveList = dao.getReserveList(sId,page,limit);
		close(con);
		return reserveList;
	}

}

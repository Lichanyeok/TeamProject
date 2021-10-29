package svc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dao.ReserveDAO;
import vo.MemberBean;
import vo.ReserveBean;

import static db.jdbcUtil.*;
public class CheckReserverInfoService {

	public boolean loginMember(MemberBean bean) {
		boolean isLoginSuccess = false;
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		isLoginSuccess = dao.isRightUser(bean);
		
		close(con);
		return isLoginSuccess;
	}

	public boolean isRightCode(String reserve_code) {
		boolean isRightCode = false;
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		isRightCode = dao.isRightCode(reserve_code);
		
		close(con);
		return isRightCode;
	}

	public ArrayList<ReserveBean> getResList(String reserve_code) {
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		ArrayList<ReserveBean> resList = dao.getResList(reserve_code);
		
		close(con);
		return resList;
	}

}

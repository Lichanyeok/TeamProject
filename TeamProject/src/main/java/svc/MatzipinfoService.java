package svc;

import vo.SearchBean;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.SearchDAO;

public class MatzipinfoService {

	public SearchBean getInfo(String jibun_address, String tell_number) {
		SearchBean details = null;
		
		
		Connection con = getConnection();
		
		
		SearchDAO dao = SearchDAO.getInstance();
		
		
		dao.setConnection(con);
		
		
		
		details = dao.Info(jibun_address, tell_number);
		
		
		close(con);
		
		return details;
	}

}

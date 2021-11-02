package svc;

import vo.SearchBean;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.SearchDAO;

public class MatzipinfoService {

	public SearchBean getInfo(String road_address, String place_name) {
		SearchBean details = null;
		
		
		Connection con = getConnection();
		
		
		SearchDAO dao = SearchDAO.getInstance();
		
		
		dao.setConnection(con);
		
		
		
		details = dao.Info(road_address, place_name);
		
		
		close(con);
		
		return details;
	}

}

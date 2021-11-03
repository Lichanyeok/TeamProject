package svc;

import vo.ReviewBean;
import vo.SearchBean;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.ReviewDAO;
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

	public ReviewBean getListCount(String place_name) {
		ReviewBean reviewListCount = null;
		
		Connection con = getConnection();
		
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		
		dao.setConnection(con);
		
		
		
		reviewListCount = dao.selectListCount(place_name);
		
		
		close(con);
		
		return reviewListCount;
	}

}

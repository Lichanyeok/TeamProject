package svc;

import vo.ReviewBean;
import vo.SearchBean;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.ReviewDAO;
import dao.SearchDAO;

public class MatzipMyStoreService {

	public SearchBean getInfo(String id) {
		SearchBean search = null;
		Connection con = getConnection();
		SearchDAO dao = SearchDAO.getInstance();
		dao.setConnection(con);
		
		search = dao.selectID(id);
		close(con);		
		return search;
	}

}

package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.SearchDAO;
import vo.SearchBean;
import static db.jdbcUtil.*;

public class AddStoreListService {

	public ArrayList<SearchBean> getAddStoreList() {
		System.out.println("getAddStoreList - service");
		ArrayList<SearchBean> storeList = null;
		SearchDAO dao = SearchDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		storeList = dao.getAddStoreList();
		
		return storeList;
	}

}

package svc;

import static db.jdbcUtil.*;


import java.sql.Connection;

import dao.SearchDAO;
import vo.SearchBean;

public class MatzipModifyService {
	public int updateList(SearchBean bean) {
		Connection con = getConnection();
		SearchDAO dao = SearchDAO.getInstance();
		dao.setConnection(con);
		
		int count = dao.listUpdate(bean);
		if(count>0) {
			commit(con);
		}else {
			rollback(con);
		}
		close(con);	
		return count;
	}

}

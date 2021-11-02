package svc;

import static db.jdbcUtil.*;


import java.sql.Connection;

import dao.SearchDAO;
import vo.SearchBean;

public class MatzipListInsertService {
	public int insertList(SearchBean bean) {
		Connection con = getConnection();
		
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		SearchDAO dao = SearchDAO.getInstance();
		
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달
		dao.setConnection(con);
		
		int count = dao.listInsert(bean);
		if(count>0) {
			commit(con);
		}else {
			rollback(con);
		}
		close(con);	
		return count;
	}

}

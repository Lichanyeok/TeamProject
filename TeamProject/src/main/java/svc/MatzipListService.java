package svc;
import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;


import dao.SearchDAO;
import vo.SearchBean;
public class MatzipListService {

	public int getmatzipListCount() {
		Connection con = getConnection();
		
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		SearchDAO dao = SearchDAO.getInstance();
		
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달
		dao.setConnection(con);
		
		int listCount = dao.ListCount();
		
		System.out.println(listCount);
		// 공통작업-4. Connection 객체 반환
		close(con);	
		return listCount;
	}

	public ArrayList<SearchBean> getArticleList(int page, int maximum, String category) {
		Connection con = getConnection();
		
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		SearchDAO dao = SearchDAO.getInstance();
				
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달
		dao.setConnection(con);		
		
		ArrayList<SearchBean> articleList = dao.ArticleList(page, maximum, category);
		
		// 공통작업-4. Connection 객체 반환
		close(con);
		return articleList;
	}
}

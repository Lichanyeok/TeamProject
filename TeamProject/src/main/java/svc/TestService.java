package svc;

import static db.jdbcUtil.close;
import static db.jdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.SearchDAO;
import vo.SearchBean;

public class TestService {

	public ArrayList<SearchBean> getArticle() {
		Connection con = getConnection();
		SearchDAO dao = SearchDAO.getInstance();		
		dao.setConnection(con);		
		
		ArrayList<SearchBean> articleList = dao.TestArticleList();
		
		
		close(con);
		System.out.println("aaa");
		return articleList;
	}

}

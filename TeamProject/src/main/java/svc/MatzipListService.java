package svc;
import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.BoardDAO;
import vo.SearchBean;
public class MatzipListService {

	public int getmatzipListCount() {
		Connection con = getConnection();
		
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달
		dao.setConnection(con);
		
		int listCount = dao.ListCount();
		
		System.out.println(listCount);
		// 공통작업-4. Connection 객체 반환
		close(con);
		return listCount;
	}

	public ArrayList<SearchBean> getArticleList(int page, int maximum) {
		Connection con = getConnection();
		
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		BoardDAO dao = BoardDAO.getInstance();
				
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달
		dao.setConnection(con);
		
		// 게시물 목록 조회를 수행하는 getArticleList() 메서드 호출
		// => 파라미터 : 페이지번호, 게시물 갯수
		//    리턴타입 : ArrayList<BoardBean> 객체(articleList)
		
		ArrayList<SearchBean> articleList = dao.ArticleList(page, maximum);
		
		// 공통작업-4. Connection 객체 반환
		close(con);
		return articleList;
	}
}

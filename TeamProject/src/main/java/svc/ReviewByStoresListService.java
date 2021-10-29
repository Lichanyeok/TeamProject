package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ReviewDAO;
import vo.ReviewBean;

//import db.JdbcUtil;
//import static db.JdbcUtil.getConnection;
import static db.jdbcUtil.*; // db.JdbcUtil 내의 모든 메서드 로드

public class ReviewByStoresListService {
	
	public ReviewBean getListCount() {
		System.out.println("ReviewByStoresListService - getListCount()");
		
		// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
//		Connection con = JdbcUtil.getConnection();
		Connection con = getConnection();
		
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();

		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		
		// boardDAO 객체의 selectArticleList() 메서드를 호출하여 게시물 총 갯수 구하기
		// => 파라미터 : 없음, 리턴타입 : int(listCount)
		ReviewBean rb = dao.selectListCount();
//		System.out.println("listCount : " + listCount); // selectListCount 작동 확인
		
		// 공통작업-4. Connection 객체 반환
		close(con);
		
		return rb;
	}

	public ArrayList<ReviewBean> getByStoreList() {
		System.out.println("ReviewByStoresListService - getArticleList()");
		
		// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();
		
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// 게시물 목록 조회를 수행하는 getArticleList() 메서드 호출
		// => 파라미터 : 페이지번호(page), 게시물 갯수(limit)
		// => 리턴타입 : ArrayList<BoardBean> 객체 (articleList)
		ArrayList<ReviewBean> articleList = dao.getByStoreList();
		System.out.println("getByStoreList() - articleList : " + articleList);
		// 공통작업-4. Connection 객체 반환
		close(con);
		
		return articleList;
	}

}

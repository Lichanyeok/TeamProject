package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ReviewDAO;
import vo.ReviewBean;

//import db.JdbcUtil;
//import static db.JdbcUtil.getConnection;
import static db.jdbcUtil.*; // db.JdbcUtil 내의 모든 메서드 로드

public class ReviewListService {

	// 현재 게시물 총 갯수를 가져와서 리턴하는 작업을 요청하는 getListCount() 메서드 정의
	// => 파라미터 : rev_store, 리턴타입 : ReviewBean
	public ReviewBean getListCount(String rev_store) {
		System.out.println("ReviewListService - getListCount()");
		
		// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
//		Connection con = JdbcUtil.getConnection();
		Connection con = getConnection();
		
		// 공통작업-2. ReviewDAO 클래스로부터 BoardDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();

		// 공통작업-3. ReviewDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		
		// ReviewDAO 객체의 selectListCount() 메서드를 호출하여 리뷰 총 갯수 구하기
		// => 파라미터 : rev_store, 리턴타입 : ReviewBean
		ReviewBean rb = dao.selectListCount(rev_store);
		
		// 공통작업-4. Connection 객체 반환
		close(con);
		
		return rb;
	}
	
	public int getMyListCount(String nickName) {
		System.out.println("ReviewListService - getMyListCount()");
		
		int myListCount = 0; // 작성한 총 리뷰 수를 저장할 변수
		
		// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 공통작업-2. ReviewDAO 클래스로부터 BoardDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();

		// 공통작업-3. ReviewDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// ReviewDAO 객체의 selectMyListCount() 메서드를 호출하여 리뷰 총 갯수 구하기
		// => 파라미터 : id, 리턴타입 : int
		myListCount = dao.selectMyListCount(nickName);
		
		// 공통작업-4. Connection 객체 반환
		close(con);
		
		return myListCount;
	}

	public ArrayList<ReviewBean> getStoreReviewList(String rev_store) {  // 필요함
		System.out.println("ReviewListService - getArticleList()");
		
		// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 공통작업-2. ReviewBean 클래스로부터 BoardDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();
		
		// 공통작업-3. ReviewBean 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// 리뷰 목록 조회를 수행하는 getStoreReviewList() 메서드 호출
		// => 파라미터 : 매장명(rev_store)
		// => 리턴타입 : ArrayList<BoardBean> 객체 (articleList)
		ArrayList<ReviewBean> articleList = dao.getStoreReviewList(rev_store);
		System.out.println("getArticleList() - articleList : " + articleList);
		
		// 공통작업-4. Connection 객체 반환
		close(con);
		
		return articleList;
	}
	
	public ArrayList<ReviewBean> getMyReviewList(String nickName) { // 필요함
		System.out.println("ReviewListService - getMyReviewList()");
		
		// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 공통작업-2. ReviewBean 클래스로부터 BoardDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();
		
		// 공통작업-3. ReviewBean 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// 리뷰 목록 조회를 수행하는 getStoreReviewList() 메서드 호출
		// => 파라미터 : 매장명(rev_store)
		// => 리턴타입 : ArrayList<BoardBean> 객체 (articleList)
		ArrayList<ReviewBean> myReviewList = dao.getMyReviewList(nickName);
		System.out.println("getMyReviewList() - myReviewList : " + myReviewList);
		
		// 공통작업-4. Connection 객체 반환
		close(con);
		
		return myReviewList;
	}

}

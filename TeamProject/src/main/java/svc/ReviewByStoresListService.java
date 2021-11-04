package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ReviewDAO;
import vo.ReviewBean;

//import db.JdbcUtil;
//import static db.JdbcUtil.getConnection;
import static db.jdbcUtil.*; // db.JdbcUtil 내의 모든 메서드 로드

public class ReviewByStoresListService {

	public ArrayList<ReviewBean> getByStoreList() {
		System.out.println("ReviewByStoresListService - getByStoreList()");
		
		// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 공통작업-2. ReviewDAO 클래스로부터 ReviewDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();
		
		// 공통작업-3. ReviewDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// 게시물 목록 조회를 수행하는 getByStoreList() 메서드 호출
		// => 리턴타입 : ArrayList<ReviewBean> 객체 (articleList)
		ArrayList<ReviewBean> articleList = dao.getByStoreList();
		System.out.println("getByStoreList() - articleList : " + articleList);
		// 공통작업-4. Connection 객체 반환
		close(con);
		
		return articleList;
	}

}

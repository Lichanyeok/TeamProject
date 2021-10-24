package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.ReviewDAO;
import vo.ReviewBean;

public class ReviewModifyProService {
	public Boolean isArticleWrite(String rev_name, String rev_pass) {
		System.out.println("ReviewModifyProService - isArticleWrite()");
		boolean isArticleWriter = false;
		
		// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
		Connection con = getConnection();
				
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();

		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
				
		// BoardDAO 객체의 isBoardArticleWriter() 메서드 호출하여 패스워드 확인 작업 요청
		// => 파라미터 : 글번호, 패스워드 리턴타입 : BoardBean(isArticleWriter)
		isArticleWriter = dao.isArticleWriter(rev_name, rev_pass);	
		System.out.println("isArticleWriter : " + isArticleWriter);
		
		// 공통작업-4. Connection 객체 반환
		close(con);
		
		return isArticleWriter;
	} // isArticleWrite() 메서드 끝
	
	public boolean modifyArticle(ReviewBean rb) {
		System.out.println("ReviewModifyProService - removeArticle()");
		
		boolean isModifyArticleSuccess = false;
		
		// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
		Connection con = getConnection();
				
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();
		
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
						
		// 글 삭제 위해 BoardDAO 객체의 removeArticle() 메서드 호출
		// => 파라미터 : 글번호(board_num) 리턴타입 : int(deleteCount)
		int modifyCount = dao.updateArticle(rb);
		
		// 수정 결과 판별
		if(modifyCount > 0) { // 삭제 성공 시 (=true)
			commit(con);
			isModifyArticleSuccess = true;
		} else { // 실패 시 (=false)
			rollback(con);
		}
		
		// 공통작업-4. Connection 객체 반환
		close(con);
		
		System.out.println("Service_isModifyArticleSuccess : " + isModifyArticleSuccess);
		return isModifyArticleSuccess;
	} // removeArticle() 메서드 끝
}

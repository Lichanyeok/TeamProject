package svc;

import static db.jdbcUtil.close;
import static db.jdbcUtil.getConnection;

import java.sql.Connection;

import dao.BoardDAO;
import vo.BoardBean;


public class detailCustommerCommentService {

	public BoardBean  getdetailCustommerComment(int num) {
		System.out.println("detailCustommerCommentService, num의값 : " + num);
		BoardBean comment = null;
		Connection con = getConnection();
		
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달
		dao.setConnection(con);
		
		comment = dao.checkNum(num);
		System.out.println("detailComment의 service : " + comment);
		close(con);	
		return comment;
	}
	
	public void increseReadcount(int num) {

		Connection con = getConnection();
		
		// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);

		// -> 파라미터 : 글번호(board_num) 리턴타입 : int(updateCount)
		// -> create method로 생성
		dao.updateReadcount(num);
		
		close(con);
		
	}
	
}

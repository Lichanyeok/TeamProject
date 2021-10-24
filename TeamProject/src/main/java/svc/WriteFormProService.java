package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.BoardDAO;
import db.jdbcUtil;
import vo.BoardBean;

public class WriteFormProService {

	public boolean registComment(BoardBean board) {
		System.out.println("WriteFormProService.java");
		boolean isWriteSuccess = false;
		Connection con = jdbcUtil.getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setConnection(con);
		
		int insertCount = dao.insertComment(board);
		
		System.out.println("insertCount의 값은" +insertCount);
		if(insertCount >0) {
//			JdbcUtil.commit(con);
			commit(con);
			isWriteSuccess=true;
		}else {
//			JdbcUtil.rollback(con);
			rollback(con);
		}
		
		return isWriteSuccess;
	}

}

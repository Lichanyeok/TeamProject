package svc;

import static db.jdbcUtil.close;
import static db.jdbcUtil.getConnection;

import java.sql.Connection;

import dao.BoardDAO;

public class DeleteCommentService
{

	public boolean DeleteComment(int num)
	{
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setConnection(con);
		
		boolean DeleteSuccess = dao.DeleteComment(num);
		System.out.println("DeleteSuccess"+DeleteSuccess); //여기로 안 넘어온다
		close(con);	
		
		return DeleteSuccess;
		
	}

}

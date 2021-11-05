package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.BoardDAO;
import db.jdbcUtil;
import vo.ReplyComment;

public class ReplyCommentService
{

	public boolean replyComment(ReplyComment reply, int num)
	{
		System.out.println("ReplyCommentService");
		boolean isWriteSuccess = false;
		Connection con = jdbcUtil.getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setConnection(con);
		
		int insertCount = dao.insertReply(reply, num);
		
		System.out.println("insertCount의 값은" +insertCount);
		if(insertCount >0) {
			commit(con);
			isWriteSuccess=true;
		}else {
			rollback(con);
		}
		
		close(con);
		return isWriteSuccess;
	}

	public ArrayList<ReplyComment> selectReply(int num)
	{
		System.out.println("selectReply");
		Connection con = jdbcUtil.getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setConnection(con);
		
		ArrayList<ReplyComment> replycomment = dao.getReplyComment(num);
		close(con);
		return replycomment;
	}

}

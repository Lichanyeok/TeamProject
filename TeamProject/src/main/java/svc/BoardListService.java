package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.BoardDAO;
import vo.BoardBean;

public class BoardListService {

	public int getListCount() {
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setConnection(con);
		int listCount = dao.selectListCount();
		System.out.println("listCount = " + listCount);
		close(con);
		
		return listCount;
	}

	public ArrayList<BoardBean> getCommentList(int page, int limit) {
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setConnection(con);
		System.out.println("BoardListService의 getCommentList입니다");
		ArrayList<BoardBean> articleList = dao.getCommentList(page,limit);
		close(con);
		
		return articleList;
	}
	
}

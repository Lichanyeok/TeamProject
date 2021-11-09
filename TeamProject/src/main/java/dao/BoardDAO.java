package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.BoardBean;
import vo.ReplyComment;

import static db.jdbcUtil.*;

public class BoardDAO {
	
	private BoardDAO() {
		
	}
	
	private static BoardDAO instance;
	
	public static BoardDAO getInstance() {
		System.out.println("getConnection");
		if(instance == null) {
			instance = new BoardDAO();
		}
		
		return instance;
	}

	Connection con;
	
	public void setConnection(Connection con) {
		System.out.println("setConnection");
		this.con = con;
	}
	//----------------------------------------------------------
	public static String getRandomStr(int size) {
		if(size > 0) {
			char[] tmp = new char[size];
			for(int i=0; i<tmp.length; i++) {
				int div = (int) Math.floor( Math.random() * 2 );
				
				if(div == 0) { 
					tmp[i] = (char) (Math.random() * 10 + '0') ;
				}else { 
					tmp[i] = (char) (Math.random() * 26 + 'A') ;
				}
			}
			return new String(tmp);
		}
		return "ERROR : Size is required."; 
	}
	
	//----------------------------------------------------------
	public int insertComment(BoardBean board) {
		int insertCount=0;
		System.out.println("DAO의 insertCommnet");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "SELECT MAX(num) FROM CustomerComment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
		
			close(pstmt);
			
		
				sql = "insert into CustomerComment values(null,?,?,?,?,?,now())";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, board.getId());
				pstmt.setString(2, board.getSubject());
				pstmt.setString(3, board.getContent());
				pstmt.setInt(4, board.getReadcount()); // readcount 0부터 시작
				pstmt.setString(5,board.getSecretCheck());
				insertCount = pstmt.executeUpdate();
			
			
			
		} catch (SQLException e) {
			System.out.println("insertComment() 오류: " + e.getMessage());
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return insertCount;
	}
	
	//------------------------------------------------------------------------
	
	public int selectListCount() {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM CustomerComment";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			System.out.println("DAO selectListCount");
			if(rs.next()) {
				listCount = rs.getInt(1); 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	//------------------------------------------------------------------------
	
	public ArrayList<BoardBean> getCommentList(int page, int limit) {
		
		ArrayList<BoardBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
//		int startRow = (page -1) * limit;
		
		try {
			
			String sql = "select * from CustomerComment";
			pstmt = con.prepareStatement(sql);
			System.out.println("DAO의 getCommentList");
			rs = pstmt.executeQuery();
			
			articleList = new ArrayList<BoardBean>();
			
			while(rs.next())
			{
				BoardBean board = new BoardBean();
//				System.out.println(rs.getString("secretCheck"));
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setSubject(rs.getString("subject"));
				board.setDate(rs.getDate("date"));
				board.setSecretCheck(rs.getString("secretCheck"));
				board.setReadcount(rs.getInt("readcount"));
				
				articleList.add(board);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("insertComment() 오류: " + e.getMessage());
		}finally {
			close(rs);
			close(pstmt);
		
		}
		
		return articleList;
	}
	
	public BoardBean checkNum(int num) {
		BoardBean comment = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("DAO의 checkNum, num의 값은"+num);
		try {
			
			String sql = "select * from CustomerComment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				comment = new BoardBean();
				comment.setContent(rs.getString("content"));
				comment.setDate(rs.getDate("date"));
				comment.setId(rs.getString("id")); // 나중에 자신의 비밀글 확인할때 비교용으로 필요
				comment.setSubject(rs.getString("subject"));
				comment.setReadcount(rs.getInt("readcount"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("DAO checkNum에서 오류발생 : " + e.getMessage());
		}finally {
			close(rs);
			close(pstmt);
		
		}
		
		
		return comment;
	}
	
		public void updateReadcount(int num) {
		
			PreparedStatement pstmt = null;
		
			try {
				String sql ="update CustomerComment set readcount=readcount+1 where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
				
				commit(con);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				close(pstmt);
		}
		
	}
		public int insertReply(ReplyComment reply, int num)
		{
			int insertCount=0;
			System.out.println("DAO의 insertReply");
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				
				String sql = "SELECT MAX(idx) FROM replyComment";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
			
				close(pstmt);
				
			
					sql = "insert into replyComment values(?,?,?,now())";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, reply.getId());
					pstmt.setString(3, reply.getContent());
					insertCount = pstmt.executeUpdate();
				
				
				
			} catch (SQLException e) {
				System.out.println("insertReply() 오류: " + e.getMessage());
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}
			return insertCount;
		}
		
		public ArrayList<ReplyComment> getReplyComment(int num)
		{
			ArrayList<ReplyComment> replycomment=null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				
				String sql = "select * from replycomment where idx=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				System.out.println("DAO의 getReplyComment");
				rs = pstmt.executeQuery();

				replycomment = new ArrayList<ReplyComment>();
			
				
				while(rs.next())
				{
					ReplyComment reply = new ReplyComment();
					reply.setId(rs.getString("id"));
					reply.setContent(rs.getString("content"));
					reply.setDate(rs.getDate("date"));
					
					replycomment.add(reply);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			
			}
			
			return replycomment;
		}
		public boolean DeleteComment(int num)
		{
			System.out.println("DAO의 DeleteComment");
			PreparedStatement pstmt = null;
//			ResultSet rs = null; rs가 null값으로 저장되어 있어서 nullpointexception이 발생
			boolean DeleteSuccess = false;
			try {
					String sql = "delete from customercomment where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					int DeleteCount = pstmt.executeUpdate();
					
					if(DeleteCount>0) {
						DeleteSuccess=true;
						commit(con);
					}else {
						rollback(con);
					}
					
					close(pstmt);
					
					sql = "delete from replycomment where idx=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					DeleteCount = pstmt.executeUpdate();
					
					if(DeleteCount>0) {
						DeleteSuccess=true;
						commit(con);
					}else {
						rollback(con);
					}
				System.out.println(DeleteCount);
				
				
			} catch (SQLException e) {
				System.out.println("DeleteComment() 오류: " + e.getMessage());
				e.printStackTrace();
			}finally {
//				close(rs);
				close(pstmt);
				
			}
			return DeleteSuccess;
		}
}

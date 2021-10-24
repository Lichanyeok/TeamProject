package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.BoardBean;
import vo.SearchBean;

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
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			String sql = "SELECT MAX(board_num) FROM mvc_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			
			// �떎�쓬 �옉�뾽�쓣 �쐞�빐 PreparedStatement 媛앹껜 諛섑솚
			// �븯�굹�쓽 硫붿꽌�뱶�뿉�꽌 蹂듭닔媛쒖쓽 PreparedStatement 媛� �깮�꽦�릺�뒗 寃껋쓣 諛⑹�
			close(pstmt);
			
			sql = "insert into CustomerComment values(null,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			System.out.println(board.getSubject()+", " + board.getContent() + ", " + board.getName());
			pstmt.setString(1, board.getName());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, 0); //readCount 0遺��꽣
			System.out.println("DAO�쓽 insertComment");
			insertCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.out.println("insertComment() �삤瑜� - " + e.getMessage());
			e.printStackTrace();
		}finally {
			// �옄�썝 諛섑솚(二쇱쓽! Connection 媛앹껜�뒗 DAO �뿉�꽌 諛섑솚�븯吏� �븡�룄濡� �빐�빞�븳�떎!)
//			if(rs != null) try { rs.close(); } catch(Exception e) {}
//			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
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
			// 3�떒怨�. SQL 援щЦ �옉�꽦 諛� �쟾�떖
			// => �쟾泥� �젅肄붾뱶 媛��닔瑜� 議고쉶�븯湲� �쐞�빐 COUNT(*) �븿�닔 �궗�슜(�삉�뒗 COUNT(num))
			String sql = "SELECT COUNT(*) FROM CustomerComment";
			pstmt = con.prepareStatement(sql);
			
			// 4�떒怨�. SQL 援щЦ �떎�뻾 諛� 寃곌낵 泥섎━
			rs = pstmt.executeQuery();
			System.out.println("DAO�쓽 selectListCount");
			if(rs.next()) {
				listCount = rs.getInt(1); // �삉�뒗 "COUNT(*)" 吏��젙
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// �옄�썝 諛섑솚
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
		
		//議고쉶 �떆�옉 寃뚯떆臾�(�젅肄붾뱶) 踰덊샇 怨꾩궛(= �뻾 踰덊샇 怨꾩궛)
		int startRow = (page -1) * limit;
		
		try {
			
			String sql = "select * from CustomerComment";
			pstmt = con.prepareStatement(sql);
			System.out.println("DAO�쓽 getCommentList");
			rs = pstmt.executeQuery();
			
			articleList = new ArrayList<BoardBean>();
			
			while(rs.next())
			{
				BoardBean board = new BoardBean();
				board.setNum(rs.getInt("num"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setDate(rs.getDate("date"));
				board.setReadcount(rs.getInt("readcount"));
				
				articleList.add(board);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// �옄�썝 諛섑솚
//			if(rs != null) try { rs.close(); } catch(Exception e) {}
//			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
//			if(con != null) try { con.close(); } catch(Exception e) {}
			close(rs);
			close(pstmt);
		
		}
		
		return articleList;
	}
}

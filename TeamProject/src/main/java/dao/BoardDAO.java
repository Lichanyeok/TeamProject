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
	public int insertComment(BoardBean board) {
		int insertCount=0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			String sql = "SELECT MAX(board_num) FROM mvc_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			
			// 다음 작업을 위해 PreparedStatement 객체 반환
			// 하나의 메서드에서 복수개의 PreparedStatement 가 생성되는 것을 방지
			close(pstmt);
			
			sql = "insert into CustomerComment values(null,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			System.out.println(board.getSubject()+", " + board.getContent() + ", " + board.getName());
			pstmt.setString(1, board.getName());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, 0); //readCount 0부터
			System.out.println("DAO의 insertComment");
			insertCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.out.println("insertComment() 오류 - " + e.getMessage());
			e.printStackTrace();
		}finally {
			// 자원 반환(주의! Connection 객체는 DAO 에서 반환하지 않도록 해야한다!)
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
			// 3단계. SQL 구문 작성 및 전달
			// => 전체 레코드 갯수를 조회하기 위해 COUNT(*) 함수 사용(또는 COUNT(num))
			String sql = "SELECT COUNT(*) FROM CustomerComment";
			pstmt = con.prepareStatement(sql);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			System.out.println("DAO의 selectListCount");
			if(rs.next()) {
				listCount = rs.getInt(1); // 또는 "COUNT(*)" 지정
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
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
		
		//조회 시작 게시물(레코드) 번호 계산(= 행 번호 계산)
		int startRow = (page -1) * limit;
		
		try {
			
			String sql = "select * from CustomerComment";
			pstmt = con.prepareStatement(sql);
			System.out.println("DAO의 getCommentList");
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
			// 자원 반환
//			if(rs != null) try { rs.close(); } catch(Exception e) {}
//			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
//			if(con != null) try { con.close(); } catch(Exception e) {}
			close(rs);
			close(pstmt);
		
		}
		
		return articleList;
	}
}

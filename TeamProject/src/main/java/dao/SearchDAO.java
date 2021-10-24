package dao;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.SearchBean;

public class SearchDAO {
	private SearchDAO() {
		
	}
	
	private static SearchDAO instance;
	
	public static SearchDAO getInstance() {
//		System.out.println("getConnection");
		if(instance == null) {
			instance = new SearchDAO();
		}
		
		return instance;
	}

	Connection con;
	
	public void setConnection(Connection con) {
//		System.out.println("setConnection");
		this.con = con;
	}	

	public int ListCount() {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM search";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
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

	public ArrayList<SearchBean> ArticleList(int page, int maximum, String category) {
		ArrayList<SearchBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 조회 시작 게시물(레코드) 번호 계산(= 행 번호 계산)
		int startRow = (page - 1) * maximum;
		
		try {
			String sql = "SELECT * FROM search WHERE category=? LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setInt(2, startRow); // 시작행번호
			pstmt.setInt(3, maximum); // 페이지당 게시물 수
			
			rs = pstmt.executeQuery();
			
			articleList = new ArrayList<SearchBean>();
			
			while(rs.next()) {
				SearchBean search = new SearchBean();
				search.setRoad_address(rs.getString("road_address"));
				search.setJibun_address(rs.getString("jibun_address"));
				search.setCategory(rs.getString("category"));
				search.setPlace_name(rs.getString("place_name"));
				search.setStar_score(rs.getFloat("star_score"));
				search.setTell_number(rs.getString("tell_number"));
				
				// 1개 레코드가 저장된 BoardBean 객체를 List 객체에 추가
				articleList.add(search);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
 		} finally {
			// 자원 반환
 			close(rs);
 			close(pstmt);
		}
		
		return articleList;
	
	}
	public SearchBean Info(String jibun_address, String tell_number) {
		SearchBean details = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM Search WHERE jibun_address=? OR tell_number=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, jibun_address);
			pstmt.setString(2, tell_number);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				details = new SearchBean();
				details.setRoad_address(rs.getString("road_address"));
				details.setJibun_address(rs.getString("jibun_address"));
				details.setCategory(rs.getString("category"));
				details.setPlace_name(rs.getString("place_name"));
				details.setStar_score(rs.getFloat("star_score"));
				details.setTell_number(rs.getString("tell_number"));
				
				commit(con);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
 			close(rs);
 			close(pstmt);
		}
		
		return details;
	}

}

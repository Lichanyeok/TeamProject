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

	public int ListCount(String category) {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM search WHERE category=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);
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

	public ArrayList<SearchBean> ArticleList(String category) {
		ArrayList<SearchBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		
		try {
			String sql = "SELECT * FROM search WHERE category=? "
					+ "ORDER BY star_score DESC LIMIT 0,10";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);
			
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
			String sql = "SELECT * FROM search WHERE jibun_address=? OR tell_number=?";
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
			}else {
				rollback(con);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
 			close(rs);
 			close(pstmt);
		}
		
		return details;
	}
	
	public boolean updateStar(String rev_store) {
		boolean updateSuccess=false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		float avgStar=0;
		try {
			String sql = "SELECT AVG(rev_score) FROM review WHERE rev_store=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rev_store);			
			rs = pstmt.executeQuery();			
			if(rs.next()) {				
				avgStar=rs.getFloat(1);
			}
			close(pstmt);
			sql="UPDATE search SET star_score=? WHERE place_name=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setFloat(1, avgStar);
			pstmt.setString(2, rev_store);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
 			close(rs);
 			close(pstmt);
		}
		
		return updateSuccess;
	}

}





































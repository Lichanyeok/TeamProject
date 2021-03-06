package dao;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ReserveBean;
import vo.ReviewBean;
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
			String sql = "SELECT COUNT(*) FROM business WHERE category=?";
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
			String sql = "SELECT * FROM business WHERE category=? AND app_check='Y' "
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
				search.setLogo_img(rs.getString("logo_img"));
				search.setDate(rs.getDate("date"));
				search.setRecommend(rs.getInt("recommend"));
				
				// 1??? ???????????? ????????? BoardBean ????????? List ????????? ??????
				articleList.add(search);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
 		} finally {
			// ?????? ??????
 			close(rs);
 			close(pstmt);
		}
		
		return articleList;
	
	}	
	
	public SearchBean Info(String tell_number) {
		SearchBean details = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM business WHERE tell_number=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tell_number);		
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				details = new SearchBean();
				details.setId(rs.getString("id"));
				details.setPlace_name(rs.getString("place_name"));
				details.setBusiness_lisence(rs.getString("business_lisence"));
				details.setCategory(rs.getString("category"));
				details.setTell_number(rs.getString("tell_number"));
				details.setRoad_address(rs.getString("road_address"));
				details.setJibun_address(rs.getString("jibun_address"));
				details.setLogo_img(rs.getString("logo_img"));
				details.setStar_score(rs.getFloat("star_score"));
				details.setDate(rs.getDate("date"));
				details.setRecommend(rs.getInt("recommend"));
				
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
	
	public boolean updateStar(ReviewBean bean)  {
		boolean updateSuccess=false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		float avgStar=0;
		try {
			String sql = "SELECT AVG(rev_score) FROM review WHERE rev_store=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getRev_store());			
			rs = pstmt.executeQuery();			
			if(rs.next()) {				
				avgStar=rs.getFloat(1);
			}
			close(pstmt);
			sql="UPDATE business SET star_score=? WHERE place_name=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setFloat(1, avgStar);
			pstmt.setString(2, bean.getRev_store());
			int success=pstmt.executeUpdate();
			if(success>0) {
				updateSuccess=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
 			close(rs);
 			close(pstmt);
		}
		return updateSuccess;
	}

	public int listInsert(SearchBean bean) {		
		
		PreparedStatement pstmt = null;	
		int count=0;
		try {
			String sql = "INSERT INTO business VALUES (?,?,?,?,?,?,?,?,?,0,now(),0,'N')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,bean.getId());
			pstmt.setString(2, bean.getPlace_name());
			pstmt.setString(3,bean.getBusiness_lisence());
			pstmt.setString(4, bean.getCategory());
			pstmt.setString(5, bean.getTell_number());
			pstmt.setString(6, bean.getRoad_address());
			pstmt.setString(7, bean.getJibun_address());
			if(bean.getLogo_img()==null) {
				pstmt.setString(8, "no_img.jpg");
				pstmt.setString(9, "no_img.jpg");
			}else {
				pstmt.setString(8, bean.getLogo_img());
				pstmt.setString(9, bean.getOri_logo_img());
			}
			
			count =pstmt.executeUpdate();	
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally { 			
 			close(pstmt);
		}
		
		return count;		
	}

	public SearchBean selectID(String id) {
		SearchBean search = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM business WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);		
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				search = new SearchBean();
				search.setId(rs.getString("id"));
				search.setPlace_name(rs.getString("place_name"));
				search.setBusiness_lisence(rs.getString("business_lisence"));
				search.setCategory(rs.getString("category"));
				search.setTell_number(rs.getString("tell_number"));
				search.setRoad_address(rs.getString("road_address"));
				search.setJibun_address(rs.getString("jibun_address"));
				search.setLogo_img(rs.getString("logo_img"));
				search.setStar_score(rs.getFloat("star_score"));
				search.setDate(rs.getDate("date"));
				search.setRecommend(rs.getInt("recommend"));
				
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
		
		return search;
	}

	public int listUpdate(SearchBean bean) {

		PreparedStatement pstmt = null;	
		int count=0;
		try {
			String sql = "UPDATE business SET place_name=?,business_lisence=?,category=?,tell_number=?,road_address=?,jibun_address=?,logo_img=?,ori_logo_img=?"
					+ " WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPlace_name());
			pstmt.setString(2, bean.getBusiness_lisence());
			pstmt.setString(3, bean.getCategory());
			pstmt.setString(4, bean.getTell_number());
			pstmt.setString(5, bean.getRoad_address());
			pstmt.setString(6, bean.getJibun_address());
			if(bean.getLogo_img()==null) {
				pstmt.setString(7, "no_img.jpg");
				pstmt.setString(8, "no_img.jpg");
			}else {
				pstmt.setString(7, bean.getLogo_img());
				pstmt.setString(8, bean.getOri_logo_img());
			}
			pstmt.setString(9,bean.getId());
			
			count =pstmt.executeUpdate();	
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally { 			
 			close(pstmt);
		}
		
		return count;		
	}
	
	public ArrayList<SearchBean> getAddStoreList() {
		ArrayList<SearchBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		
		try {
			String sql = "SELECT * FROM business WHERE app_check='N' "
					+ "ORDER BY star_score DESC LIMIT 0,10";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			articleList = new ArrayList<SearchBean>();
			
			while(rs.next()) {
				SearchBean search = new SearchBean();
				search.setId(rs.getString("id"));
				search.setRoad_address(rs.getString("road_address"));
				search.setJibun_address(rs.getString("jibun_address"));
				search.setCategory(rs.getString("category"));
				search.setBusiness_lisence(rs.getString("business_lisence"));
				search.setPlace_name(rs.getString("place_name"));
				search.setStar_score(rs.getFloat("star_score"));
				search.setTell_number(rs.getString("tell_number"));
				search.setLogo_img(rs.getString("logo_img"));
				search.setDate(rs.getDate("date"));
				search.setRecommend(rs.getInt("recommend"));
				
				// 1??? ???????????? ????????? BoardBean ????????? List ????????? ??????
				articleList.add(search);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
 		} finally {
			// ?????? ??????
 			close(rs);
 			close(pstmt);
		}
		
		return articleList;
	
	}

	public int updateStore(String lisence) {
		System.out.println("dao : " +lisence);
		int updateCount = 0;
		PreparedStatement pstmt = null;
		try {
			String sql = "UPDATE business SET app_check='Y' WHERE business_lisence=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, lisence);
			updateCount = pstmt.executeUpdate();
			if(updateCount>0) {
				commit(con);
				System.out.println("?????? ?????? - DAO");
			}else {
				rollback(con);
				System.out.println("?????? ?????? - DAO");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return updateCount;
	}

	public ArrayList<SearchBean> TestArticleList() {
		ArrayList<SearchBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		
		try {
			String sql = "SELECT * FROM business";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			articleList = new ArrayList<SearchBean>();
			
			while(rs.next()) {
				SearchBean search = new SearchBean();
				search.setId(rs.getString("id"));
				search.setPlace_name(rs.getString("place_name"));
				search.setBusiness_lisence(rs.getString("business_lisence"));
				search.setCategory(rs.getString("category"));
				search.setTell_number(rs.getString("tell_number"));
				search.setRoad_address(rs.getString("road_address"));
				search.setJibun_address(rs.getString("jibun_address"));
				search.setLogo_img(rs.getString("logo_img"));
				search.setOri_logo_img(rs.getString("ori_logo_img"));
				search.setStar_score(rs.getFloat("star_score"));
				search.setDate(rs.getDate("date"));
				search.setRecommend(rs.getInt("recommend"));			
				
				// 1??? ???????????? ????????? BoardBean ????????? List ????????? ??????
				articleList.add(search);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
 		} finally {
			// ?????? ??????
 			close(rs);
 			close(pstmt);
		}
		
		return articleList;
	}

}






































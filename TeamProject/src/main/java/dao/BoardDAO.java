package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	public static String getRandomStr(int size) { //���� �߻� �޼��� size�� ũ�� ����
		if(size > 0) {
			char[] tmp = new char[size];
			for(int i=0; i<tmp.length; i++) {
				int div = (int) Math.floor( Math.random() * 2 );
				
				if(div == 0) { // 0�̸� ���ڷ�
					tmp[i] = (char) (Math.random() * 10 + '0') ;
				}else { //1�̸� ���ĺ�
					tmp[i] = (char) (Math.random() * 26 + 'A') ;
				}
			}
			return new String(tmp);
		}
		return "ERROR : Size is required."; 
	}

	public int ListCount() {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM mvc_board";
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

	public ArrayList<SearchBean> ArticleList(int page, int maximum) {
		ArrayList<SearchBean> articleList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 조회 시작 게시물(레코드) 번호 계산(= 행 번호 계산)
		int startRow = (page - 1) * maximum;
		
		try {
			String sql = "SELECT * FROM search LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow); // 시작행번호
			pstmt.setInt(2, maximum); // 페이지당 게시물 수
			
			rs = pstmt.executeQuery();
			
			articleList = new ArrayList<SearchBean>();
			
			while(rs.next()) {
				SearchBean search = new SearchBean();
				search.setRoad_address(rs.getString("road_address"));
				search.setJibun_address(rs.getString("jibun_address"));
				search.setCategory(rs.getString("category"));
				search.setPlace_name(rs.getString("place_name"));
				search.setStar_scroe(rs.getFloat("star_scroe"));
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

}

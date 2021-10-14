package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.MemberBean;
import static db.jdbcUtil.*;
public class MemberDAO {
	
	
	
	private MemberDAO() {
		
	}
	
	private static MemberDAO instance;
	
	public static MemberDAO getInstance() {
		System.out.println("getConnection");
		if(instance == null) {
			instance = new MemberDAO();
		}
		
		return instance;
	}

	Connection con;
	
	public void setConnection(Connection con) {
		System.out.println("setConnection");
		this.con = con;
	}

	public boolean selectMember(MemberBean bean) {
		System.out.println("selectMember()");
		boolean isLoginSuccess = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			 String sql = "SELECT pass,nickname,grade FROM project_member WHERE id=?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, bean.getId());
	         
	         // 4단계. SQL 구문 실행 및 결과 처리
	         rs = pstmt.executeQuery();
	         
	         // if문을 사용하여 ResultSet 객체의 조회 결과 존재 여부 판별
	         if(rs.next()) {
	            // 조회된 결과(레코드)가 존재할 경우
	            // => pass 컬럼 데이터를 입력받은 패스워드(pass)와 비교하여
	            //    일치하면 isLoginSccuess 변수에 true 값 저장(아니면 기본값 false 사용)
	            if(bean.getPass().equals(rs.getString("pass"))) {
	            	bean.setNickName(rs.getString("nickname"));
	            	bean.setGrade(rs.getInt("grade"));
	            	isLoginSuccess = true; // 패스워드 일치
	            } 
	         }
		} catch (SQLException e) {
			System.out.println("selectMember sql 오류!");
			e.printStackTrace();
		}
		
		return isLoginSuccess;
	}

	public boolean insertMember(MemberBean bean) {
		System.out.println("insertMember - DAO");
		boolean isInsertSuccess=false;
		PreparedStatement pstmt = null;
		
		try {
			String sql="INSERT INTO project_member VALUES(null,?,?,?,?,?,?,?,?,?,now())";
			
			pstmt = con.prepareStatement(sql);
	
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getNickName());
			pstmt.setInt(3, bean.getAge());
			pstmt.setString(4, bean.getId());
			pstmt.setString(5, bean.getPass());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getMobile());
			pstmt.setString(8, bean.getGender());
			pstmt.setInt(9, 1);
			
			int result = pstmt.executeUpdate();
//			System.out.println(result);
			if(result>0) {
				isInsertSuccess = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return isInsertSuccess;
	}
	
}

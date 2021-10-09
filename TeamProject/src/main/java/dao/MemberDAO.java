package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.MemberBean;

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
			 String sql = "SELECT pass,nickname FROM project_member WHERE id=?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, bean.getId());
	         
	         // 4�ܰ�. SQL ���� ���� �� ��� ó��
	         rs = pstmt.executeQuery();
	         
	         // if���� ����Ͽ� ResultSet ��ü�� ��ȸ ��� ���� ���� �Ǻ�
	         if(rs.next()) {
	            // ��ȸ�� ���(���ڵ�)�� ������ ���
	            // => pass �÷� �����͸� �Է¹��� �н�����(pass)�� ���Ͽ�
	            //    ��ġ�ϸ� isLoginSccuess ������ true �� ����(�ƴϸ� �⺻�� false ���)
	            if(bean.getPass().equals(rs.getString("pass"))) {
	            	bean.setNickName(rs.getString("nickname"));
	            	isLoginSuccess = true; // �н����� ��ġ
	            } 
	         }
		} catch (SQLException e) {
			System.out.println("selectMember sql ����!");
			e.printStackTrace();
		}
		
		return isLoginSuccess;
	}
}

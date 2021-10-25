package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import static db.jdbcUtil.*;
import vo.ReserveBean;

public class ReserveDAO {
private ReserveDAO() {
		
	}
	
	private static ReserveDAO instance;
	
	public static ReserveDAO getInstance() {
		System.out.println("getConnection");
		if(instance == null) {
			instance = new ReserveDAO();
		}
		
		return instance;
	}

	Connection con;
	
	public void setConnection(Connection con) {
		System.out.println("setConnection");
		this.con = con;
	}

	public boolean insertReserve(ReserveBean reserve) {
		boolean isInsertSuccess = false;
		int insertCount=0;
		String reserve_code = getRandomStr(15);
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO reserve VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,now()) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,reserve_code);
			pstmt.setString(2,reserve.getId());
			pstmt.setString(3, reserve.getStoreName());
			pstmt.setString(4, reserve.getLoadAddress());
			pstmt.setString(5, reserve.getAddress());
			pstmt.setString(6, reserve.getStoreNumber());
			pstmt.setString(7, reserve.getReserve_date());
			pstmt.setString(8, reserve.getReserve_time());
			pstmt.setInt(9, reserve.getPeople());
			pstmt.setString(10, reserve.getTotal_order_menu());
			pstmt.setString(11, reserve.getCustomerNeeds());
			pstmt.setInt(12, 1);
			pstmt.setInt(13, 0);
			insertCount = pstmt.executeUpdate();
			if(insertCount > 0) {
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

	public boolean removeCoupon(String used_coupon_code) {
		System.out.println("removeCoupon - DAO : " + used_coupon_code );
		boolean isRemoveSuccess = false;
		PreparedStatement pstmt = null;
		System.out.println(used_coupon_code);
		try {
			String sql = "DELETE FROM coupon WHERE coupon_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, used_coupon_code);
			int removeCount = pstmt.executeUpdate();
			if(removeCount>0) {
				isRemoveSuccess = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return isRemoveSuccess;
	}
}

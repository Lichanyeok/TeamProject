package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.fabric.xmlrpc.base.Array;

import static db.jdbcUtil.*;

import vo.MemberBean;
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
			String sql = "INSERT INTO reserve VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,0,now()) ";
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
			pstmt.setInt(13, reserve.getPayment_price());
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

	public ArrayList<ReserveBean> getReserveList(String sId, int page, int limit) {
		ArrayList<ReserveBean> reserveList = new ArrayList<ReserveBean>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReserveBean bean = null;
		int startRow = (page - 1) * limit;
		try {
			String sql ="SELECT * FROM reserve WHERE reserve_user=? ORDER BY reserve_date DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sId);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean = new ReserveBean();
				bean.setRan_num(rs.getString("ran_num"));
				bean.setId(rs.getString("reserve_user"));
				bean.setStoreName(rs.getString("store_name"));
				bean.setLoadAddress(rs.getString("store_load_adress"));
				bean.setAddress(rs.getString("store_adress"));
				bean.setStoreNumber(rs.getString("store_phone"));
				bean.setReserve_date(rs.getString("reserve_date"));
				bean.setReserve_time(rs.getString("reserve_time"));
				bean.setPeople(rs.getInt("reserve_people"));
				bean.setTotal_order_menu(rs.getString("reserve_menu"));
				bean.setCustomerNeeds(rs.getString("customer_request"));
				bean.setReserve_type(rs.getInt("reserve_type"));
				bean.setCheck_review(rs.getInt("check_review"));
				bean.setPayment_price(rs.getInt("payment_price"));
				reserveList.add(bean);
			}
			System.out.println("getReserveList DAO reserveList size : " + reserveList.size() + ", sId : " + sId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return reserveList;
	}
	
	public int selectListCount(String sId) {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM reserve WHERE reserve_user=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				listCount = rs.getInt(1); 
			}
			System.out.println("SELECT List COUNT : " + listCount);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}

	public int insertLocalPayment(ReserveBean reserve) {
		System.out.println("insertLocalPayment DAO");
		int insertCount=0;
		String reserve_code = getRandomStr(15);
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO reserve VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,0,now()) ";
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
			pstmt.setInt(12, 0);
			pstmt.setInt(13, reserve.getPayment_price());
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return insertCount;
	}

	public boolean isRightUser(MemberBean bean) {
		System.out.println("isRightUser DAO");
		boolean isRightUser = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql="SELECT pass FROM project_member WHERE id=?";
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(bean.getPass().equals(rs.getString(1))) {
					isRightUser = true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return isRightUser;
	}

	public boolean isRightCode(String reserve_code) {
		boolean isRightCode = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT ran_num FROM reserve WHERE ran_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reserve_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				isRightCode = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return isRightCode;
	}

	public ArrayList<ReserveBean> getResList(String reserve_code) {
		System.out.println("getResList DAO : " + reserve_code);
		ArrayList<ReserveBean> resList = new ArrayList<ReserveBean>();
		ReserveBean bean = new ReserveBean();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT * FROM reserve WHERE ran_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reserve_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setRan_num(reserve_code);				
				bean.setStoreName(rs.getString("store_name"));
				bean.setLoadAddress(rs.getString("store_load_adress"));
				bean.setAddress(rs.getString("store_adress"));
				bean.setStoreNumber(rs.getString("store_phone"));
				bean.setReserve_date(rs.getString("reserve_date"));
				bean.setReserve_time(rs.getString("reserve_time"));
				bean.setPeople(rs.getInt("reserve_people"));
				bean.setTotal_order_menu(rs.getString("reserve_menu"));
				bean.setCustomerNeeds(rs.getString("customer_request"));
				bean.setPayment_price(rs.getInt("payment_price"));
				bean.setReserve_type(rs.getInt("reserve_type"));
				resList.add(bean);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return resList;
	}

	public boolean modiRes(ReserveBean bean) {
		boolean isModiResSuccess = false;
		PreparedStatement pstmt = null;
		String sql="UPDATE reserve SET reserve_date=?,reserve_time=?,reserve_people=?,reserve_menu=?,customer_request=? WHERE ran_num=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getReserve_date());
			pstmt.setString(2, bean.getReserve_time());
			pstmt.setInt(3, bean.getPeople());
			pstmt.setString(4, bean.getTotal_order_menu());
			pstmt.setString(5, bean.getCustomerNeeds());
			pstmt.setString(6, bean.getRan_num());
			int updateCount = pstmt.executeUpdate();
			if(updateCount > 0 ) {
				isModiResSuccess = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return isModiResSuccess;
	}

	public boolean reserveCancle(String reserve_code) {
		boolean isCancleSuccess = false;
		PreparedStatement pstmt = null;
		try {
			String sql ="DELETE FROM reserve WHERE ran_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reserve_code);
			int deleteCount = pstmt.executeUpdate();
			if(deleteCount>0) {
				commit(con);
				isCancleSuccess = true;
				System.out.println("���� ����");
			}else {
				rollback(con);
				System.out.println("���� ����");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return isCancleSuccess;
	}
}

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.CouponBean;
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
			String sql="INSERT INTO project_member VALUES(null,?,?,?,?,?,?,?,?,?,?,now(),null)";
			
			pstmt = con.prepareStatement(sql);
	
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getNickName());
			pstmt.setInt(3, bean.getAge());
			pstmt.setString(4, bean.getId());
			pstmt.setString(5, bean.getPass());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getMobile());
			pstmt.setString(8, bean.getAddress());
			pstmt.setString(9, bean.getGender());
			pstmt.setInt(10, 1);
			
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
	
	public int menagementMember(String pass) {
        int insertCount = 0;

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM project_member WHERE pass=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, pass);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                insertCount += 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return insertCount;
    }

    public MemberBean selectArticle(String pass) {
        MemberBean article = null;

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM project_member WHERE pass=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, pass);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new MemberBean();
                article.setName(rs.getString("name"));
                article.setNickName(rs.getString("nickName"));
                article.setGender(rs.getString("gender"));
                article.setAge(rs.getInt("age"));
                article.setEmail(rs.getString("email"));
                article.setId(rs.getString("id"));
                article.setMobile(rs.getString("mobile"));
                article.setPass(rs.getString("pass"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }

        return article;
    }

    public int managementMember(MemberBean member) {
        int updateCount = 0;

        PreparedStatement pstmt = null;

        try {
            String sql = "UPDATE project_member SET name=?,nickname=?,pass=?,mobile=?,gender=?,age=?,email=? WHERE id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, member.getName());
            pstmt.setString(2, member.getNickName());
            pstmt.setString(3, member.getPass());
            pstmt.setString(4, member.getMobile());
            pstmt.setString(5, member.getGender());
            pstmt.setInt(6, member.getAge());
            pstmt.setString(7, member.getEmail());
            pstmt.setString(8, member.getId());

            updateCount = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("updateArticle() 오류 - " + e.getMessage());
        } finally {
            close(pstmt);
        }

        return updateCount;
    }

	public boolean hasNickName(MemberBean bean) {
		System.out.println("hasNickName-DAO");
		boolean hasNickName = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql ="SELECT nickname FROM project_member WHERE nickname=?";
			pstmt = con.prepareStatement(sql);
			System.out.println(bean.getNickName());
			pstmt.setString(1, bean.getNickName());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				hasNickName = true;
			}else {
				hasNickName = false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
            close(pstmt);
        }
		return hasNickName;
	}

	public boolean hasId(MemberBean bean) {
		boolean isDupId = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql ="SELECT id FROM project_member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			rs = pstmt.executeQuery();
			System.out.println(bean.getId());
			if(rs.next()) {
				isDupId = false;
			}else {
				isDupId = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return isDupId;
	}

	public ArrayList<MemberBean> nameAlign() {
		ArrayList<MemberBean> list = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean bean = null;
	
		try {
			System.out.println("nameAlign");
			String sql = "SELECT * FROM project_member ORDER BY name ASC";
			pstmt = con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			list = new ArrayList<MemberBean>();
			while(rs.next()) {
				bean = new MemberBean();
				bean.setIdx(rs.getInt("idx"));
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setNickName(rs.getString("nickName"));
				bean.setGrade(rs.getInt("grade"));
				bean.setDate(rs.getDate("member_date"));
				
				list.add(bean);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
	
	public int selectListCount() {
		int listCount=0;
		System.out.println("selectListCount");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT count(*) FROM project_member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("selectListCount Error");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}

	public ArrayList<MemberBean> dateAlign() {
		ArrayList<MemberBean> list = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean bean = null;
		
		try {
			System.out.println("nameAlign");
			String sql = "SELECT * FROM project_member ORDER BY member_date ASC ";
			pstmt = con.prepareStatement(sql);
		
			rs=pstmt.executeQuery();
			list = new ArrayList<MemberBean>();
			while(rs.next()) {
				bean = new MemberBean();
				bean.setIdx(rs.getInt("idx"));
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setNickName(rs.getString("nickName"));
				bean.setGrade(rs.getInt("grade"));
				bean.setDate(rs.getDate("member_date"));
				
				list.add(bean);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}

	public ArrayList<MemberBean> gradeAlign() {
		ArrayList<MemberBean> list = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean bean = null;
	
		try {
			System.out.println("nameAlign");
			String sql = "SELECT * FROM project_member ORDER BY grade DESC";
			pstmt = con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			list = new ArrayList<MemberBean>();
			while(rs.next()) {
				bean = new MemberBean();
				bean.setIdx(rs.getInt("idx"));
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setNickName(rs.getString("nickName"));
				bean.setGrade(rs.getInt("grade"));
				bean.setDate(rs.getDate("member_date"));
				
				list.add(bean);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}

	public int deleteMember(String id) {
		System.out.println("deleteMember - " + id);
		int isDeleteSuccess = 0;
		PreparedStatement pstmt = null;
		try {
			String sql ="DELETE FROM project_member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			isDeleteSuccess = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return isDeleteSuccess;
	}

	public int modifyGrade(String id, int grade) {
		System.out.println("modifyGrade DAO - " + id + " , " + grade);
		PreparedStatement pstmt = null;
		int isUpdateSuccess = 0;
		try {
			String sql="UPDATE project_member SET grade=? WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, grade);
			pstmt.setString(2, id);
			isUpdateSuccess=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return isUpdateSuccess;
	}

	public void updateDate(MemberBean bean) {
		PreparedStatement pstmt = null;
		
		try {
			String sql = "UPDATE project_member SET login_date=now() WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.executeUpdate();
			commit(con);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public ArrayList<String> selectMemberCount(int coupon_target) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> list = new ArrayList<String>();
		
		try {
			String sql = "SELECT id FROM project_member WHERE grade=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, coupon_target);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString(1));
			}
			System.out.println("selectMemberCount" + list.size());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public int insertCoupon(CouponBean couponB) {
		System.out.println("insertCoupon-DAO");
		int isSuccess = 0;
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO coupon VALUES(?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,couponB.getCoupon_name());
			pstmt.setString(2, couponB.getCoupon_value());
			pstmt.setInt(3, couponB.getCoupon_price());
			pstmt.setString(4, couponB.getCoupon_code());
			pstmt.setString(5, couponB.getUser_id());
			isSuccess = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return isSuccess;
	}
}


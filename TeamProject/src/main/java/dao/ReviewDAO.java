package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ReviewBean;

import static db.jdbcUtil.*;

public class ReviewDAO {
	
	// 1. 생성자 private 접근제한자로 선언
	private ReviewDAO() {}
	
	// 2.인스턴스 생성 후 변수 저장
	private static ReviewDAO instance;
	
	// 3. Getter 메서드 정의하여 인스턴스 리턴
	public static ReviewDAO getInstance() {
		// 기존의 인스턴스가 존재하지 않을 경우에만 인스턴스를 생성
		if(instance == null) {
			instance = new ReviewDAO();
		}
		
		// 인스턴스 리턴
		return instance;
	}
	
	// ---------------------------------------------------------------------
	// DB 작업을 수행하기 위해 사용하는 Connection 타입 멤버변수 선언
	Connection con;
	
	// Connection 객체를 외부로부터 전달받아 저장하기 위한 Setter 메서드 정의
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	// ---------------------------------------------------------------------
	
	// 리뷰 작성을 위한 insertReview() 메서드 정의
	public int insertReview(ReviewBean rb) {
		System.out.println("ReviewDAO - insertReview()");
		int insertCount = 0;
			
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int num = 1; // 새 리뷰 번호를 저장할 변수
		
		try {
			sql = "SELECT MAX(rev_num) FROM review";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			}
			
			close(pstmt);
						
			// 리뷰 등록 작업을 위한 INSERT 작업
			sql = "INSERT INTO review VALUES (?,?,?,?,?,?,?,?,?,now(),0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 계산된 새 글 번호
			pstmt.setString(2, rb.getRan_num());
			pstmt.setString(3, rb.getRev_store());
			pstmt.setString(4, rb.getRev_name());
			pstmt.setFloat(5, rb.getRev_score());
			pstmt.setString(6, rb.getRev_content());
			pstmt.setString(7, rb.getRev_pic());
			pstmt.setString(8, rb.getRev_pic_origin());
			pstmt.setString(9, rb.getRev_menu());
			
			insertCount = pstmt.executeUpdate();
			
			// 파일 확장자가 사진이 아닐 경우 0값 리턴
			if(rb.getRev_pic().equals(null)) {
				insertCount = 0;	
			} 
			
			System.out.println("ReviewDAO - insertCount : " + insertCount);
			
			
		} catch (Exception e) {
			System.out.println("insertReview() 오류 - " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) {}
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
		}
			System.out.println("ReviewDAO - insertCount : " + insertCount);
			return insertCount;
		
		
	}
	
	// 매장의 리뷰 총 갯수 조회하여 리턴하는 selectArticleList() 메서드 정의 
	public ReviewBean selectListCount(String rev_store) { // 필요!
		System.out.println("ReviewDAO - selectListCount()");
		ReviewBean rb = new ReviewBean();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "SELECT COUNT(rev_score) AS score_count, AVG(rev_score) AS score_avg FROM review WHERE rev_store=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rev_store);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rb.setListCount(rs.getInt("score_count"));
				rb.setTotalScore(rs.getFloat("score_avg"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
		}
		
		return rb;
	} // selectListCount() 메서드 끝
	
	// 닉네임별 작성한 총 리뷰 수를 조회하여 리턴하는 selectMyListCount() 메서드 정의
	public int selectMyListCount(String nickName) {
		System.out.println("ReviewDAO - selectMyListCount()");
		
		int myListCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			// 파라미터로 넘겨 받은 id에 해당하는 총 리뷰 수 구하기
			sql = "SELECT COUNT(*) FROM review WHERE rev_name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nickName);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				myListCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
		}
		
		return myListCount;
	}
	
	// 작성한 리뷰를 조회하여 리턴하는 getMyReviewList() 메서드 정의
	public ArrayList<ReviewBean> getMyReviewList(String nickName) {
		ArrayList<ReviewBean> myReviewList = null; // 게시물을 저장할 객체 생성
		System.out.println("ReviewDAO - getMyReviewList()");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "SELECT * FROM review WHERE rev_name=? ORDER BY rev_num DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nickName);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 모든 레코드를 저장할 List 객체(ArrayList) 생성
			myReviewList = new ArrayList<ReviewBean>();
			
			while(rs.next()) {
				ReviewBean rb = new ReviewBean();
				rb.setRev_num(rs.getInt("rev_num"));
				rb.setRev_score(rs.getFloat("rev_score"));
				rb.setRev_store(rs.getString("rev_store"));
				rb.setRev_date(rs.getDate("rev_date"));
				rb.setRev_content(rs.getString("rev_content"));
				rb.setRev_pic(rs.getString("rev_pic"));
				rb.setRev_pic_origin(rs.getString("rev_pic_origin"));
				rb.setRev_menu(rs.getString("rev_menu"));
				rb.setRev_like(rs.getInt("rev_like"));
				rb.setRan_num(rs.getString("ran_num"));
				
				// 1개 레코드가 저장된 ReviewBean 객체를 List 객체에 추가
				myReviewList.add(rb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
		}
		
		return myReviewList;
	}
	
	public ReviewBean selectReview(int rev_num) {
		System.out.println("ReviewDAO - selectReview()");
		ReviewBean rb = null; // 1개 리뷰 상세 정보를 저장하는 ReviewBean 타입 변수 선언
			
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "SELECT * FROM review WHERE rev_num =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
			
			rs = pstmt.executeQuery();
			
			// 조회 결과가 존재할 경우에만 글 내용 표시
			if(rs.next()){
				rb = new ReviewBean();
				rb.setRev_score(rs.getInt("rev_score"));
				rb.setRev_store(rs.getString("rev_store"));
				rb.setRev_name(rs.getString("rev_name"));
				rb.setRev_date(rs.getDate("rev_date"));
				rb.setRev_content(rs.getString("rev_content"));
				rb.setRev_pic(rs.getString("rev_pic"));
				rb.setRev_pic_origin(rs.getString("rev_pic_origin"));
				rb.setRev_menu(rs.getString("rev_menu"));
				
			}
			
		} catch (Exception e) {
			System.out.println("insertArticle() 오류 - " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) {}
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
		}
		
		return rb;
	} // selectReview() 메서드 끝
	
	// 사용자 일치 여부를 확인하기 위한 isArticleWriter() 메서드 정의
	public boolean isArticleWriter(String rev_name, String rev_pass) {
		boolean isArticleWriter = false;
		System.out.println("isArticleWriter id : " + rev_name + " pass : " + rev_pass);
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "SELECT pass FROM project_member WHERE nickName=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rev_name);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rev_pass.equals(rs.getString(1))) {
					isArticleWriter = true;
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
		}
		
		return isArticleWriter;
	} // isArticleWriter() 메서드 끝
	
	// 리뷰 삭제를 위한 deleteArticle() 메서드 정의
	public int deleteArticle(int rev_num) {
		System.out.println("ReviewDAO - deleteArticle()");
		
		int deleteCount = 0;
		PreparedStatement pstmt = null;
		
		try {
			String sql = "DELETE FROM review WHERE rev_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
					
			deleteCount = pstmt.executeUpdate();  // 혹시 삭제가 안됫을때를 대비하여
						
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(pstmt);
		}
		
		
		return deleteCount;
	} // deleteArticle() 메서드 끝
	
	// 리뷰 수정을 위한 updateArticle() 메서드 정의
	public int updateArticle(ReviewBean rb) {
		System.out.println("updateArticle");
		
		int updateCount = 0;
		PreparedStatement pstmt = null;
		
		try {
			String sql = "UPDATE review "
					+ "SET rev_score=?,rev_content=?,rev_pic=?,rev_pic_origin=? "
					+ "WHERE rev_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setFloat(1, rb.getRev_score());
			pstmt.setString(2, rb.getRev_content());
			if(rb.getRev_pic_origin() != null) {
				pstmt.setString(3, rb.getRev_pic());
				pstmt.setString(4, rb.getRev_pic_origin());
				System.out.println("pic : " + rb.getRev_pic() + ", pic_origin : " + rb.getRev_pic_origin());
			} else {
				pstmt.setString(3, rb.getPrev_pic());
				pstmt.setString(4, rb.getPrev_pic_origin());
				System.out.println("pic : " + rb.getPrev_pic() + ", pic_origin : " + rb.getPrev_pic_origin());

			}
			pstmt.setInt(5, rb.getRev_num());
			
			
			updateCount = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.out.println("insertArticle() 오류 - " + e.getMessage());
		} finally {
			// 자원 반환
			close(pstmt);
		}
		
		return updateCount;
	} // updateArticle() 메서드 끝
	
	// 정렬 방식 정의 (최신, 도움, 별점 및 사진)
	public ArrayList<ReviewBean> getReviewSort(String selectedOption, String isCheckedPic, String rev_store, String rev_name) {
		ArrayList<ReviewBean> articleList = null; // 게시물을 저장할 객체 생성
		System.out.println("ReviewDAO - getReviewSort()");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			if(isCheckedPic.equals("true")) { // 사진 포함한 리뷰 정렬 true
				if(selectedOption.equals("0")) {
					sql = "SELECT * , (SELECT IFNULL(B.rev_isCheck,0) FROM rev_isLike B WHERE B.rev_num = A.rev_num"
    					   + " AND B.rev_name=?) AS isCheck FROM review A WHERE rev_store=? AND rev_pic is NOT NULL ORDER BY rev_num DESC";
				} else if(selectedOption.equals("1")) {
					sql = "SELECT * , (SELECT IFNULL(B.rev_isCheck,0) FROM rev_isLike B WHERE B.rev_num = A.rev_num"
    					   + " AND B.rev_name=?) AS isCheck FROM review A WHERE rev_store=? AND rev_pic is NOT NULL ORDER BY rev_like DESC, rev_date DESC";
				} else if(selectedOption.equals("2")) {
					sql = "SELECT * , (SELECT IFNULL(B.rev_isCheck,0) FROM rev_isLike B WHERE B.rev_num = A.rev_num"
    					   + " AND B.rev_name=?) AS isCheck FROM review A WHERE rev_store=? AND rev_pic is NOT NULL ORDER BY rev_score DESC, rev_date DESC";
				} else {
					sql = "SELECT * , (SELECT IFNULL(B.rev_isCheck,0) FROM rev_isLike B WHERE B.rev_num = A.rev_num"
    					   + " AND B.rev_name=?) AS isCheck FROM review A WHERE rev_store=? AND rev_pic is NOT NULL ORDER BY rev_score ASC, rev_date DESC";
				}
			} else {
				if(selectedOption.equals("0")) {
					sql = "SELECT * , (SELECT IFNULL(B.rev_isCheck,0) FROM rev_isLike B WHERE B.rev_num = A.rev_num"
    					   + " AND B.rev_name=?) AS isCheck FROM review A WHERE rev_store=? ORDER BY rev_num DESC";
				} else if(selectedOption.equals("1")) {
					sql = "SELECT * , (SELECT IFNULL(B.rev_isCheck,0) FROM rev_isLike B WHERE B.rev_num = A.rev_num"
    					   + " AND B.rev_name=?) AS isCheck FROM review A WHERE rev_store=? ORDER BY rev_like DESC, rev_date DESC";
				} else if(selectedOption.equals("2")) {
					sql = "SELECT * , (SELECT IFNULL(B.rev_isCheck,0) FROM rev_isLike B WHERE B.rev_num = A.rev_num"
    					   + " AND B.rev_name=?) AS isCheck FROM review A WHERE rev_store=? ORDER BY rev_score DESC, rev_date DESC";
				} else {
					sql = "SELECT * , (SELECT IFNULL(B.rev_isCheck,0) FROM rev_isLike B WHERE B.rev_num = A.rev_num"
    					   + " AND B.rev_name=?) AS isCheck FROM review A WHERE rev_store=? ORDER BY rev_score ASC, rev_date DESC";
				}
			}
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rev_name);
			pstmt.setString(2, rev_store);
			
			rs = pstmt.executeQuery();
			
			
			// 모든 레코드를 저장할 List 객체(ArrayList) 생성
			articleList = new ArrayList<ReviewBean>();

			// While 문을 
			while(rs.next()) {
				System.out.println("작동 중 .....");
				ReviewBean rb = new ReviewBean();
				rb.setRev_num(rs.getInt("rev_num"));
				rb.setRev_score(rs.getFloat("rev_score"));
				rb.setRev_name(rs.getString("rev_name"));
				rb.setRev_date(rs.getDate("rev_date"));
				rb.setRev_content(rs.getString("rev_content"));
				rb.setRev_pic(rs.getString("rev_pic"));
				rb.setRev_pic_origin(rs.getString("rev_pic_origin"));
				rb.setRev_menu(rs.getString("rev_menu"));
				rb.setRev_like(rs.getInt("rev_like"));
				rb.setListCount(rs.getInt("isCheck")); // 해당 유저의 좋아요 유무 저장
			
				// 1개 레코드가 저장된 ReviewBean 객체를 List 객체에 추가
				articleList.add(rb);
				System.out.println("articleList : " + articleList);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
		}
		
		return articleList;
		
	} // getReviewSort() 메서드 끝
	
	public int update_Like(int rev_num, String rev_name) {
		System.out.println("ReviewDAO - update_Like()"); 
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int like = 0;
		int isCheck = 0; // 좋아요 체크 확인
		
		try {
			// 좋아요 체크 확인
			sql = "SELECT rev_isCheck FROM rev_isLike WHERE rev_num=? AND rev_name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
			pstmt.setString(2, rev_name);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 좋아요 취소 시 DB 데이터 삭제
				close(pstmt);
				sql = "DELETE FROM rev_isLike WHERE rev_num=? AND rev_name=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rev_num);
				pstmt.setString(2, rev_name);
				int isDelete = pstmt.executeUpdate();
				if(isDelete > 0) {
					System.out.println("좋아요 취소 완료");
				} else {
					System.out.println("좋아요 취소 실패");
				}
			} else { // 좋아요 시 DB에 저장
				close(pstmt);
				sql = "INSERT INTO rev_isLike VALUES (?,?,1)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rev_num);
				pstmt.setString(2, rev_name);
				isCheck = pstmt.executeUpdate();
				if(isCheck > 0) {
					System.out.println("좋아요 완료");
				} else {
					System.out.println("좋아요 실패");
				}
			}
			
			// 리뷰의 좋아요 수 변경(증가, 감소)
			if(isCheck > 0) {
				close(rs);
				// 좋아요 = 좋아요 수 증가
				sql = "UPDATE review SET rev_like = rev_like + 1 WHERE rev_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rev_num);
				pstmt.executeUpdate();
			} else {
				close(rs);
				// 좋아요 취소 = 좋아요 수 감소
				sql = "UPDATE review SET rev_like = rev_like - 1 WHERE rev_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rev_num);
				pstmt.executeUpdate();
			}
			
			// 업데이트 후 자원 반환
			close(pstmt);
			
			// 증가한 좋아요 수 리턴
			sql = "SELECT rev_like FROM review WHERE rev_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				like = rs.getInt("rev_like");
			}			
			
		} catch (Exception e) {
			System.out.println("select_Like() 오류 - " + e.getMessage());
		} finally {
			// 자원 반환(주의! connection 객체 DAO에서 반환하지 않도록 해야한다!)
			if(rs != null) try { rs.close(); } catch(Exception e) {}
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
		}
		
		return like;
	} // update_Like() 메서드 끝
	
	// 매장 중복 없이 최근 10개 리뷰 정보를 저장할 getByStoreList() 메서드 정의
	public ArrayList<ReviewBean> getByStoreList() {
		ArrayList<ReviewBean> articleList = null; // 게시물을 저장할 객체 생성
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "SELECT *, COUNT(rev_score) AS score_count, AVG(rev_score) AS score_avg FROM review GROUP BY rev_store ORDER BY rev_num DESC LIMIT 10"; 
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			// 모든 레코드를 저장할 List 객체(ArrayList) 생성
			articleList = new ArrayList<ReviewBean>();
			
			// While 문을 
			while(rs.next()) {
				ReviewBean rb = new ReviewBean();
				rb.setRev_num(rs.getInt("rev_num"));
				rb.setRev_store(rs.getString("rev_store")); // 매장명 저장
				rb.setRev_score(rs.getFloat("score_avg")); // 매장 별 리뷰 평균 저장
				rb.setListCount(rs.getInt("score_count")); // 매장 별 총 리뷰 수 저장
				rb.setRev_name(rs.getString("rev_name"));
				rb.setRev_date(rs.getDate("rev_date"));
				rb.setRev_content(rs.getString("rev_content"));
				rb.setRev_pic(rs.getString("rev_pic"));
				rb.setRev_pic_origin(rs.getString("rev_pic_origin"));
				rb.setRev_menu(rs.getString("rev_menu"));
				rb.setRev_like(rs.getInt("rev_like"));
				
				// 1개 레코드가 저장된 BoardBean 객체를 List 객체에 추가
				articleList.add(rb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
		}
		
		return articleList;
	} // getByStoreList() 메서드 끝
    
    // 리뷰 작성 여부를 예약DB에 저장
	public void isReviewWrite(ReviewBean rb) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		System.out.println("isReviewWrite - ran_num : " + rb.getRan_num());
		
		try {
			sql = "SELECT * FROM review WHERE ran_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rb.getRan_num());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				close(pstmt);
				sql = "UPDATE reserve SET check_review=1 WHERE ran_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, rb.getRan_num());
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
		}
		
	} // isReviewWrite() 메서드 끝
	
	public int isLikeChecked(int rev_num, String rev_name) {
		int isLikeChecked = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "SELECT rev_isCheck FROM rev_isLike WHERE rev_num=? AND rev_name=?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
			pstmt.setString(2, rev_name);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isLikeChecked = rs.getInt("rev_isCheck");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
		}
		return isLikeChecked;
	} // isLikeCheced() 메서드 끝
	  
} // ReviewDAO 클래스 끝

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ReviewBean;

import static db.jdbcUtil.*;

public class ReviewDAO {
	/*
	 * BoardDAO 클래스는 다른 인스턴스에서 공통으로 처리할 DB 작업이 기술되는 클래스이므로
	 * 매번 인스턴스를 생성하기 보다 하나의 인스턴스만 생성한 뒤
	 * 각 요청 객체에서 BoardDAO 객체(인스턴스)를 리턴받아 사용하도록 제한하면 메모리 낭비 적음 
	 * => 단 하나의 유일한 인스턴스를 공유하기 위한 프로그래밍 패턴
	 *    = 싱글톤 디자인 패턴(Singleton Design Pattern)
	 * -------------- 싱글톤 디자인 패턴을 활용한 BoardDAO 인스턴스 작업 ---------------
	 * 1. 외부에서 인스턴스 생성이 불가능하도록 생성자를 private 접근제한자로 선언
	 * 2. 자신의 클래스 내에서 생성하는 인스턴스를 저장하기 위한 멤버변수 선언
	 *    => private 접근제한자로 선언하여 외부로부터 숨김
	 * 3. 인스턴스 생성 후 외부로 리턴하기 위한 Getter 메서드 정의
	 *    => 단, 인스턴스가 생성되지 않았을 경우 인스턴스 생성 후 리턴
	 * 4. 3번 메서드는 인스턴스 생성 후 호출 가능한 메서드이므로
	 *    인스턴스 생성 없이도 호출이 되도록 static 메서드로 선언
	 * 5. static 메서드인 Getter 에서 멤버변수에 접근하기 위해서는
	 *    해당 멤버변수(instance)도 static 변수로 선언해야한다! 
	 */

	
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
	// Serivce 클래스로부터 비즈니스 로직을 요청받아 처리하는 메서드 정의
	// 글등록 작업을 위한 insertAricle() 메서드 정의
	// => 파라미터 : BoardBean 객체, 리턴타입 : int insertCount
	public int insertReview(ReviewBean rb) {
		System.out.println("ReviewDAO - insertReview()");
		int insertCount = 0;
			
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int num = 1; // 새 글 번호를 저장할 변수 선언
		
		try {
			// 현재 MVC_Board 테이블의 게시물 최대 번호를 조회하여
			// 조회된 결과 값에 + 1 값을 새 글 번호로 지정
			// => 만약, 조회된 게시물이 하나도 없을 경우 새 글 번호는 1번 그대로 사용
			sql = "SELECT MAX(rev_num) FROM reviewtest";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 조회된 글 번호가 하나라도 존재할 경우
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			}
			
			// 다음 작업을 위해 Preparedstatment 객체 반환
			close(pstmt);
						
			// 글 등록 작업을 위한 INSERT 작업
			sql = "INSERT INTO reviewtest VALUES (?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 계산된 새 글 번호
			pstmt.setString(2, rb.getRev_store());
			pstmt.setString(3, rb.getRev_name());
			pstmt.setFloat(4, rb.getRev_score());
			pstmt.setString(5, rb.getRev_subject());
			pstmt.setString(6, rb.getRev_content());
			pstmt.setString(7, rb.getRev_pic());
			pstmt.setString(8, rb.getRev_pic_origin());
			pstmt.setString(9, rb.getRev_menu());
			
			// INSERT 구문 실행 및 결과 리턴 받기 => insertCount 에 저장
			insertCount = pstmt.executeUpdate();
			
			// 파일 확장자가 사진이 아닐 경우 0값 리턴
			if(rb.getRev_pic().equals(null)) {
				insertCount = 0;	
			} 
			
			System.out.println("ReviewDAO - insertCount : " + insertCount);
			
			
		} catch (Exception e) {
//			e.printStackTrace();
			System.out.println("insertArticle() 오류 - " + e.getMessage());
		} finally {
			// 자원 반환(주의! connection 객체 DAO에서 반환하지 않도록 해야한다!)
			if(rs != null) try { rs.close(); } catch(Exception e) {}
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
		}
			System.out.println("ReviewDAO - insertCount : " + insertCount);
			return insertCount;
		
		
	}
	
	// 전체 게시물 총 갯수 조회하여 리턴하는 selectArticleList() 메서드 정의
	public ReviewBean selectListCount() {
		System.out.println("ReviewDAO - selectListCount()");
		ReviewBean rb = new ReviewBean();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			// 현재 MVC_Board 테이블의 게시물 최대 번호를 조회하여
			// 조회된 결과 값에 + 1 값을 새 글 번호로 지정
			// => 만약, 조회된 게시물이 하나도 없을 경우 새 글 번호는 1번 그대로 사용
			sql = "SELECT SUM(rev_score) FROM reviewtest";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 조회된 글 번호가 하나라도 존재할 경우
			if(rs.next()) {
				rb.setTotalScore(rs.getFloat(1));
			}
			
			// 다음 작업을 위해 Preparedstatment 객체 반환
			close(rs);
			close(pstmt);
			
			// 3단계 SQL 구문 작성 및 전달
			// => 전체 레코드 갯수를 조회하기 위해 COUNT(*) 함수 사용 (또는 COUNT(num))
			sql = "SELECT COUNT(*) FROM reviewtest";
			pstmt = con.prepareStatement(sql);
			
			// 4단계 SQL 구문 실행 및 결과처리
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rb.setListCount(rs.getInt(1)); // 또는 rs.getInt("COUNT(*)") 
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
	}
	
	// 전체 게시물 조회하여 리턴하는 getArticleList() 메서드 정의
	public ArrayList<ReviewBean> getArticleList() {
		ArrayList<ReviewBean> articleList = null; // 게시물을 저장할 객체 생성
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
					
			// 3단계 SQL 구문 작성 및 전달
			// => funweb_board 테이블의 레코드 조회(번호num) 컬럼 기준 내림차순 정렬)
			//    검색어를 포함하는 제목들만 조회
			// => 단, 시작행번호부터 페이지당 게시물수 만큼
			//    LIMIT 시작행번호, 페이지당 게시물 수
			sql = "SELECT * FROM reviewtest WHERE rev_store=? ORDER BY rev_num DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "00국밥집");
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 모든 레코드를 저장할 List 객체(ArrayList) 생성
			articleList = new ArrayList<ReviewBean>();
			
			// While 문을 
			while(rs.next()) {
				// BoardBena 객체를 생성하여 1개 레코드 정보를 BoardBean 객체에 저장
				// => 글번호, 작성자, 제목, 날짜, 조회수만 필요
				//    (답글에 대한 들여쓰기를 위해 board_re_lev 값도 추가)
				ReviewBean rb = new ReviewBean();
				rb.setRev_num(rs.getInt("rev_num"));
				rb.setRev_name(rs.getString("rev_name"));
				rb.setRev_subject(rs.getString("rev_subject"));
				rb.setRev_date(rs.getDate("rev_date"));
				rb.setRev_content(rs.getString("rev_content"));
				rb.setRev_pic(rs.getString("rev_pic"));
				rb.setRev_pic_origin(rs.getString("rev_pic_origin"));
				rb.setRev_menu(rs.getString("rev_menu"));
			
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
	}
	
	public ReviewBean selectReview(int rev_num) {
		System.out.println("ReviewDAO - selectReview()");
		ReviewBean rb = null; // 1개 게시물 상세 정보를 저장하는 BoardBean 타입 변수 선언
			
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		
		
		try {
			// 게시물 상세 정보 조회
			// 3단계 SQL 구문 작성
			sql = "SELECT * FROM reviewtest WHERE rev_num =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
			
			// 4단계 SQL 실행 
			rs = pstmt.executeQuery();
			
			// 조회 결과가 존재할 경우에만 글 내용 표시
			if(rs.next()){
				// 조회 결과가 존재할 경우 BoardBean 객체 생성
				rb = new ReviewBean();
				
				// 조회된 게시물 1개 정보를 BoardBean 객체에 저장
				rb.setRev_score(rs.getInt("rev_score"));
				rb.setRev_name(rs.getString("rev_name"));
				rb.setRev_subject(rs.getString("rev_subject"));
				rb.setRev_date(rs.getDate("rev_date"));
				rb.setRev_content(rs.getString("rev_content"));
				rb.setRev_pic(rs.getString("rev_pic"));
				rb.setRev_pic_origin(rs.getString("rev_pic_origin"));
				rb.setRev_menu(rs.getString("rev_menu"));
				
			}
			
		} catch (Exception e) {
//			e.printStackTrace();
			System.out.println("insertArticle() 오류 - " + e.getMessage());
		} finally {
			// 자원 반환(주의! connection 객체 DAO에서 반환하지 않도록 해야한다!)
			if(rs != null) try { rs.close(); } catch(Exception e) {}
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
		}
		
		
		
		return rb;
	}
	
	public boolean isArticleWriter(String rev_name, String rev_pass) {
		boolean isArticleWriter = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			
			// 3단계 SQL 구문 작성 및 전달
			// => board_num 에 해당하는 레코드의 board_pass 조회
			sql = "SELECT password FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rev_name);
			
			// 4단계 SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 조회된 패스워드와 입력받은 패스워드가 일치할 경우
				// isArticleWriter 를 true로 변경
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
	} // isBoardArticleWriter() 메서드 끝
	
	public int deleteArticle(int rev_num) {
		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			// 3단계 SQL 구문 작성 및 전달
			String sql = "DELETE FROM reviewtest WHERE rev_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
					
			// 4. SQL 구문 실행 및 결과처리
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
	
	public int updateArticle(ReviewBean rb) {
		System.out.println("updateArticle");
		
		int updateCount = 0;
		
		PreparedStatement pstmt = null;
		
		
		try {
			// 글번호(board_num)에 해당하는 레코드의 작성자, 제목, 내용 수정(UPDATE)
			String sql = "UPDATE reviewtest "
					+ "SET rev_score=?,rev_subject=?,rev_content=?,rev_pic=?,rev_pic_origin=? "
					+ "WHERE rev_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setFloat(1, rb.getRev_score());
			pstmt.setString(2, rb.getRev_subject());
			pstmt.setString(3, rb.getRev_content());
			if(rb.getRev_pic_origin() != null) {
				pstmt.setString(4, rb.getRev_pic());
				pstmt.setString(5, rb.getRev_pic_origin());
				System.out.println("pic : " + rb.getRev_pic() + ", pic_origin : " + rb.getRev_pic_origin());
			} else {
				pstmt.setString(4, rb.getPrev_pic());
				pstmt.setString(5, rb.getPrev_pic_origin());
				System.out.println("pic : " + rb.getPrev_pic() + ", pic_origin : " + rb.getPrev_pic_origin());

			}
			pstmt.setInt(6, rb.getRev_num());
			
			
			// UPDATE 구문 실행 및 결과 리턴 받기 => updateCount 에 저장
			updateCount = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
//			e.printStackTrace();
			System.out.println("insertArticle() 오류 - " + e.getMessage());
		} finally {
			// 자원 반환(주의! connection 객체 DAO에서 반환하지 않도록 해야한다!)
			close(pstmt);
		}
		
		return updateCount;
	} // updateArticle() 메서드 끝
	
	
	
	
} // BoardDAO 클래스 끝

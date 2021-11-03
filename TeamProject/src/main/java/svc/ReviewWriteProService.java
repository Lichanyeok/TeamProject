package svc;

//import db.JdbcUtil;
//import static db.JdbcUtil.getConnection;
//import static db.JdbcUtil.commit;
//import static db.JdbcUtil.close;
//import static db.JdbcUtil.rollback;
import static db.jdbcUtil.*; // 끝판왕

import java.sql.Connection;

import dao.ReserveDAO;
import dao.ReviewDAO;
import vo.ReviewBean;

//Action 클래스로부터 요청을 받아 DAO 클래스와 상호작용을 통해 
//실제 DB 작업(비즈니스 로직)을 수행하는 클래스
public class ReviewWriteProService {
	// Action 클래스로부터 글쓰기 데이터를 전달받아 작업을 수행할 registArticle() 메서드 정의
		// => 파라미터 : BoardBean, 리턴타입 : boolean(isWriteSuccess)
		public boolean registReview(ReviewBean rb) {
			// 1. 글쓰기 작업 요청 처리 결과를 저장할 boolean 타입 변수 선언
			boolean isWriteSuccess = false; // 글쓰기 작업 결과를 저장할 변수
			System.out.println("registArticle");
			Connection con = getConnection();
			
			// 3. ReviewDAO 클래스로부터 생성된 BoardDAO 객체 가져오기(공통)
			ReviewDAO dao = ReviewDAO.getInstance();
			
			// 4. ReviewDAO 객체에서 DB 작업을 수행하기 위해 Connection 객체를 전달하기(공통)
			dao.setConnection(con);
			
			// 5. ReviewDAO 객체의 메서드를 호출하여 XXX 작업 수행 및 결과 리턴받기
			// 글쓰기 작업을 수행하기 위해 insertArticle() 메서드 호출
			// => 파라미터 : BoardBean 객체, 리턴타입 : int(insertCount)
			int insertCount = dao.insertReview(rb); // 리뷰 작성
			                  dao.isReviewWrite(rb);  // 리뷰 작성 여부를 예약DB에 저장
			System.out.println("rb.getRev_pic() : " + rb.getRev_pic());
			System.out.println("Service - insertCount : " + insertCount);
			
			// 6. 작업 수행 결과를 리턴받아 판별 후 결과 처리 수행
			// 1) 작업 성공 시 (=insertCount > 0 일 경우)
			//    => commit 작업 수행, isWriteSucess 를 true 로 변경
			// 2) 작업 실패 시 (insertCount == 0 일 경우)
			//    => rollback 작업 수행, isWriteSuccess 를 false 로 변경(생략 가능)
			if(insertCount > 0) {
				
				// 사진이 있는 경우
				if(rb.getRev_pic() != null) {
					String[] picType = rb.getRev_pic_origin().split("\\.");
					int n = picType.length - 1;
					
					if(picType[n].equals("jpg") || picType[n].equals("png") || picType[n].equals("gif")) {
						
//						JdbcUtil.commit(con);
						commit(con);
						isWriteSuccess = true;
						System.out.println("확장자 검증 : 사진 O");
					} else {
						// 이미지 확장자가 아닐 경우 롤백
						rollback(con);
						isWriteSuccess = false;
						System.out.println("확장자 검증 : 사진 X");
					}
				
				} else { // 사진이 없는 경우
					
//					JdbcUtil.commit(con);
					commit(con);
					isWriteSuccess = true;
					
				}
				
			} else {
//				JdbcUtil.rollback(con);
				rollback(con);
				
				isWriteSuccess = false; // 생략가능
			}
			
			// 7. JdbcUtil 객체로부터 가져온 Connection 객체 반환(공통)
//			JdbcUtil.close(con);
			close(con);
			
			
			System.out.println("ReviewWriteProService : " + isWriteSuccess);
			// 8. Action 클래스로 글쓰기 작업 결과 리턴
			return isWriteSuccess;
		}
}

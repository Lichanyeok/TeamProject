package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ReviewBean;
import svc.ReviewListService;
import vo.ActionForward;

public class ReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewListAction");
		
		// 포워딩 정보 관리를 위한 ActionForward 타입 변수 선언
		ActionForward forward = null;
		
		String rev_store = request.getParameter("rev_store");
		
		// ReviewListService 클래스 인스턴스 생성 후
		// getListCount() 메서드를 호출하여 전체 리뷰 수 조회 작업 요청
		// => 파라미터 : rev_store, 리턴타입 : ReviewBean
		ReviewListService svc = new ReviewListService();
		ReviewBean rb = svc.getListCount(rev_store);
		
		// ReviewListService 클래스의 getStoreReviewList( 메서드를 호출하여 전체 리뷰 조회 요청
		// => 파라미터 : rev_store 리턴타입 : ArrayList<ReviewBean>(articleList)
		ArrayList<ReviewBean> articleList = svc.getStoreReviewList(rev_store);
		
		System.out.println("ReviewListAction - articleList : " + articleList);
		System.out.println("reviewCount : " + rb);
		// request 객체에 PageInfo 객체와 ArrayList<BoardBean> 객체 저장
		// => setAttribute() 메서드 사용
		request.setAttribute("articleList", articleList);
		request.setAttribute("reviewData", rb);
		
		// ActionForward 객체를 생성하여 board 폴더 내의 qna_board_list.jsp 페이지로 포워딩
		// => 게시물 정보를 request 객체에 담아 전달해야하므로 request 객체`	가 유지되어야하며
		//    요청받은 URL(BoardList.bo)이 유지되어야 함 (qna_board_list.jsp 주소 숨김)
		// => 따라서, Dispatcher 방식 포워딩
		forward = new ActionForward();
//		forward.setPath("/practice/review/rev_list.jsp");
		forward.setPath("/review/rev_store.jsp");
		forward.setRedirect(false);
		
		
		// ActionForward 객체 리턴
		return forward;
	}

}

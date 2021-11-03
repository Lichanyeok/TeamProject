package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ReviewBean;
import svc.ReviewByStoresListService;
import vo.ActionForward;

public class ReviewByStoresListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewListAction");
		
		// 포워딩 정보 관리를 위한 ActionForward 타입 변수 선언
		ActionForward forward = null;
		
		ReviewByStoresListService svc = new ReviewByStoresListService();
		
		// ReviewByStoresListService 클래스의 selectByStoreScore() 메서드를 호출하여 전체 리뷰의 총점의 평균 조회 요청
		ArrayList<ReviewBean> ByStoreScore = svc.selectByStoreScore();
		
		// ReviewByStoresListService 클래스의 getByStoreList( 메서드를 호출하여 전체 게시물 조회 요청
		ArrayList<ReviewBean> articleList = svc.getByStoreList();
		
		System.out.println("ReviewListAction - articleList : " + articleList);
		request.setAttribute("articleList", articleList);
		request.setAttribute("reviewData", ByStoreScore);
		
		// ActionForward 객체를 생성하여 board 폴더 내의 qna_board_list.jsp 페이지로 포워딩
		// => 게시물 정보를 request 객체에 담아 전달해야하므로 request 객체`	가 유지되어야하며
		//    요청받은 URL(BoardList.bo)이 유지되어야 함 (qna_board_list.jsp 주소 숨김)
		// => 따라서, Dispatcher 방식 포워딩
		forward = new ActionForward();
		forward.setPath("/review/rev_byStores.jsp");
		forward.setRedirect(false);
		
		
		// ActionForward 객체 리턴
		return forward;
	}

}

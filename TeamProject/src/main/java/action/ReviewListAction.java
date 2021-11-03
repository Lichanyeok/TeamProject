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
		request.setAttribute("articleList", articleList);
		request.setAttribute("reviewData", rb);
		
		forward = new ActionForward();
		forward.setPath("/review/rev_store.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}

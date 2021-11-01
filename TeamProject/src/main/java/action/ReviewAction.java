package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReviewListService;
import vo.ActionForward;
import vo.ReviewBean;

public class ReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewAction");
		
		// 포워딩 정보 관리를 위한 ActionForward 타입 변수 선언
		ActionForward forward = null;
		
		String nickName = request.getParameter("nickName");
		System.out.println("ReviewAction - id : " + nickName);
		
		// ReviewAction 클래스의 getMyListCount() 메서드를 호출하여 작성한 총 리뷰 수 조회 작업 요청
		// => 파라미터 : id, 리턴타입 : int
		ReviewListService svc = new ReviewListService();
		int myListCount = svc.getMyListCount(nickName);
		
		// 작성한 총 리뷰 값을 빈 객체에 저장 후 넘기기
		ReviewBean rb = new ReviewBean();
		rb.setListCount(myListCount);
		
		// ReviewAction 클래스의 getMyReviewList() 메서드를 호출하여 전체 리뷰 조회 요청
		// => 파라미터 : id 리턴타입 : ArrayList<ReviewBean>(myReviewList)
		ArrayList<ReviewBean> myReviewList = svc.getMyReviewList(nickName);
		
		System.out.println("ReviewAction - myReviewList : " + myReviewList);
		System.out.println("ReviewAction - myListCount : " + rb);
		
		request.setAttribute("myReviewList", myReviewList);
		request.setAttribute("myListCount", rb);
		
		forward = new ActionForward();
		forward.setPath("/review/rev_myList.jsp");
		forward.setRedirect(false);
		
		
		// ActionForward 객체 리턴
		return forward;
	}

}

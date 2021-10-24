package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReviewModifyFormService;
import vo.ActionForward;
import vo.ReviewBean;

public class ReviewModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewModifyFormAction");
		
		ActionForward forward = null;
		
		// request 객체를 통해 전달받은 파라미터(board_num, page) 가져오기
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		
		// ReviewModifyFormService 클래스 인스턴스 생성 후
		// getArticle() 메서드 호출하여 board_num 에 대한 게시물 상세 정보 조회 요청
		// => 파라미터 : 리뷰번호(rev_num)   리턴타입 : ReviewBean(article)
		ReviewModifyFormService svc = new ReviewModifyFormService();
		ReviewBean article = svc.getArticle(rev_num);
		
		
		// 다음 페이지로 전달하기 위한 객체(article, page)를 request 객체에 저장
		request.setAttribute("article", article);
		
		
		// ActionForward 객체를 생성하여 /board/qna_board_modify.jsp 페이지로 포워딩
		// => request 객체를 유지해야하므로 Dispatcher 방식 포워딩
		forward = new ActionForward();
		forward.setPath("/review/rev_modify.jsp");
		forward.setRedirect(false); // 생략 가능
		
		return forward;
	}

}

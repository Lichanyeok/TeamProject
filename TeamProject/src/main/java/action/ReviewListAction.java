package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		String selectedOption = request.getParameter("selectedOption");
		String isCheckedPic = request.getParameter("isCheckedPic");
		String rev_name = request.getParameter("rev_name");
		
		System.out.println(rev_store + " , " + selectedOption + " , " + isCheckedPic + " , " + rev_name);

		ReviewListService svc = new ReviewListService();
		
		ArrayList<ReviewBean> articleList = svc.getReviewSort(selectedOption, isCheckedPic, rev_store, rev_name);
		request.setAttribute("articleList", articleList);
		
		forward = new ActionForward();
		forward.setPath("review/rev_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}

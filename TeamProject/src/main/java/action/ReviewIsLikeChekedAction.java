package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import svc.ReviewListService;
import vo.ActionForward;
import vo.ReviewBean;

public class ReviewIsLikeChekedAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewIsLikeChekedAction");
		HttpSession session = request.getSession(); // 세션 객체 만들기
		
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		String rev_name = (String) session.getAttribute("sNn");
		System.out.println("ReviewLikeAction - rev_num : " + rev_num + ", rev_name : " + rev_name);
		ReviewListService svc = new ReviewListService();
		int isCheck = svc.isLikeChecked(rev_num, rev_name); // 좋아요 수 증가 및 증가한 값 리턴
		
		JSONObject obj = new JSONObject();
		obj.put("isCheck", isCheck);
		
		System.out.println("ReviewIsLikeChekedAction 좋아요 obj : " + obj.get("isCheck") + ", isCheck : " + isCheck);
		
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
		
		return null;
	}

}

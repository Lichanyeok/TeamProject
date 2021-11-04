package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import svc.ReviewListService;
import vo.ActionForward;

public class ReviewLikeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewLikeAction");
		
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		System.out.println("rev_num : " + rev_num);
		System.out.println(rev_num);
		System.out.println("ReviewLikeAction - rev_num : " + rev_num);
		ReviewListService svc = new ReviewListService();	
		int like = svc.update_Like(rev_num); // 좋아요 수 증가 및 증가한 값 리턴
		
		JSONObject obj = new JSONObject();
		obj.put("like", like);
		
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
		
		
		return null;
	}

}

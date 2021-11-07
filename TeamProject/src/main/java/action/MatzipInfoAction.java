package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MatzipinfoService;
import vo.ActionForward;
import vo.ReviewBean;
import vo.SearchBean;

public class MatzipInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=null;
		
		String place_name = request.getParameter("place_name");
		String tell_number = request.getParameter("tell_number");
		
		
		MatzipinfoService service = new MatzipinfoService();
		SearchBean info = service.getInfo(tell_number);
		
		// 리뷰 갯수 및 평균 가져오기
		ReviewBean reviewListCount = service.getListCount(place_name);
		
		if(info==null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('예약이 불가능 합니다!')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			request.setAttribute("article", info);
			request.setAttribute("reviewListCount", reviewListCount);
			forward = new ActionForward();
			forward.setPath("./search/search_info.jsp");
			forward.setRedirect(false);			
		}

		
		return forward;
		
		// 확인
		
	}

}

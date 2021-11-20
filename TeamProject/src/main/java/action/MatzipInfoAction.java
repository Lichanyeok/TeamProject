package action;


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
		
//		System.out.println(place_name);
		MatzipinfoService service = new MatzipinfoService();
		SearchBean info = service.getInfo(tell_number);
		
		// 리뷰 갯수 및 평균 가져오기
		ReviewBean reviewListCount = service.getListCount(place_name);
				
		request.setAttribute("article", info);
		request.setAttribute("reviewListCount", reviewListCount);
		forward = new ActionForward();
		forward.setPath("./search/search_info.jsp");
		forward.setRedirect(false);
		
		return forward;	
	}

}

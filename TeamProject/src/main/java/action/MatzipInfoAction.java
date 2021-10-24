package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MatzipinfoService;
import vo.ActionForward;
import vo.SearchBean;

public class MatzipInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward;
		
		String road_address = request.getParameter("road_address");
		String tell_number = request.getParameter("tell_number");
		System.out.println(road_address);
		System.out.println(tell_number);
		
		MatzipinfoService service = new MatzipinfoService();
		SearchBean info = service.getInfo(road_address, tell_number);
		System.out.println(info.getPlace_name());

		request.setAttribute("article", info);
		
		forward = new ActionForward();
		forward.setPath("./search/search_info.jsp");
		forward.setRedirect(false);
		
		return forward;
		
		// 확인
		
	}

}

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
		
		String jibun_address = request.getParameter("jibun_address");
		String tell_number = request.getParameter("tell_number");
		System.out.println(jibun_address);
		
		MatzipinfoService service = new MatzipinfoService();
		SearchBean info = service.getInfo(jibun_address, tell_number);
		

		request.setAttribute("article", info);
		
		forward = new ActionForward();
		forward.setPath("./search_check.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}

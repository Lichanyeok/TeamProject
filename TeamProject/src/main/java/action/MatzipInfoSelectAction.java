package action;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MatzipinfoService;
import vo.ActionForward;

import vo.SearchBean;

public class MatzipInfoSelectAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
		String tell_number = request.getParameter("tell_number");
		
//		System.out.println(tell_number);
		MatzipinfoService service = new MatzipinfoService();
		SearchBean info = service.getInfo(tell_number);		
		
		if(info==null) {
			response.setContentType("text/html; charset=UTF-8");			
			response.getWriter().print(false);
		}else {
			response.setContentType("text/html; charset=UTF-8");			
			response.getWriter().print(true);		
		}		

		return null;	
	}

}

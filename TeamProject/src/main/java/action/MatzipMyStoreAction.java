package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MatzipMyStoreService;
import svc.MatzipinfoService;
import vo.ActionForward;
import vo.ReviewBean;
import vo.SearchBean;

public class MatzipMyStoreAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=null;
		
		HttpSession session = request.getSession();
	    String id=(String)session.getAttribute("sId");
//	    System.out.println(id);
		
		MatzipMyStoreService service =new MatzipMyStoreService();
		SearchBean search=service.getInfo(id);
		
		if(search==null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록된 매장이 없습니다! 매장을 등록해주세요!')");		
			out.println("</script>");
			forward=new ActionForward();
			forward.setPath("MatzipInsertForm.mz");
			forward.setRedirect(true);
		}else {
			request.setAttribute("search", search);
			forward = new ActionForward();
			forward.setPath("./search/search_mystore.jsp");
			forward.setRedirect(false);			
		}		
		return forward;		
	}

}

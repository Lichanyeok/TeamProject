package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.TestService;
import vo.ActionForward;
import vo.SearchBean;

public class Test implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=null;
		
		TestService service=new TestService();
		ArrayList<SearchBean>articleList=service.getArticle();
		
		request.setAttribute("article", articleList);
		forward=new ActionForward();
		forward.setPath("./search/test.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}

package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MatzipListInsertService;
import svc.MatzipListService;
import vo.ActionForward;
import vo.SearchBean;

public class MatzipListSQLAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward;
		
		
		String category=request.getParameter("category");
				
		
		MatzipListService service = new MatzipListService();
		int listCount = service.getMatzipListCount(category);
		
		ArrayList<SearchBean> articleList = service.getArticleList2(category);
		System.out.println("list 갯수 : "+listCount);
		request.setAttribute("articleList", articleList);
		
		forward = new ActionForward();
		forward.setPath("search/testinfo.jsp");
		forward.setRedirect(false);
		return forward;
		
	}

}

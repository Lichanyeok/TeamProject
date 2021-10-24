package action;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.MatzipListService;
import vo.ActionForward;
import vo.PageInfo;
import vo.SearchBean;

public class MatzipListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward;
		
		
		String category=request.getParameter("category");
		System.out.println(category);
		
		MatzipListService service = new MatzipListService();
		int ListCount = service.getMatzipListCount(category);
		
		ArrayList<SearchBean> articleList = service.getArticleList(category);
		
		request.setAttribute("articleList", articleList);
		
		
		forward = new ActionForward();
		forward.setPath("search_list.jsp");
		forward.setRedirect(false);
		return forward;
	}

}

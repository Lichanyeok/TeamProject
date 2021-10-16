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
//		System.out.println("bbb");
		
		int page = 1; 
		int maximum = 10; 
		
		MatzipListService service = new MatzipListService();
		int ListCount = service.getmatzipListCount();
		
		ArrayList<SearchBean> articleList = service.getArticleList(page, maximum);
		System.out.println("aaa");
		int maxPage = (int)((double)ListCount / maximum + 0.95);
		
		int startPage = ((int)((double)page / 10 + 0.9) - 1) * 10 + 1;
		
		int endPage = startPage + 10 - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, ListCount);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("articleList", articleList);
		
		
		forward = new ActionForward();
		forward.setPath("./search/qna_board_list.jsp");
		forward.setRedirect(false);
		return forward;
	}

}

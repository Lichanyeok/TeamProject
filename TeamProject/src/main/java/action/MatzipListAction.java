package action;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import vo.ActionForward;

public class MatzipListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward;
		
		
		
		
		
		
		
		forward= new ActionForward();
		forward.setPath("/search/matzip_search_list.jsp");
		forward.setRedriect(false);
		return forward;
	}

}

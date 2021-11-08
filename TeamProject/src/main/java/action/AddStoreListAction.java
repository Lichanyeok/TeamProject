package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AddStoreListService;
import vo.ActionForward;
import vo.SearchBean;

public class AddStoreListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		AddStoreListService service = new AddStoreListService();
		ArrayList<SearchBean> storeList = new ArrayList<SearchBean>();
		
		storeList = service.getAddStoreList();
		
		if(storeList!=null) {
			request.setAttribute("storeList", storeList);
			forward.setPath("./admin/add_store_list.jsp");
			forward.setRedirect(false);
		}else {
			System.out.println("AddStoreListAction - fail");
		}
		
		
		return forward;
	}

}

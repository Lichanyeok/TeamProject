package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MatzipListInsertService;
import vo.ActionForward;
import vo.SearchBean;

public class MatzipListInsertAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward;
		
		String road=request.getParameter("road");
		String jibun=request.getParameter("jibun");
		String category2=request.getParameter("category");
		String category=category2.substring(3,category2.length() );
		String name=request.getParameter("name");
		String tell=request.getParameter("tell");
		SearchBean bean=new SearchBean();
		bean.setRoad_address(road);
		bean.setJibun_address(jibun);
		bean.setCategory(category);
		bean.setPlace_name(name);
		bean.setTell_number(tell);
		
		MatzipListInsertService service=new MatzipListInsertService();
		service.insertList(bean);
		
		forward = new ActionForward();
		forward.setPath("MatzipSearch.mz");
		forward.setRedirect(true);
		return forward;
		
	}

}

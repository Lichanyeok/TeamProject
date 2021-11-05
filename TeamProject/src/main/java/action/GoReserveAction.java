package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vo.ActionForward;
import vo.SearchBean;

public class GoReserveAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		ArrayList<SearchBean> storeInfo = new ArrayList<SearchBean>();
		String store_name=request.getParameter("store_name");
		String load_address = request.getParameter("load_address");
		String address=request.getParameter("address");
		String store_number = request.getParameter("store_number");
		String category = request.getParameter("category");
		SearchBean bean = new SearchBean(load_address, address, store_name, store_number);
		bean.setCategory(category);
		storeInfo.add(bean);
		HttpSession session = request.getSession();
		session.setAttribute("storeInfo", storeInfo);
		
		System.out.println("GoResrveAction : " + bean.toString());
//		System.out.println(forward);
		forward.setPath("./reserve/reserve_main2.jsp");
		forward.setRedirect(false);
		return forward;
	}

}

package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReservationListService;
import vo.ActionForward;
import vo.ReserveBean;

public class ReservationListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		ActionForward forward = null;
		String store_name=request.getParameter("store_name");
		String reserve_date=request.getParameter("reserve_date");
		System.out.println(store_name+reserve_date);
		ReservationListService service=new ReservationListService();
		
		ArrayList<ReserveBean> articleList = service.getReservationList(store_name,reserve_date);
		
		request.setAttribute("articleList", articleList);
			
		
		forward=new ActionForward();
		forward.setPath("search/reservation_list.jsp");
		forward.setRedirect(false);
		return forward;
			
		
		
		
		
	}

}

package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MatzipinfoService;
import svc.ReservationListService;
import svc.ReserveListService;
import vo.ActionForward;
import vo.PageInfo;
import vo.ReserveBean;
import vo.ReviewBean;
import vo.SearchBean;

public class ReservationListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		ActionForward forward = null;
		String store_name=(String)request.getAttribute("store_name");
		
		ReservationListService service=new ReservationListService();
		
		ArrayList<ReserveBean> articleList = service.getReservationList(store_name);
		
		request.setAttribute("articleList", articleList);
			
		
		forward=new ActionForward();
		forward.setPath("search/reservation_list.jsp");
		forward.setRedirect(false);
		return forward;
			
		
		
		
		
	}

}

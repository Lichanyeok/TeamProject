package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MatzipinfoService;
import svc.ReservationListService;
import vo.ActionForward;
import vo.ReserveBean;
import vo.ReviewBean;
import vo.SearchBean;

public class ReservationListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=null;
		
		String storeName = request.getParameter("storeName");
		String storeNumber = request.getParameter("storeNumber");
		  
		ReservationListService service = new ReservationListService();
		ReserveBean ReservationList = service.getReservationList(storeNumber);
		
		ReserveBean ReserveListCount = service.getListCount(storeName);
		
		if(ReservationList==null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('예약이 불가능 합니다!')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			request.setAttribute("article", ReservationList);
			request.setAttribute("reviewListCount", ReserveListCount);
			forward = new ActionForward();
			forward.setPath("./search/reservation_list.jsp");
			forward.setRedirect(false);			
		}

		
		return forward;
		
		
	}

}

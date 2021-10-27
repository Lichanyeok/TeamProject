package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.ReserveListService;
import vo.ActionForward;
import vo.PageInfo;
import vo.ReserveBean;

public class ReserveListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		HttpSession session = request.getSession();
		String sId = session.getAttribute("sId").toString();
		if(sId!=null) {
			System.out.println("ReserveListAction id : " + sId);
			
			int page=1;
			int limit = 10;
			if(request.getParameter("page")!=null) {
				page=Integer.parseInt(request.getParameter("page"));
			}
			ReserveListService service = new ReserveListService();
			int listCount = service.getListCount(sId);
			int maxPage = (int)((double)listCount / limit + 0.95);
			int startPage = ((int)((double)page / 10 + 0.9) - 1) * 10 + 1;
			int endPage = startPage + 10 - 1;
			if(endPage > maxPage) {
				endPage = maxPage;
			}
			PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);
			request.setAttribute("pageInfo", pageInfo);
			
			ArrayList<ReserveBean> reserveList = service.getReserveList(sId,page,limit);
			if(reserveList.size()>0) {
				request.setAttribute("reserveList",reserveList);
				
				forward = new ActionForward();
				forward.setPath("./reserve/reserve_list.jsp");
				forward.setRedirect(false);
			}else {
				System.out.println("검색된 리스트가 없습니다");
				request.setAttribute("reserveList",reserveList);
				forward = new ActionForward();
				forward.setPath("./reserve/reserve_list.jsp");
				forward.setRedirect(false);
			}
		}else {
			 System.out.println("PaymentAction 결제실패");
			 response.setContentType("text/html; charset=UTF-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>");
	         out.println("alert('로그인 후 이용해주세요.')");
	         out.println("location.href='MemberJoinFormAction.do'");
	         out.println("</script>");
		}
		return forward;
	}

}

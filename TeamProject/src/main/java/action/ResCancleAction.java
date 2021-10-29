package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ResCancleService;
import vo.ActionForward;

public class ResCancleAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		String reserve_code = request.getParameter("reserveCode");
		System.out.println("ResCancleAction - " + reserve_code);
		ResCancleService service = new ResCancleService();
		boolean isCancleSuccess = service.resCancle(reserve_code);
		if(isCancleSuccess) {
			forward.setPath("./reserve/reserver_info_result.jsp");
			forward.setRedirect(false);
		
		}else {
			System.out.println("취소 실패했습니다 action");
			PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('예약 취소 실패')");
	        out.println("location.href='MemberJoinFormAction.do'");
	        out.println("</script>");
		}
		return forward;
	}

}

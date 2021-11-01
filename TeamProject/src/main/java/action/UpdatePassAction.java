package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.UpdatePassService;
import vo.ActionForward;

public class UpdatePassAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		String pass = request.getParameter("pass");
		String id =request.getParameter("id");
		System.out.println("UpdatePassAction pass : " + pass + ", id : " + id);
		UpdatePassService service = new UpdatePassService();
		boolean updateCount = service.updatePass(pass,id);
		
		if(updateCount) {
		forward.setPath("../MemberLoginFormAction.do");
		forward.setRedirect(false);
		}else {
			PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('비밀번호 변경 실패')");
	        out.println("history.back()");
	        out.println("</script>");
		}
		return forward;
	}

}

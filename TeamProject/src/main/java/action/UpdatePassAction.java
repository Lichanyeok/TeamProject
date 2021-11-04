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
		String pass1 = request.getParameter("pass1");
		String pass2 = request.getParameter("pass2");
		String id =request.getParameter("id");
		System.out.println("UpdatePassAction pass : " + pass1 + ", id : " + id);
		UpdatePassService service = new UpdatePassService();
		boolean updateCount = false;
		if(pass1.equals(pass2)) { 
			updateCount = service.updatePass(pass1,id);
		}else {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('비밀번호가 일치하지 않습니다')");
            out.println("history.back()");
            out.println("</script>");
		}
		if(updateCount) {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('변경이 완료되었습니다.')");
            out.println("history.back()");
            out.println("</script>");
			forward.setPath("/TeamProject/");
			forward.setRedirect(true);
		}else {
			 response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script>");
	            out.println("alert('변경 실패.')");
	            out.println("history.back()");
	            out.println("</script>");
		}
		return forward;
	}

}

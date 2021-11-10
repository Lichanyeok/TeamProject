package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.FindPassService;
import vo.ActionForward;
import vo.MemberBean;

public class FindPassAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		
		MemberBean bean = new MemberBean();
		
		bean.setId(id);
		bean.setEmail(email);
		
		FindPassService service = new FindPassService();
		boolean isRightInfo = service.FindPass(bean);
		
		if(isRightInfo) {
			request.setAttribute("id", id);
			forward.setPath("./member/find_pass_result.jsp");
			forward.setRedirect(false);
		}else {
			  response.setContentType("text/html; charset=UTF-8");
	          PrintWriter out = response.getWriter();
	          out.println("<script>");
	          out.println("alert('잘못된 정보입니다.')");
	          out.println("history.back()");
	          out.println("</script>");
		}
		
		return forward;
	}

}

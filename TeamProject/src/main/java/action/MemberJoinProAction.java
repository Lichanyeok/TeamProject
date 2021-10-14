package action;

import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberJoinService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberJoinProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberJoinProAction - Aciton");
		ActionForward forward = new ActionForward();
		

		String name = request.getParameter("name");
		String nickName = request.getParameter("nickName");
		int age = Integer.parseInt(request.getParameter("age"));
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String gender = request.getParameter("gender");
		Date date = null;

		MemberBean bean = new MemberBean(name, nickName, age, id, pass, email, mobile, gender );
		
		MemberJoinService service = new MemberJoinService();
		
		boolean isJoinSuccess = service.joinMember(bean);
		
		if(isJoinSuccess) {
			forward.setPath("/MemberLoginFormAction.do");
			forward.setRedirect(false);
			return forward;
		}else {
			response.setContentType("text/html; charset=UTF-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>");
	         out.println("alert('회원가입 실패!')");
	         out.println("history.back()");
	         out.println("</script>");
		}
		return forward;
	}

}

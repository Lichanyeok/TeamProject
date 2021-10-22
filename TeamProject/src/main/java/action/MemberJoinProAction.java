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
		String pass = request.getParameter("pass1");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String address = request.getParameter("address1") + request.getParameter("address2");
		String gender = request.getParameter("gender");
		Date date = null;

		MemberBean bean = new MemberBean(name, nickName, age, id, pass, email, mobile, address, gender );
		
		MemberJoinService service = new MemberJoinService();
		
		boolean isJoinSuccess = service.joinMember(bean);
		
		if(isJoinSuccess) {
			forward.setPath("/TeamProject/MemberLoginFormAction.do");
			forward.setRedirect(true);
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

package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberLoginProService;
import vo.ActionForward;
import vo.MemberBean;
import static db.jdbcUtil.*;

import java.io.PrintWriter;
public class MemberLoginProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		System.out.println("MemberLoginProAction");
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		System.out.println(id);
		System.out.println(pass);
		MemberLoginProService service = new MemberLoginProService();
		
		MemberBean bean = new MemberBean();
		
		bean.setId(id);
		bean.setPass(pass);
		
		boolean isLoginSuccess = service.loginMember(bean);		
		
		if(isLoginSuccess){
			HttpSession session = request.getSession();
			String grade = bean.getGrade()+"";
			System.out.println(grade);
			session.setAttribute("sNn", bean.getNickName());
			session.setAttribute("sId", bean.getId());
			session.setAttribute("sGr", bean.getGrade());
			forward.setPath("/");
			forward.setRedirect(false);
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}

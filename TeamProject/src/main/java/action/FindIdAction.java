package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.FindIdService;
import vo.ActionForward;
import vo.MemberBean;

public class FindIdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		

		FindIdService service = new FindIdService();
		String id = service.findId(name,email);
		
		MemberBean bean = new MemberBean();
		bean.setId(id);
		bean.setName(name);
		if(id!=null) {
			request.setAttribute("bean",bean);
			forward.setPath("./member/find_id_result.jsp");
			forward.setRedirect(false);
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록된 정보가 없습니다')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}

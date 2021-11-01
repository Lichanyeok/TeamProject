package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberDetailService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberInfoDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		System.out.println("MemberInfoDetailAction - "+id+" , " + pass);
		
		MemberDetailService service = new MemberDetailService();
		ArrayList<MemberBean> list = service.getMemberinfo(id,pass);
		if(list!=null) {
			request.setAttribute("list", list);
			forward.setPath("./member/member_detail.jsp");
			forward.setRedirect(false);
		}else {
			System.out.println("불러오기 실패");
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('올바르지 않은 정보입니다')");
            out.println("history.back()");
            out.println("</script>");
		}
		return forward;
	}

}

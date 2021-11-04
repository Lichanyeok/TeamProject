package action;

import dao.MemberDAO;
import db.jdbcUtil;
import vo.ActionForward;
import vo.AuthInfoBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.Connection;

public class MemberAuthAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberAuthAction!");
		
		ActionForward forward = null;
		
		String id = request.getParameter("id");
		String authCode = request.getParameter("authCode");
		
		Connection con = jdbcUtil.getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		AuthInfoBean authInfo = new AuthInfoBean();
		authInfo.setId(id);
		authInfo.setAuth_code(authCode);
		System.out.println(id + authCode);
		
		boolean isAuthenticationSuccess = dao.selectAuthInfo(authInfo);

		if(isAuthenticationSuccess) {
			boolean isChangeSuccess = dao.changeAuthStatus(id);
			
			if(isChangeSuccess) {
				boolean isDeleteSuccess = dao.deleteAuthInfo(id);
				
				if(isDeleteSuccess) {

					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('인증 완료')");
					out.println("</script>");

					forward = new ActionForward();
					forward.setPath("/MemberLoginFormAction.do");
					forward.setRedirect(true);

					jdbcUtil.commit(con);
				} else {
					jdbcUtil.rollback(con);

					response.setContentType("text/html;charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('인증 실패')");
					out.println("history.back()");
					out.println("</script>");
				}
				
			} else {
				jdbcUtil.rollback(con);

				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('인증 실패!')");
				out.println("history.back()");
				out.println("</script>");
			}
		}
		
		return forward;
	}

}
















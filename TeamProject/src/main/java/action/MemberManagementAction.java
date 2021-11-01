package action;

import svc.MemberManagementService;
import vo.ActionForward;
import vo.MemberBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class MemberManagementAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ActionForward forward = null;

        MemberBean article = new MemberBean();
        String pass = request.getParameter("pass");
        System.out.println("MemberManagementAction pass : " + pass);
        MemberManagementService service = new MemberManagementService();
        boolean isManagementSuccess = service.checkMember(pass);
        
        if (!isManagementSuccess) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('올바르지 않은 정보입니다')");
            out.println("history.back()");
            out.println("</script>");
        } else {
            article = service.getArticle(pass);
            request.setAttribute("article", article);
            forward = new ActionForward();
            forward.setPath("/member/member_managementPro_form.jsp");
        }

        return forward;

    }
}

package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ModifyNickNameService;
import vo.ActionForward;

public class ModifyNicknameAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		String id = request.getParameter("id");
		String nickName = request.getParameter("nickname");
		System.out.println("ModifyNickNameAction nickName = " + id + ", nickName : " + nickName);
		
		ModifyNickNameService service = new ModifyNickNameService();
		
		boolean isUpdateSuccess = service.modifyNickName(id,nickName);
		if(isUpdateSuccess) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('변경완료! 새로 로그인 해주세요')");
			out.println("location.href='./member/logout.jsp'");
			out.println("</script>");
			
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('올바르지 않은 닉네임 입니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}

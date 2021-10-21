package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.WriteFormProService;
import vo.ActionForward;
import vo.BoardBean;

public class WriteFormProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("WriteFormProAction.java");
		ActionForward forward = null;
		
		BoardBean board = new BoardBean();
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));
		
		WriteFormProService service = new WriteFormProService();
		
		boolean isWriteSuccess  = service.registComment(board);
		
		if(isWriteSuccess==false) { //false라면?
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('게시물 등록 실패!')");
			out.println("history.back()");			
			out.println("</script>");
		}else if(isWriteSuccess) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('게시물 등록 성공!')");
			out.println("history.back()");			
			out.println("</script>");
			forward = new ActionForward();
			forward.setPath("CustomerCommentList.bo");
			forward.setRedirect(true);
		}
		
		return forward;
	}

}

package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.DeleteCommentService;
import vo.ActionForward;

public class DeleteCommentAction implements Action
{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ActionForward forward = null;
		System.out.println("DeleteCommentAction");
		
		int num = Integer.parseInt(request.getParameter("num")) ;
//		System.out.println("num : "+ num);
		DeleteCommentService service = new DeleteCommentService();
		boolean DeleteSuccess = service.DeleteComment(num);
		System.out.println("DeleteSuccess : " + DeleteSuccess);
		if(DeleteSuccess == true) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제 성공')");
			out.println("location.href='CustomerCommentList.do'");			
			out.println("</script>");
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제 실패')");
			out.println("history.back()");			
			out.println("</script>");
		}
		
		return forward;
	}

}

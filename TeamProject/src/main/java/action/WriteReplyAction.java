package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReplyCommentService;
import vo.ActionForward;
import vo.ReplyComment;

public class WriteReplyAction implements Action
{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ActionForward forward = null;
		System.out.println("WriteReplyAction");
		
		ReplyComment reply = new ReplyComment(); //bean
		reply.setContent(request.getParameter("replyContent")); 
		reply.setId(request.getParameter("id"));
		String content = request.getParameter("replyContent");
//		String id = request.getParameter("id");
		int num = Integer.parseInt(request.getParameter("num"));
		ReplyCommentService service = new ReplyCommentService();
		if(content!="") { // content값이 null이 아닐때
			boolean isReplySuccess  = service.replyComment(reply, num);
			
			request.setAttribute("isReplySuccess", isReplySuccess);
			ArrayList<ReplyComment> selectReply = service.selectReply(num);
			request.setAttribute("Rcomment", selectReply);
			if(isReplySuccess==false) { //false라면?
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('게시물 등록 실패!')");
				out.println("history.back()");			
				out.println("</script>");
			}
			else if(isReplySuccess) {		
				forward = new ActionForward();
				forward.setPath("./board/detailComment2.jsp");
				forward.setRedirect(false);
			}
		}else if(content==""){
			ArrayList<ReplyComment> selectReply = service.selectReply(num);
			request.setAttribute("Rcomment", selectReply);
			forward = new ActionForward();
			forward.setPath("./board/detailComment2.jsp");
			forward.setRedirect(false);
		}
		
		
		
		return forward;
	}

}

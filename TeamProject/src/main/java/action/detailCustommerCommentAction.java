package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.detailCustommerCommentService;
import vo.ActionForward;
import vo.BoardBean;

public class detailCustommerCommentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("detailCustommerCommentAction입니다.");
		ActionForward forward = null;
		
		BoardBean bean = new BoardBean();
		int num =Integer.parseInt(request.getParameter("num"));
		String page = request.getParameter("page"); 
		System.out.println(" detail에서 detailnum의 값은 " + num);
		
		detailCustommerCommentService service = new detailCustommerCommentService();
		service.increseReadcount(num);
		BoardBean comment = service.getdetailCustommerComment(num);
		//comment에 dao에서 저장한 subject, id, content, readcount, date가 있다.
		
		request.setAttribute("comment", comment);
		request.setAttribute("page", page);
		
		forward = new ActionForward();
		forward.setPath("/board/detailComment.jsp");
		forward.setRedirect(false); 
		
		//상세보기는 num값만 비교하여 같으면 그 내용을 가져오면된다.
		 
		return forward;
	}

}

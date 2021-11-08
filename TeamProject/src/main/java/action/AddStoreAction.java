package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AddStoreService;
import vo.ActionForward;

public class AddStoreAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AddStoreAction");
		ActionForward forward = new ActionForward();
		String lisences = request.getParameter("businessLisence");

		AddStoreService service = new AddStoreService();
		boolean isSuccess = false;
		isSuccess = service.updateStore(lisences);
		
		if(isSuccess) {
			forward.setPath("./admin/add_store_list.jsp");
			forward.setRedirect(false);
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}

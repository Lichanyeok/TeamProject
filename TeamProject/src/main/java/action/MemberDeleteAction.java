package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberDeleteService;
import vo.ActionForward;

public class MemberDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		String idArr = request.getParameter("member");
		System.out.println("MemberDeleteAction - " + idArr);
		String[] idArray = idArr.split(",");
		MemberDeleteService service = new MemberDeleteService();
		
		if(idArray.length >0) {
			for(String id : idArray) {
				service.memberDelete(id);
			}
		}
		//배열 크기 0으로 if문 작동 없을 시 forward = null ->fail 콜백함수 실행
		
		return forward;
	}

}

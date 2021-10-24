package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ModifyMemberGradeService;
import vo.ActionForward;
import vo.MemberBean;

public class ModifyMemberGradeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String member = request.getParameter("member");
		int grade = Integer.parseInt(request.getParameter("gradeList"));
		System.out.println("ModifyMemberGradeAction - " + member + " , " + grade);
		
		ModifyMemberGradeService service = new ModifyMemberGradeService();
		String[] idArr = member.split(",");
		
		for(String id : idArr) {
			service.ModifyMemberGrade(id,grade);
		}
		
		
//		forward.setPath("./admin/member_list.jsp");
//		forward.setRedirect(false);
		return forward;
	}

}

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
		//�迭 ũ�� 0���� if�� �۵� ���� �� forward = null ->fail �ݹ��Լ� ����
		
		return forward;
	}

}

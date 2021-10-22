package action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberAlignService;
import vo.ActionForward;
import vo.MemberBean;
import vo.PageInfo;

public class MemberAlignAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		int page =1;//���� ������ ��ȣ�� ������ ����(�⺻��1)
		int limit = 10;//���������� ǥ���� �Խù� ���� ������ ����(�ִ� 10)
		
		//���� page �Ķ���Ͱ� ������ ��� �ش� �Ķ������ ������ page ������ ��ü
		if(request.getParameter("page")!=null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		String alignType = request.getParameter("align");
		System.out.println("MemberAlignAction - " + alignType);
		
		
		MemberAlignService service = new MemberAlignService();
		
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();
		
		list = service.memberAlign(alignType);
		
		
		
		int listCount = service.getListCount();
		
		int maxPage = (int)((double)listCount / limit + 0.95); // 0.95 �� �ø�ó���� ���� ����
		
		// 2. ���� ���������� ������ ���� ������ ��(1, 11, 21 ������ ��)
		int startPage = ((int)((double)page / 10 + 0.9) - 1) * 10 + 1;
		
		// 3. ���� ���������� ������ ������ ������ ��(10, 20, 30 ������ ��)
		int endPage = startPage + 10 - 1;
		
		// 4. ������ �������� ���� ���������� ǥ���� �ִ� ������(��ü ������ ��)���� Ŭ ���
		//    ������ ������ ��ȣ�� ��ü ������ ��ȣ�� ��ü
		if(endPage > maxPage) {
			endPage = maxPage;
		}

		//���� ������ ������ Pageinfo�� ��ü�� ����

		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);

		//request��ü�� PageInfo��ü�� ArrayList<BoardBean>��ü ����
		// =>setAttribute()�޼��� ���
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("list", list);
		request.setAttribute("alignType", alignType);
		forward.setPath("./admin/member_list.jsp");
		forward.setRedirect(false);
		return forward;
	}

}

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
		
		int page =1;//현재 페이지 번호를 저장할 변수(기본값1)
		int limit = 10;//한페이지에 표시할 게시물 수를 저장할 변수(최대 10)
		
		//만약 page 파라미터가 존재할 경우 해당 파라미터의 값으로 page 변수값 교체
		if(request.getParameter("page")!=null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		String alignType = request.getParameter("align");
		System.out.println("MemberAlignAction - " + alignType);
		
		
		MemberAlignService service = new MemberAlignService();
		
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();
		
		list = service.memberAlign(alignType);
		
		
		
		int listCount = service.getListCount();
		
		int maxPage = (int)((double)listCount / limit + 0.95); // 0.95 는 올림처리를 위한 덧셈
		
		// 2. 현재 페이지에서 보여줄 시작 페이지 수(1, 11, 21 페이지 등)
		int startPage = ((int)((double)page / 10 + 0.9) - 1) * 10 + 1;
		
		// 3. 현재 페이지에서 보여줄 마지막 페이지 수(10, 20, 30 페이지 등)
		int endPage = startPage + 10 - 1;
		
		// 4. 마지막 페이지가 현재 페이지에서 표시할 최대 페이지(전체 페이지 수)보다 클 경우
		//    마지막 페이지 번호를 전체 페이지 번호로 대체
		if(endPage > maxPage) {
			endPage = maxPage;
		}

		//계산된 페이지 정보를 Pageinfo에 객체에 저장

		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);

		//request객체에 PageInfo객체와 ArrayList<BoardBean>객체 저장
		// =>setAttribute()메서드 사용
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("list", list);
		request.setAttribute("alignType", alignType);
		forward.setPath("./admin/member_list.jsp");
		forward.setRedirect(false);
		return forward;
	}

}

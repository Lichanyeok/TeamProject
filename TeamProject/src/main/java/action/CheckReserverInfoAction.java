package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.CheckReserverInfoService;
import vo.ActionForward;
import vo.MemberBean;
import vo.ReserveBean;

public class CheckReserverInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String reserve_code = request.getParameter("reserve_code");
		System.out.println("CheckReserverInfoAction id : " + id + ", pass : "+pass + ", reserve_code : " + reserve_code);
		
		MemberBean bean = new MemberBean();
		bean.setId(id);
		bean.setPass(pass);
		CheckReserverInfoService service = new CheckReserverInfoService();
		boolean isLoginSuccess = service.loginMember(bean);
		
		
		if(isLoginSuccess) {
			System.out.println("올바른 유저 정보");
			boolean isRightCode = service.isRightCode(reserve_code);
			
			if(isRightCode) {
				ArrayList<ReserveBean> resList = service.getResList(reserve_code);
				request.setAttribute("resList", resList);
				forward.setPath("./reserve/reserver_info_result.jsp");
				forward.setRedirect(false);
			}else {
				System.out.println("존재하지 않는 예약코드 입니다.");
			}
			
		}else {
			System.out.println("올바르지 못한 유저정보 입니다");
		}

		
		return forward;
	}

}

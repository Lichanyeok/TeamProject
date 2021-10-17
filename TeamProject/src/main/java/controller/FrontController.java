package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.MemberJoinProAction;
import action.MemberLoginProAction;
import action.MemberLogoutAction;
import action.MemberManagementAction;
import action.MemberManagementProAction;
import vo.ActionForward;

/**
 * Servlet implementation class MemberFrontController
 */
@WebServlet("*.do")
public class FrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String command = request.getServletPath();
		System.out.println("MemberFrontController");
		System.out.println(command);
		ActionForward forward = null;
		Action action = null;
		if(command.equals("/MemberLoginFormAction.do")) {
			forward = new ActionForward();
			forward.setPath("./member/memberLogin.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberJoinFormAction.do")) {
			forward = new ActionForward();
			forward.setPath("./member/memberJoin.jsp");
			forward.setRedirect(true);
		}else if(command.equals("/member/MemberJoinProAction.do")) {
			System.out.println("/MemberJoinProAction - controller");
			action = new MemberJoinProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/MemberLoginProAction.do")) {
			System.out.println("MemberLoginProAction-cotroller");
			action = new MemberLoginProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/MemberManagementFormAction.do")) {
			forward = new ActionForward();
			forward.setPath("./member/member_management_form.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberManagementAction.do")) {
			action = new MemberManagementAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberManagementProAction.do")) {
			action = new MemberManagementProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberLogoutForm.do")) {
			action = new MemberLogoutAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// -----------------------------예약 관련 컨트롤러 ---------------------------------------
			
		}else if(command.equals("/Reserve.do")) {
			forward = new ActionForward();
			forward.setPath("./reserve/reserve_main.jsp");
			forward.setRedirect(false);
		}
		
		// -------------------------------리뷰 관련 컨트롤러 ------------------------------------
		else if(command.equals("/Review.do")) {
			forward = new ActionForward();
			forward.setPath("./review/review_main.jsp");
			forward.setRedirect(false);
		}
		//------------------------------ 공지사항 관련 컨트롤러 ---------------------------------
		else if(command.equals("/Notice.do")) {
			forward = new ActionForward();
			forward.setPath("./notice/notice_main.jsp");
			forward.setRedirect(false);
		}
		//----------------------------- 고객센터 관련 컨트롤러 ----------------------------------
		else if(command.equals("/CustomerCenter.do")) {
			forward = new ActionForward();
			forward.setPath(".//customer_center/customer_main.jsp");
			forward.setRedirect(false);
		}
		if(forward!=null){
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dispatch = request.getRequestDispatcher(forward.getPath());
				dispatch.forward(request, response);
			}
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}

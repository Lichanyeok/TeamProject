package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.BoardListAction;
import action.MemberJoinProAction;
import action.MemberLoginProAction;
import action.MemberLogoutAction;
import action.MemberManagementAction;
import action.MemberManagementProAction;
import action.WriteFormProAction;
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
			forward.setRedirect(false);
		}else if(command.equals("/MemberJoinProAction.do")) {
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
		}else if(command.equals("/WriteForm.do")) {
			// 글쓰기 작업을 위한 뷰페이지로 포워딩
			forward = new ActionForward();
			forward.setPath("/board/WriteForm.jsp");
			forward.setRedirect(false); // Dispatcher 방식(기본값이므로 생략 가능)
		} else if(command.equals("/WriteFormPro.do")) { 
			action = new WriteFormProAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(command.equals("/CustomerCommentList.do")) { 
			action = new BoardListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}  else if(command.equals("/BoardList.do")) { 
			action = new BoardListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
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

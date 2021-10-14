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
			forward.setRedriect(false);
		}else if(command.equals("/MemberJoinFormAction.do")) {
			forward = new ActionForward();
			forward.setPath("./member/memberJoin.jsp");
			forward.setRedriect(false);
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
		}
		
		if(forward!=null){
			if(forward.isRedriect()) {
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

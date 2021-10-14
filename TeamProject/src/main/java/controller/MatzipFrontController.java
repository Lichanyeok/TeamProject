package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.MatzipListAction;

import vo.ActionForward;

/**
 * Servlet implementation class MemberFrontController
 */
@WebServlet("*.mz")
public class MatzipFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String command = request.getServletPath();
		ActionForward forward = null;
		Action action = null;
		if(command.equals("/MatzipList.mz")) {
			action = new MatzipListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
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

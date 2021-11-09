package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.GoReserveAction;
import action.MatzipListAction;
import action.MatzipListInsertAction;
import action.MatzipModifyAction;
import action.MatzipMyStoreAction;
import action.ReservationListAction;
import action.MatzipInfoAction;
import vo.ActionForward;

/**
 * Servlet implementation class MemberFrontController
 */
@WebServlet("*.mz")
public class MatzipFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String command = request.getServletPath();
		System.out.println(command);
		ActionForward forward = null;
		Action action = null;
		
		if(command.equals("/MatzipSearch.mz")) {
			forward=new ActionForward();
			forward.setPath("./search/matzip_search_list.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MatzipList.mz")) {			
			action = new MatzipListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MatzipInfo.mz")) {
			action = new MatzipInfoAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {				
				e.printStackTrace();
			}
		}else if(command.equals("/GoReserve.mz")) {
			action = new GoReserveAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {		
				e.printStackTrace();
			}
		}else if(command.equals("/MatzipMyStore.mz")) {
			action = new MatzipMyStoreAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {		
				e.printStackTrace();
			}
		}else if(command.equals("/MatzipModify.mz")) {
			forward=new ActionForward();
			forward.setPath("./search/search_modify.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MatzipModifyPro.mz")) {
			action = new MatzipModifyAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {		
				e.printStackTrace();
			}
		}else if(command.equals("/MatzipInsertForm.mz")) {
			forward=new ActionForward();
			forward.setPath("./search/search_insert.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MatzipListInsert.mz")) {
			action = new MatzipListInsertAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ReservationList.mz")) {
			action = new ReservationListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ReservationForm.mz")) {
			forward=new ActionForward();
			forward.setPath("./search/reservation.jsp");
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

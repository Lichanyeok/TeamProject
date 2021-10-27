package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ReviewDeleteProAction;
import action.ReviewListAction;
import action.ReviewModifyFormAction;
import action.ReviewModifyProAction;
import action.ReviewWriteProAtion;
import vo.ActionForward;

@WebServlet("*.re")
public class Contoller extends HttpServlet {
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		  // POST 방식 요청에 대한 한글 처리(UTF-8)
	      request.setCharacterEncoding("UTF-8");
	      
	      // 요청 URL 에 대한 작업을 구분하기 위해 서블릿 주소 추출하여 command 변수에 저장
	      String command = request.getServletPath();
	      System.out.println("command : " + command);
	      
	      // Action 클래스로부터 리턴받아 포워딩 정보를 관리하는 ActionForward 타입 변수 선언
	      ActionForward forward = null;
	      
	      // 각 Action 클래스의 인스턴스를 공통으로 관리하는 Action 타입 변수 선언
	      Action action = null;
	      
	      
	      if(command.equals("/ReviewWrite.re")) {
	    	  System.out.println("controller - /ReviewWrite.re");
	    	  
	    	  forward = new ActionForward();
	    	  forward.setPath("/review/rev_write.jsp");
	    	  forward.setRedirect(false);
	      } else if(command.equals("/ReviewWritePro.re")) {
	    	  System.out.println("controller - /ReviewWritePro.re"); 
	    	  
	    	  action = new ReviewWriteProAtion();
	    	  
	    	  try {
					action.execute(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				} 
	      } else if(command.equals("/ReviewStore.re")) {
	    	  System.out.println("controller - /ReviewStore.re");
	    	  
//	    	  forward = new ActionForward();
//	    	  forward.setPath("/practice/review/rev_store.jsp");
//	    	  forward.setRedirect(false);
	    	  action = new ReviewListAction(); // Action 인터페이스로 업캐스팅
	    	  try {
	    		// 업캐스팅 후에도 공통 메서드(상속 받은 메서드)는 호출이 가능하므로
	    		// Action 타입으로 execute() 메서드 호출 가능함
				forward = action.execute(request, response);
	    	  } catch (Exception e) {
				e.printStackTrace();
	    	  }
	    	  
	      } else if(command.equals("/ReviewList.re")) {
	    	  System.out.println("controller - /ReviewList.re");
	    	  // 글목록 조회 작업 요청을 위한 비즈니스 로직 수행 필요하므로
	    	  // Action 클래스(Controller 역할)에 대한 접근을 위해
	    	  // BoardListAction 클래스 인스턴스 생성 후 execute()
	    	  // => 파라미터 : request, response
	    	  // => 리턴타입 : ActionForward
	    	  // => 위임받은 Exception 예외 처리(try ~ catch) 필요
	    	  
//	    	  BoardListAction action = new BoardListAction();
	    	  action = new ReviewListAction(); // Action 인터페이스로 업캐스팅
	    	  try {
	    		// 업캐스팅 후에도 공통 메서드(상속 받은 메서드)는 호출이 가능하므로
	    		// Action 타입으로 execute() 메서드 호출 가능함
				forward = action.execute(request, response);
	    	  } catch (Exception e) {
				e.printStackTrace();
	    	  } // try catch 끝
				
	      } else if(command.equals("/ReviewModify.re")) {
	    	  System.out.println("controller - /ReviewModify.re"); 
	    	  
	    	  action = new ReviewModifyFormAction(); // Action 인터페이스로 업캐스팅
	    	  try {
	    		// 업캐스팅 후에도 공통 메서드(상속 받은 메서드)는 호출이 가능하므로
	    		// Action 타입으로 execute() 메서드 호출 가능함
				forward = action.execute(request, response);
	    	  } catch (Exception e) {
				e.printStackTrace();
	    	  } // try catch 끝 
	    	  
	      } else if(command.equals("/ReviewModifyPro.re")) {
	    	  System.out.println("controller - /ReviewModifyPro.re"); 
	    	  
	    	  action = new ReviewModifyProAction(); // Action 인터페이스로 업캐스팅
	    	  try {
	    		// 업캐스팅 후에도 공통 메서드(상속 받은 메서드)는 호출이 가능하므로
	    		// Action 타입으로 execute() 메서드 호출 가능함
				forward = action.execute(request, response);
	    	  } catch (Exception e) {
				e.printStackTrace();
	    	  } // try catch 끝 
	    	  
	      } else if(command.equals("/ReviewDelete.re")) {
	    	  System.out.println("controller - /ReviewDelete.re"); 
	    	  
	    	  forward = new ActionForward();
	    	  forward.setPath("/review/rev_delete.jsp");
	    	  forward.setRedirect(false);
	    	  
	      } else if(command.equals("/ReviewDeletePro.re")) {
	    	  System.out.println("controller - /ReviewDeletePro.re"); 
	    	  
	    	  action = new ReviewDeleteProAction(); // Action 인터페이스로 업캐스팅
	    	  try {
	    		// 업캐스팅 후에도 공통 메서드(상속 받은 메서드)는 호출이 가능하므로
	    		// Action 타입으로 execute() 메서드 호출 가능함
				forward = action.execute(request, response);
	    	  } catch (Exception e) {
				e.printStackTrace();
	    	  } // try catch 끝 
	    	  
	      } else if(command.equals("/ReviewSort.re")) {
	    	  System.out.println("controller - /ReviewSort.re"); 
	    	  
	    	  forward = new ActionForward();
	    	  forward.setPath("/review/rev_list.jsp");
	    	  forward.setRedirect(false);
	    	  
	      } else if(command.equals("/ReviewLikeScore.re")) {
	    	  System.out.println("controller - /ReviewLikeScore.re"); 
	    	  
	    	  forward = new ActionForward();
	    	  forward.setPath("/review/rev_like_score.jsp");
	    	  forward.setRedirect(false);
	    	  
	      } 
	      
	      
	      
	      
	      /*
	       * -----------------------------------------------------------------------
	       * 작업 수행 후 리턴받은 ActionForward 객체의 정보를 사용하여 
	       * 포워딩 작업을 공통으로 수행
	       * - Redirect 방식과 Dispatcher 방식을 구분하여 각기 다른 방식으로 포워딩
	       * - 필요한 정보
	       *   1) 포워딩 경로(URL)
	       *   2) 포워딩 방식(Redirect or Dispatcher)
	       */
	      // 1. ActionForward 객체가 비어있지 않은지 판별
	      if(forward != null) {
	         // 2. ActionForward 객체 내의 isRedirect 값이 true(= Redirect 방식) 인지 판별
	         if(forward.isRedirect()) { // true = Redirect 방식
	            // response 객체의 sendRedirect() 메서드를 호출하여 Redirect 방식 포워딩
	            // => 파라미터 : ActionForward 객체의 포워딩 경로(path)
	            response.sendRedirect(forward.getPath());
	         } else { // false = Dispatcher 방식
	            // request 객체의 getRequestDispatcher() 메서드를 호출하여 포워딩 경로 설정
	            // => 파라미터 : ActionForward 객체의 포워딩 경로(path)
	            //    리턴타입 : RequestDispatcher
	            RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
	            // RequestDispatcher 객체의 forward() 메서드를 호출하여 포워딩 작업 수행
	            // => 파라미터 : request, response 객체
	            dispatcher.forward(request, response);
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

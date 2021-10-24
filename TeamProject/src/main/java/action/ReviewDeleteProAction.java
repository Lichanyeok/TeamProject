package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReviewDeleteProService;
import vo.ActionForward;

public class ReviewDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewDeleteProAction");
		
		ActionForward forward = null;
		
		//아이디, 비밀번호 및 리뷰 번호 값 가져오기
//		String rev_name = request.getParameter("sId"); // 현재 로그인 중인 아이디 값 가져오기
		String rev_name = request.getParameter("rev_name"); // DB연결이 안되어 있어 임의 값 지정.
		String rev_pass = request.getParameter("rev_pass");
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		
		System.out.println("rev_name : " + rev_name + ", rev_pass : " + rev_pass + ", rev_num : " + rev_num);
		
		// BoardDeleteProService 클래스 인스턴스 생성 후
		ReviewDeleteProService svc = new ReviewDeleteProService();
		
		// isArticleWrite() 메서드를 호출하여 패스워드 일치 여부 판별(본인 확인)
		// => 파라미터 : 글번호, 패스워드   리턴타입 : boolean(isRightUser)
		Boolean isRightUser = svc.isArticleWrite(rev_name, rev_pass);
		System.out.println("isRightUser : " + isRightUser);
		
		if(!isRightUser) { // 작업 결과가 false 일 경우
			// 1) 실패 시 자바스크립트를 사용하여 "삭제 권한 없음!" 출력 후 이전페이지로 돌아가기
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제 권한 없음!')");
			out.println("history.back()");
			out.println("</script>");
		} else { // 작업 결과가 true 일 경우
			boolean isDeleteSuccess = svc.removeArticle(rev_num);
			System.out.println("Action_isDeleteSuccess : " + isDeleteSuccess);
			
			if(!isDeleteSuccess) { // 작업 결과가 false 일 경우
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('삭제 실패!')");
				out.println("history.back()");
				out.println("</script>");
			} else { // 작업 결과가 true 일 경우
				forward = new ActionForward();
				forward.setPath("./ReviewStore.re");
				forward.setRedirect(true);
			}
		}
		
		return forward;
	}

}

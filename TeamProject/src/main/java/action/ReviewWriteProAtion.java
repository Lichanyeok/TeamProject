package action;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import vo.ReviewBean;
import svc.ReviewWriteProService;
import vo.ActionForward;

public class ReviewWriteProAtion implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewWriteProAtion");
		
		// 포워딩 정보를 관리하는 ActionForward 타입 변수 선언
		ActionForward forward = null;
		
		// 리뷰 쓰기 비즈니스 로직 처리를 위한 준비를 수행하고
		// 게시물 정보를 서비스 클래스를 통해 DAO 로 비즈니스 로직 처리를 요청
		// 1. 업로드 관련 정보를 처리하기 위해 MultipartRequest 객체 생성 작업 수행
		String realFolder = ""; // 업로드 할 파일이 저장되는 실제 경로
		String saveFolder = "./upload"; // 이클립스에서 관리하는 가상 업로드 폴더
		int fileSize = 1024 * 1024 * 10; // 업로드 사이즈. Byte -> KB -> MB -> 10MB 로 단위 변환
		
		// 현재 서블릿을 처리하는 서블릿컨텍스트 객체를 가져와서 
		// 프로젝트상의 가상 업로드 경로에 대한 실제 경로 알아내기
		ServletContext context = request.getServletContext();
		realFolder = context.getRealPath(saveFolder);
		System.out.println(realFolder);
		
		MultipartRequest multi = new MultipartRequest(
				request, // 실제 요청 정보가 포함되어 있는 request 객체
				realFolder, // 실제 업로드 폴더 경로
				fileSize, // 파일 크기
				"UTF-8", // 한글 파일명에 대한 인코딩 방식 지정
				new DefaultFileRenamePolicy() // 동일한 파일명에 대한 중복 처리 담당 객체
		);
		
		// BoardBean 객체에 전달받은 파라미터 저장
		ReviewBean rb = new ReviewBean();
		rb.setRan_num(multi.getParameter("ran_num"));
		rb.setRev_store(multi.getParameter("rev_store"));
		rb.setRev_name(multi.getParameter("rev_name"));
		rb.setRev_score(Integer.parseInt(multi.getParameter("rating")));
		rb.setRev_content(multi.getParameter("rev_content"));
		rb.setRev_menu(multi.getParameter("rev_menu"));
		
//		System.out.println(multi.getParameter("rating"));
//		System.out.println("action_ranNum : " + multi.getParameter("ran_num"));
		
		// 주의! 파일 정보를 가져올 때 multi.getParameter("board_file") 사용 금지!
		// 파일명을 활용하여 실제 파일에 접근하기
		// => MultipartRequest 객체의 getFileNames().nextElement() 메서드 결과를 문자열로 변환 후
		//    MultipartRequest 객체의 getXXXName() 메서드를 통해 파일명 가져오기
		//    1) getFilesystemName() 메서드 : 업로드 된 실제 파일명(중복 처리 후의 이름)
		//    2) getOriginalFileName() 메서드 : 원본 파일명
		String file = multi.getFileNames().nextElement().toString();
		String rev_pic = multi.getFilesystemName(file);
		String rev_pic_origin = multi.getOriginalFileName(file);
		rb.setRev_pic(rev_pic);
		rb.setRev_pic_origin(rev_pic_origin);
		System.out.println("rev_pic : " + rev_pic + ", rev_pic_origin : " + rev_pic_origin);
		
		// Action 클래스에서 비즈니스 로직 처리를 위한 작업 요청
		// => 단, BoardDAO 객체에 직접 접근하는 것이 아니라
		//    비즈니스 로직 처리를 담당할 Service 객체에 작업 요청만 수행하면
		//    Service 객체가 DAO 객체와 상호작용을 통해 비즈니스 로직을 처리함
		// 1) BoardWriteProService 클래스 인스턴스 생성
		ReviewWriteProService svc = new ReviewWriteProService();
		
		// 2) BoardWriteProService 인스턴스의 registArticle() 메서드 호출하여 게시물 등록 요청
		//    => 파라미터 : BoardBean 객체, 리턴타입 : boolean(isWriteSuccess)
		boolean isWriteSuccess = svc.registReview(rb);
		
		System.out.println("ReviewWriteProAtion : " + isWriteSuccess);
		
		// 글쓰기 결과(isWriteSuccess)를 판별 
		if(!isWriteSuccess) { // 작업 결과가 false 일 경우
			// 1) 실패 시 자바스크립트를 사용하여 "게시물 등록 실패!" 출력 후 이전페이지로 돌아가기
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('게시물 등록 실패!')");
			out.println("history.back()");
			out.println("</script>");
		} else { // 작업 결과가 true 일 경우
			// 2) 성공 시 ActionForward 객체를 통해 BoardList.bo 경로, Redirect 방식 포워딩 설정
			// ActionForward 객체를 생성하여 BoardList.bo 서블릿 주소 요청
			// => request 객체 유지 불필요, 주소 유지 불필요
			// => 새로운 요청을 발생시키므로 Redirect 방식 포워딩
			forward = new ActionForward();
	    	forward.setPath("./review/main.jsp");
	    	forward.setRedirect(true);
		}
		
		// ActionForward 객체 리턴
		return forward;
	}

}

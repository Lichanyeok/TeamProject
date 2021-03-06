package action;

import java.io.PrintWriter;
import java.net.URLEncoder;

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
		
		// ReviewBean 객체에 전달받은 데이터 파라미터 저장
		ReviewBean rb = new ReviewBean();
		rb.setRan_num(multi.getParameter("ran_num"));
		rb.setRev_store(multi.getParameter("rev_store"));
		rb.setRev_name(multi.getParameter("rev_name"));
		rb.setRev_score(Integer.parseInt(multi.getParameter("rating")));
		rb.setRev_content(multi.getParameter("rev_content"));
		rb.setRev_menu(multi.getParameter("rev_menu"));
	
		// ReviewBean 객체에 전달받은 사진 파라미터 저장
		String file = multi.getFileNames().nextElement().toString();
		String rev_pic = multi.getFilesystemName(file);
		String rev_pic_origin = multi.getOriginalFileName(file);
		rb.setRev_pic(rev_pic);
		rb.setRev_pic_origin(rev_pic_origin);
		System.out.println("rev_pic : " + rev_pic + ", rev_pic_origin : " + rev_pic_origin);
		
		ReviewWriteProService svc = new ReviewWriteProService();
		
		// 2) BoardWriteProService 인스턴스의 registArticle() 메서드 호출하여 게시물 등록 요청
		//    => 파라미터 : BoardBean 객체, 리턴타입 : boolean(isWriteSuccess)
		boolean isWriteSuccess = svc.registReview(rb);
		boolean isUpdateSuccess=svc.updateStar(rb);
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
			if(isUpdateSuccess) {
				String nickName = URLEncoder.encode(multi.getParameter("rev_name"), "UTF-8"); // url 한글처리
				forward = new ActionForward();
				forward.setPath("./Review.re?nickName=" + nickName);
				forward.setRedirect(true);
			}
			else{
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('게시물 등록 실패!')");
				out.println("history.back()");
				out.println("</script>");
			}
		}
		
		// ActionForward 객체 리턴
		return forward;
	}

}

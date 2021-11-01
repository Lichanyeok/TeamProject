package action;

import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.ReviewModifyProService;
import vo.ActionForward;
import vo.ReviewBean;

public class ReviewModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewModifyProAction");
		
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
		
		//아이디, 비밀번호 및 리뷰 번호 값 가져오기
		String rev_name = multi.getParameter("rev_name");
		String rev_pass = multi.getParameter("rev_pass");
		int rev_num = Integer.parseInt(multi.getParameter("rev_num"));
		
		// 등록된 사진을 그대로 사용할 경우
		// 저장된 사진 이름 값 가져오기
		String prev_pic = multi.getParameter("prev_pic");
		String prev_pic_origin = multi.getParameter("prev_pic_origin");
		System.out.println("가져온 prev_pic : " + prev_pic + ", 가져온 prev_pic_origin : " + prev_pic_origin);
		
		// BoardBean 객체에 전달받은 파라미터 저장
		ReviewBean rb = new ReviewBean();
		rb.setRev_num(rev_num);
		rb.setRev_score(Integer.parseInt(multi.getParameter("rating")));
		rb.setRev_content(multi.getParameter("rev_content"));
		
		System.out.println(multi.getParameter("rating"));
		
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
		
		rb.setPrev_pic(prev_pic);
		rb.setPrev_pic_origin(prev_pic_origin);
		System.out.println("저장할 prev_pic : " + prev_pic + ", 저장할 prev_pic_origin : " + prev_pic_origin);
		
		// ReviewModifyProService 클래스 인스턴스 생성 후
		ReviewModifyProService svc = new ReviewModifyProService();
				
		// isArticleWrite() 메서드를 호출하여 패스워드 일치 여부 판별(본인 확인)
		// => 파라미터 : 글번호, 패스워드   리턴타입 : boolean(isRightUser)
		Boolean isRightUser = svc.isArticleWrite(rev_name, rev_pass);
		System.out.println("isRightUser : " + isRightUser);
				
		if(!isRightUser) { // 작업 결과가 false 일 경우
			// 1) 실패 시 자바스크립트를 사용하여 "삭제 권한 없음!" 출력 후 이전페이지로 돌아가기
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('수정 권한 없음!')");
			out.println("history.back()");
			out.println("</script>");
		} else { // 작업 결과가 true 일 경우
			boolean isModifyArticleSuccess = svc.modifyArticle(rb);
			System.out.println("Action_isModifyArticleSuccess : " + isModifyArticleSuccess);
			
			if(!isModifyArticleSuccess) { // 작업 결과가 false 일 경우
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('수정 실패!')");
				out.println("history.back()");
				out.println("</script>");
			} else { // 작업 결과가 true 일 경우
				String nickName = URLEncoder.encode(rev_name, "UTF-8"); // url 한글처리
				forward = new ActionForward();
				forward.setPath("./Review.re?nickName=" + nickName);
				forward.setRedirect(true);
			}
		}
		
		return forward;
	}

}

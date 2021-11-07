package action;

import java.util.Enumeration;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.MatzipListInsertService;
import vo.ActionForward;
import vo.SearchBean;

public class MatzipListInsertAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward;
		
		//-----------로고 이미지 업로드
		String savePath="/upload";
		String uploadPath=request.getRealPath("/upload");
		
		int size=1024*1024*10;
		MultipartRequest multi= new MultipartRequest(
					request,
					uploadPath,
					size,
					"UTF-8",
					new DefaultFileRenamePolicy()
				);
		String id=multi.getParameter("id");
		String place_name=multi.getParameter("place_name");
		String business_license=multi.getParameter("business_license");
		String category=multi.getParameter("category");
		String tell_number=multi.getParameter("tell_number");
		String road_address=multi.getParameter("road_address");
		String jibun_address=multi.getParameter("jibun_address");
		
		//업로드 파일에 대한 정보는 getParameter() 로 가져오는 것이 아니라
		//다른 방법으로 업로드 파일에 대해 접근해야함
		//1.MultipartRequest 객체의 getFileNames()메서드를 통해
		// 	업로드 파일명에 대한 정보를 Enumeration 객체 타입으로 리턴받기
		Enumeration files=multi.getFileNames();
		//2. Enumeration 객체의 nextElement() 메서드를 호출하여
		// 다음파일에 대한 파일명을 가져오기(반복 수행 가능)
		String file=files.nextElement().toString();
		
		String fileName=multi.getFilesystemName(file);
		String originalFileName=multi.getOriginalFileName(file);	
		
		SearchBean bean=new SearchBean();
		bean.setId(id);
		bean.setPlace_name(place_name);
		bean.setBusiness_lisence(business_license);
		bean.setCategory(category);
		bean.setTell_number(tell_number);
		bean.setRoad_address(road_address);
		bean.setJibun_address(jibun_address);
		bean.setLogo_img(fileName);
		bean.setOri_logo_img(originalFileName);
		
		MatzipListInsertService service=new MatzipListInsertService();
		service.insertList(bean);
		
		forward = new ActionForward();
		forward.setPath("MatzipSearch.mz");
		forward.setRedirect(true);
		return forward;
		
	}

}

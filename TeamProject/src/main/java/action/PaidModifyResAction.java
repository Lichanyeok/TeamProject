package action;

import java.io.PrintWriter;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import dao.ReserveDAO;
import message.SendMessage;
import svc.PaymentService;
import vo.ActionForward;
import vo.CouponBean;
import vo.MemberBean;
import vo.ReserveBean;

public class PaidModifyResAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		System.out.println("PaidModifyResAction");
		String store_name = request.getParameter("store_name");
		String load_address = request.getParameter("load_address");
		String address = request.getParameter("address");
		String store_number = request.getParameter("store_number");
		String category = request.getParameter("category");	
		String id = request.getParameter("reserve_id");
		String menu1 = "SetA";
		String menu2 = "SetB";
		String menu3 = "SetC";
		
		//category별 메뉴 명
		if(category.equals("한식")) {
			menu1="제육덮밥";
			menu2="김치찌개";
			menu3="삼겹살";
		}else if(category.equals("양식")) {
			menu1="파스타";
			menu2="피자";
			menu3="샐러드";
		}else if(category.equals("중식")) {
			menu1="짜장면";
			menu2="짬뽕";
			menu3="탕수육";
		}else if(category.equals("일식")) {
			menu1="소바";
			menu2="초밥";
			menu3="텐동";
		}else if(category.equals("치킨")) {
			menu1="로제크림치킨";
			menu2="갈릭간장치킨";
			menu3="크리스피치킨";
		}else if(category.equals("피자")) {
			menu1="블랙앵거스 스테이크 피자";
			menu2="블랙타이거 쉬림프 피자 ";
			menu3="뉴욕오리진 피자";
		}else if(category.equals("퓨전")) {
			menu1="김치주스";
			menu2="마늘전";
			menu3="불고기파스타";
		}else if(category.equals("찜")) {
			menu1="아구찜";
			menu2="통큰 뼈 찜";
			menu3="해물 뼈 찜";
		}else if(category.equals("고깃집")) {
			menu1="삼겹살";
			menu2="목살";
			menu3="돼지갈비";
		}else if(category.equals("족발")) {
			menu1="오리지날 한방 족발";
			menu2="연잎 보쌈";
			menu3="불족발";
		}else if(category.equals("뷔페")) {
			menu1="런치 샐러드바 1인";
			menu2="런치 샐러드바&스테이크 2인";
			menu3="디너 샐러드바 1인";
		}else if(category.equals("코스요리")) {
			menu1="런치 샐러드바 1인";
			menu2="런치 샐러드바&스테이크 2인";
			menu3="디너 샐러드바 1인";
		}else {
			menu1="모듬사시미";
			menu2="런치세트A";
			menu3="런치세트B";
		};
		
		String strDate = request.getParameter("date");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//		String dtDate = format.format(strDate);
		Date date = format.parse(strDate);
		String reserve_date = format.format(date);
		System.out.println(reserve_date);
		String reserve_time = request.getParameter("reserve_time");
		int people = Integer.parseInt(request.getParameter("people"));
		String customerNeeds = request.getParameter("customerNeeds");
		int setA = Integer.parseInt(request.getParameter("setA")); 
		int setB = Integer.parseInt(request.getParameter("setB"));
		int setC = Integer.parseInt(request.getParameter("setC"));
		String total_order_menu = menu1+ ":" + setA + ", "+ menu2 + ":"+setB+", " + menu3 + ":"+setC;
		ReserveBean reserve = new ReserveBean(store_name, load_address, address, store_number, id,reserve_date, reserve_time, people, customerNeeds, setA, setB, setC, total_order_menu);
		reserve.setCategory(category);
		
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = db.jdbcUtil.getConnection();
		dao.setConnection(con);
		
		ArrayList<CouponBean> couponList = dao.getUserCouponList(id);
		
		System.out.println("couponList siz : " + couponList.size());
		System.out.println(reserve.toString());

		request.setAttribute("reserveBean", reserve);
		request.setAttribute("couponList", couponList);
		forward.setPath("./reserve/paid_modify_reserve_result.jsp");
		forward.setRedirect(false);
		db.jdbcUtil.close(con);
		return forward;
	}

}

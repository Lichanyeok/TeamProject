package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import message.SendMessage;
import svc.GetReserverInfoService;
import svc.GetStoreInfoService;
import vo.ActionForward;
import vo.MemberBean;

/**
 * @class ExampleSend
 * @brief This sample code demonstrate how to send sms through CoolSMS Rest API PHP
 */
public class ModifySendMessageAction implements Action{
    @Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    ActionForward forward = new ActionForward();
    System.out.println("SendMessageAction");
    String id=request.getParameter("id");
    
    //예약자 전화번호 찾기
    GetReserverInfoService service = new GetReserverInfoService(); 
    MemberBean bean =  service.getInfo(id);
    String mobile = bean.getMobile();
    System.out.println("id : " + id + " mobile : " + mobile);
    
    //들고 온 가게 정보
    String storeName = request.getParameter("store_name");
    String reserveDate = request.getParameter("reserve_date");
    String reserveTime = request.getParameter("reserve_time");
    String people = request.getParameter("people");
    String storeNumber = request.getParameter("storeNumber");
    System.out.println(storeName + " / " + reserveDate + " / " + reserveTime + " / " + people + "명 예약 변경 완료!.");
    
    String content = storeName + " / " + reserveDate + " / " + reserveTime + " / " + people + "명 예약 변경 완료!";
    SendMessage.sendMessage(mobile, content);
    
    GetStoreInfoService service2 = new GetStoreInfoService();
    String bossMobile = service2.getBossMobile(storeNumber);
    String content2 = "예약변경!! 변경사항 : "+reserveDate+" / "+reserveTime+" / "+people + "명 예약되었습니다! 자세한 사항은 마이스토어를 확인하세요";
    System.out.println("bossmobile : " + bossMobile + " contente2 : " +  content2);
    forward.setPath("./ReserveList.do");
    SendMessage.sendMessage(bossMobile, content2);
    forward.setRedirect(true);
	return forward;
   }
}
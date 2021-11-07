package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import message.SendMessage;
import svc.GetReserverInfoService;
import vo.ActionForward;
import vo.MemberBean;

/**
 * @class ExampleSend
 * @brief This sample code demonstrate how to send sms through CoolSMS Rest API PHP
 */
public class SendMessageAction implements Action{
    @Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    ActionForward forward = new ActionForward();
    System.out.println("SendMessageAction");
    String id=request.getParameter("id");
    
    //예약자 전화번호 찾기
    GetReserverInfoService service = new GetReserverInfoService(); 
    MemberBean bean =  service.getInfo(id);
    String mobile = bean.getMobile();
    System.out.println("mobile : " + mobile);
    
    //들고 온 가게 정보
    String storeName = request.getParameter("store_name");
    String reserveDate = request.getParameter("reserve_date");
    String reserveTime = request.getParameter("reserve_time");
    String people = request.getParameter("people");
    System.out.println(storeName + " / " + reserveDate + " / " + reserveTime + " / " + people + "명 예약되었습니다.");
    
    String content = storeName + " / " + reserveDate + " / " + reserveTime + " / " + people + "명 예약되었습니다.";
    SendMessage.sendMessage(mobile, content);
    
    forward.setPath("./ReserveList.do");
    forward.setRedirect(true);
	return forward;
   }
}
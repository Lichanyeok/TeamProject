package controller;

import action.*;
import vo.ActionForward;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;
import java.io.IOException;


@WebServlet("*.do")
public class FrontController extends HttpServlet {

	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String command = request.getServletPath();
		System.out.println("MemberFrontController");
		System.out.println(command);
		ActionForward forward = null;
		Action action = null;
		if(command.equals("/Matzip.do")) {
			forward = new ActionForward();
			forward.setPath("./index.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberLoginFormAction.do")) {
			forward = new ActionForward();
			forward.setPath("./member/memberLogin.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberJoinFormAction.do")) {
			forward = new ActionForward();
			forward.setPath("./member/join_step1.jsp");
			forward.setRedirect(true);
		}else if(command.equals("/member/MemberJoinProAction.do")) {
			System.out.println("/MemberJoinProAction - controller");
			action = new MemberJoinProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}else if(command.equals("/MemberLoginProAction.do")) {
			System.out.println("MemberLoginProAction-cotroller");
			action = new MemberLoginProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/MemberManagementFormAction.do")) {
			forward = new ActionForward();
			forward.setPath("./member/member_management_form.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/AdminManagementFormAction.do")) {
			forward = new ActionForward();
			forward.setPath("./admin/admin_main.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberManagementAction.do")) {
			action = new MemberManagementAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberManagementProAction.do")) {
			action = new MemberManagementProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberLogoutForm.do")) {
			action = new MemberLogoutAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberAlign.do")) {
			action = new MemberAlignAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/MemberDeleteAction.do")) {
			action = new MemberDeleteAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/ModifyMemberGrade.do")) {
			action = new ModifyMemberGradeAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/MemberGift.do")) {
			forward = new ActionForward();
			forward.setPath("./admin/gift_coupon.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/PublishCoupon.do")) {
			System.out.println("frontController publishAction");
			action = new PublishAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/FindId.do")) {
			System.out.println("find Id controller");
			action = new FindIdAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/FindPass.do")) {
			action = new FindPassAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/UpdatePass.do")) {
			action = new UpdatePassAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/MemberInfoDetail.do")){
			action = new MemberInfoDetailAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/GetCouponList.do")) {
			action = new GetListCouponAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/ModifyNickName.do")) {
			forward = new ActionForward();
			forward.setPath("./member/modify_nickname.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/ModifyNickNamePro.do")) {
			action = new ModifyNicknameAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/RequestAddStore.do")) {
			action = new AddStoreListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/AddStoreAction.do")){
			action = new AddStoreAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/GoFindPass.do")){
			forward = new ActionForward();
			forward.setPath("./member/find_pass2.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/GoFindId.do")){
			forward = new ActionForward();
			forward.setPath("./member/find_id2.jsp");
			forward.setRedirect(false);
		
			// -----------------------------?????? ?????? ???????????? ---------------------------------------
		}else if (command.equals("/member/SendAuthMail.do")) {
            action = new SendAuthMailAction();
            try {
                forward = action.execute(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
		}else if (command.equals("/MemberAuth.do")) {
                action = new MemberAuthAction();
                try {
                    forward = action.execute(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
		}else if(command.equals("/Reserve.do")) {
			forward = new ActionForward();
			forward.setPath("./reserve/reserve_main2.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/Payment.do")) {
			action = new payAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/GetList.do")) {
			action = new GetCouponListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else if(command.equals("/PaymentAction.do")){
			action = new PaymentAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/ReserveList.do")){
			action = new ReserveListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}else if(command.equals("/EACForm.do")) {
			forward = new ActionForward();
			forward.setPath("./reserve/EACform.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/CheckReserveInfo.do")) {
			action = new CheckReserverInfoAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}else if(command.equals("/ModiRes.do")) {
			action = new ModiResAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/ResCancle.do")) {
			action = new ResCancleAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/SendMessage.do")) {
			action = new SendMessageAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/ModifySendMessage.do")) {
			action = new ModifySendMessageAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/ModifyReserve.do")) {
			action = new ModifyReserveAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/PaidModiRes.do")) {
			action = new PaidModifyResAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else if(command.equals("/PaidResModifyReserve.do")) {
			forward = new ActionForward();
			forward.setPath("./reserve/paid_modify_reserve.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/PaidReserveModify.do")) {
			action = new PaidReserveModifyAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		// -------------------------------?????? ?????? ???????????? ------------------------------------
		else if(command.equals("/Review.do")) {
			forward = new ActionForward();
			forward.setPath("./review/review_main.jsp");
			forward.setRedirect(false);
		}
		//------------------------------ ???????????? ?????? ???????????? ---------------------------------
		else if(command.equals("/Notice.do")) {
			forward = new ActionForward();
			forward.setPath("./notice/notice_main.jsp");
			forward.setRedirect(false);
		}
		//----------------------------- ???????????? ?????? ???????????? ----------------------------------
		else if(command.equals("/CustomerCenter.do")) {
			forward = new ActionForward();
			forward.setPath("./customer_center/customer_main.jsp");
			forward.setRedirect(false);
			forward = new ActionForward();

		}else if(command.equals("/WriteForm.do")) {
			// ?????????????????? ?????????????????? ???????????? ??????????????????????????? ??????????????????
			forward = new ActionForward();
			forward.setPath("/board/WriteForm.jsp");
			forward.setRedirect(false); // Dispatcher ?????????(?????????????????????????????? ???????????? ????????????)
		} else if(command.equals("/WriteFormPro.do")) { 
			action = new WriteFormProAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(command.equals("/CustomerCommentList.do")) { 
			action = new BoardListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}  else if(command.equals("/BoardList.do")) { 
			action = new BoardListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/DetailList.do")) { 
			action = new detailCustommerCommentAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/WriteReply.do")) { 
			action = new WriteReplyAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/DeleteComment.do")) { 
			action = new DeleteCommentAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
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

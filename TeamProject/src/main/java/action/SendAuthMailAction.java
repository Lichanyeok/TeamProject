package action;

import dao.MemberDAO;
import db.jdbcUtil;
import mail.GenerateUserAuthenticationCode;
import mail.GoogleAuthentication;
import vo.ActionForward;
import vo.AuthInfoBean;

import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SendAuthMailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("SendAuthMailAction");
		ActionForward forward = null;
		
		String id = request.getParameter("id");
		String email = request.getParameter("email");

		GenerateUserAuthenticationCode genAuthCode = new GenerateUserAuthenticationCode(50);
		String authCode = genAuthCode.getAuthCode();
		System.out.println("인증코드 : " + authCode);
		
		String sender = "rxd0705@gmail.com";
		String receiver = email;
		String subject = "[맛집] 맛집 가입 인증 메일입니다.";
		String content = 
				"<a href=http://localhost:8080/TeamProject/MemberAuth.do?id=" + id +
				"&authCode=" + authCode + "><b>인증하려면 클릭하세요.</b></a>";
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtp.starttls.enable", true);
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.port", "587");
			properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
			properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

			Authenticator auth = new GoogleAuthentication();
			
			Session session = Session.getDefaultInstance(properties, auth);
			Message message = new MimeMessage(session);
			Address sender_address = new InternetAddress(sender, "맛집");
			Address receiver_address = new InternetAddress(receiver);
			message.setHeader("content-type", "text/html;charset=UTF-8");
			message.setFrom(sender_address);
			message.addRecipient(Message.RecipientType.TO, receiver_address);
			message.setSubject(subject);
			message.setContent(content, "text/html;charset=UTF-8");
			message.setSentDate(new Date());
			Transport.send(message);
		} catch (Exception e) {
			out.println("SMTP 서버 설정 문제 또는 서비스 문제 발생!");
			e.printStackTrace();
		}
		// ------------------------------------------------------------------
		Connection con = jdbcUtil.getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		AuthInfoBean authInfo = new AuthInfoBean();
		authInfo.setId(id);
		authInfo.setAuth_code(authCode);
		
		int insertCount = dao.insertAuthInfo(authInfo);
		
		if(insertCount > 0) {
			out.println("<script>");
			out.println("alert('인증 메일 발송')");
			out.println("</script>");

			con.commit();

			forward = new ActionForward();
			forward.setPath("../MemberLoginFormAction.do");
			forward.setRedirect(true);
		} else {
			con.rollback();
			out.println("<script>");
			out.println("alert('인증코드 등록 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		jdbcUtil.close(con);

		return forward;
	}

}
















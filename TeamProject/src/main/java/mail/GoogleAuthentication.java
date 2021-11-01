package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
	
	public GoogleAuthentication() {
		passAuth = new PasswordAuthentication("rxd0705@gmail.com", "ggsxkzxbqllixxdy");
	}

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
	
	
	
}












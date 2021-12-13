package suited.com.utils;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("khsuited@gmail.com","khsemi0719");
	}
}
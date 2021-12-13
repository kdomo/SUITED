package suited.com.utils;

import java.security.MessageDigest;

public class EncryptionUtils {

	public static String getSHA256(String password) {// SHA 256을 통해 비밀번호를 암호화해주는 메소드 생성
		StringBuffer result = new StringBuffer();

		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] salt = "이것은 kh1팀의 솔트입니다.".getBytes("UTF-8");
			digest.reset();
			digest.update(salt);
			byte[] chars = digest.digest(password.getBytes("UTF-8"));
			for (int i = 0; i < chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if (hex.length() == 1)
					result.append('0');
				result.append(hex);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
}

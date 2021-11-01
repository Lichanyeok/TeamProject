package action;

import java.util.Random;

public class GenerateUserAuthenticationCode {
	private String authCode;
	
	private final char[] codeTable = {
		'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
		'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
		'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
		'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
		'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'
	};
	
	public GenerateUserAuthenticationCode(int codeLength) {
		Random r = new Random();
		int tableLength = codeTable.length;
		
		StringBuffer buffer = new StringBuffer();
		
		for(int i = 0; i < codeLength; i++) {
			buffer.append(codeTable[r.nextInt(tableLength)]);
		}
		
		authCode = buffer.toString();
	}

	public String getAuthCode() {
		return authCode;
	}
	
}








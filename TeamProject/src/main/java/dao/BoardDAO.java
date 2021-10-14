package dao;

import java.sql.Connection;

public class BoardDAO {
	
	private BoardDAO() {
		
	}
	
	private static BoardDAO instance;
	
	public static BoardDAO getInstance() {
		System.out.println("getConnection");
		if(instance == null) {
			instance = new BoardDAO();
		}
		
		return instance;
	}

	Connection con;
	
	public void setConnection(Connection con) {
		System.out.println("setConnection");
		this.con = con;
	}
	
	public static String getRandomStr(int size) { //난수 발생 메서드 size로 크기 조절
		if(size > 0) {
			char[] tmp = new char[size];
			for(int i=0; i<tmp.length; i++) {
				int div = (int) Math.floor( Math.random() * 2 );
				
				if(div == 0) { // 0이면 숫자로
					tmp[i] = (char) (Math.random() * 10 + '0') ;
				}else { //1이면 알파벳
					tmp[i] = (char) (Math.random() * 26 + 'A') ;
				}
			}
			return new String(tmp);
		}
		return "ERROR : Size is required."; 
	}

}

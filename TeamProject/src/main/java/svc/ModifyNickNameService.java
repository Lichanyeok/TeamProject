package svc;

import dao.MemberDAO;
import static db.jdbcUtil.*;

import java.sql.Connection;
public class ModifyNickNameService {

	public boolean modifyNickName(String id, String nickName) {
		boolean isUpdateSuccess = false;
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		isUpdateSuccess = dao.modifyNickName(id,nickName);
		if(isUpdateSuccess) {
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		return isUpdateSuccess;
	}

}

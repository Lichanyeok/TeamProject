package svc;

import java.sql.Connection;

import dao.ReserveDAO;
import vo.MemberBean;
import static db.jdbcUtil.*;
public class GetReserverInfoService {

	public MemberBean getInfo(String id) {
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		MemberBean bean = dao.getInfo(id);
		
		return bean;
	}

}

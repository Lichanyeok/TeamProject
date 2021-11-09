package svc;

import java.sql.Connection;

import dao.ReserveDAO;
import static db.jdbcUtil.*;
public class GetStoreInfoService {

	public String getBossMobile(String storeNumber) {
		String bossMobile;
		ReserveDAO dao = ReserveDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		bossMobile = dao.getBossMobile(storeNumber);
		close(con);
		return bossMobile;
	}

}

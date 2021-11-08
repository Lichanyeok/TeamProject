package svc;
import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ReserveDAO;
import vo.ReserveBean;



public class ReservationListService {


	public ArrayList<ReserveBean> getReservationList(String store_name) {
		Connection con = getConnection();		
		ReserveDAO dao = ReserveDAO.getInstance();		
		dao.setConnection(con);
		
		ArrayList<ReserveBean> articleList = dao.getReservationList(store_name);
		
		close(con);	
		return articleList;
	}
}

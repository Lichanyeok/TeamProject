package svc;
import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ReserveDAO;
import vo.ReserveBean;



public class ReservationListService {


	public ArrayList<ReserveBean> getReservationList(String store_name,String reserve_date) {
		Connection con = getConnection();		
		ReserveDAO dao = ReserveDAO.getInstance();		
		dao.setConnection(con);
		
		ArrayList<ReserveBean> articleList = dao.getReservationList(store_name,reserve_date);
		
		close(con);	
		return articleList;
	}
}

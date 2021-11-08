package svc;

import dao.SearchDAO;
import static db.jdbcUtil.*;

import java.sql.Connection;
public class AddStoreService {

	public boolean updateStore(String lisences) {
		boolean isUpdate = false;
		String[] liseceArr = lisences.split(",");
		SearchDAO dao = SearchDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		int updateCount = 0;
		int count = 0;
		for(int i =0;i < liseceArr.length;i++) {
			updateCount = dao.updateStore(liseceArr[i]);
			if(updateCount>0) {
				count++;
				System.out.println(count);
			}
		}
		
		if(count==liseceArr.length) {
			isUpdate = true;
			
			close(con);
		}else {
			
			System.out.println("AddStoreService - FAIL");
		}
		
		
		return isUpdate;
	}

}

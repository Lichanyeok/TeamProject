package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MemberDAO;
import vo.MemberBean;
import static db.jdbcUtil.*;

public class ModifyMemberGradeService {

	public void ModifyMemberGrade(String id, int grade) {
		MemberDAO dao = MemberDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		System.out.println("ModifyMemberGradeService - " + id + " , " +grade);
		
		dao.modifyGrade(id,grade);
		commit(con);		
		close(con);
	}

}

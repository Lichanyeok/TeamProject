package vo;

import java.sql.Date;
/*
 * 제목, 내용, 회원의 id값 ,조회수, 날짜, 글번호, 
 create table CustomerComment(
 num int PRIMARY KEY AUTO_INCREMENT,
 id varchar(20),
 subject varchar(50) not null,
 content varchar(400) not null,
 readcount int not null,
 check varchar(50), -> 이부분에서 sql 오류가 있다는데?
 date date
 );

-------itwill에서-----
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| num       | int(11)      | NO   | PRI | NULL    | auto_increment |
| id        | varchar(45)  | YES  |     | NULL    |                |
| subject   | varchar(45)  | YES  |     | NULL    |                |
| content   | varchar(400) | YES  |     | NULL    |                |
| readcount | int(11)      | NO   |     | NULL    |                |
| check     | varchar(10)  | YES  |     | NULL    |                |
| date      | date         | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+


 */
public class BoardBean {

	private int num;
	private String id;
	private String subject;
	private String content;
	private int readcount;
	private String check; 
	private Date date;
	
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getNum()
	{
		return num;
	}
	public void setNum(int num)
	{
		this.num = num;
	}
	public String getCheck()
	{
		return check;
	}
	public void setCheck(String check)
	{
		this.check = check;
	}

	
	
}

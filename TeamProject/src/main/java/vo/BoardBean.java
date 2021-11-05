package vo;

import java.sql.Date;
/*
 * 제목, 내용, 회원의 id값 ,조회수, 날짜, 글번호, 
 create table CustomerComment(
 subject varchar(50) not null,
 id varchar(20),
 content varchar(400) not null,
 readcount int not null,
 date date not null,
 num int AUTO_INCREMENT,
 );

 */
public class BoardBean {

	private String id;
	private String subject;
	private String content;
	private int readcount;
	private int num;
	private Date date;
	private String check; // false -> 0, true = 1
	
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

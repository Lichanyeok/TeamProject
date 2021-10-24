package vo;

import java.sql.Date;
/*
 * 외래키 or DEFAULT '관리자' / 구분번호 / 내용 / 시간 
 create table CustomerComment(
 name varchar(20) not null unique,
 subject varchar(50) not null,
 content varchar(400) not null,
 readcount int not null,
 date date not null,
 num int not null primary key
 );
 * 
 */
public class BoardBean {

	private String name;
	private String subject;
	private String content;
	private int readcount;
	private int num;
	private Date date;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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

	
	
}

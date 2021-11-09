package vo;

import java.sql.Date;

public class ReplyComment
{
	/*
	 create table replycomment(
	 idx int,
	 id varchar(20),
	 content varchar(500),
	 date date
	 );
	 */
	private int idx;
	private String id;
	private String content;
	private Date date;
	
	
	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}
	
	public Date getDate()
	{
		return date;
	}
	public void setDate(Date date)
	{
		this.date = date;
	}
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	
}

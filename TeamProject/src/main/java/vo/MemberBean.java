package vo;

import java.sql.Date;

public class MemberBean {
	
	private int idx;
	private String name;
	private String nickName;
	private int age;
	private String id;
	private String pass;
	private String email;
	private String mobile;
	private String address;
	private String addressDetail;
	private String gender;
	private int grade;
	private Date date;
	public MemberBean() {};
	public MemberBean(String name, String nickName, int age, String id, String pass, String email,
			String mobile, String address, String addressDetail,String gender) {
		super();

		this.name = name;
		this.nickName = nickName;
		this.age = age;
		this.id = id;
		this.pass = pass;
		this.email = email;
		this.mobile = mobile;
		this.address = address;
		this.addressDetail = addressDetail;
		this.gender = gender;
		this.grade = grade;
		this.date = date;
	}
	
	
	@Override
	public String toString() {
		return "MemberBean [idx=" + idx + ", name=" + name + ", nickName=" + nickName + ", age=" + age + ", id=" + id
				+ ", pass=" + pass + ", email=" + email + ", mobile=" + mobile + ", address=" + address
				+ ", addressDetail=" + addressDetail + ", gender=" + gender + ", grade=" + grade + ", date=" + date
				+ "]";
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
}

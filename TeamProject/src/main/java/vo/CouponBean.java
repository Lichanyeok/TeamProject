package vo;

import java.util.Date;

public class CouponBean {
	private String coupon_name;
	private String coupon_value;
	private int coupon_price;
	private String coupon_code;
	private String user_id;
	private Date made_date;
	public CouponBean() {};
	
	
	public CouponBean(String coupon_name, String coupon_value, int coupon_price, String coupon_code, String user_id) {
		super();
		this.coupon_name = coupon_name;
		this.coupon_value = coupon_value;
		this.coupon_price = coupon_price;
		this.coupon_code = coupon_code;
		this.user_id = user_id;
	}
	
	public Date getMade_date() {
		return made_date;
	}


	public void setMade_date(Date made_date) {
		this.made_date = made_date;
	}


	public String getCoupon_name() {
		return coupon_name;
	}
	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}
	public String getCoupon_value() {
		return coupon_value;
	}
	public void setCoupon_value(String coupon_value) {
		this.coupon_value = coupon_value;
	}
	public int getCoupon_price() {
		return coupon_price;
	}
	public void setCoupon_price(int coupon_price) {
		this.coupon_price = coupon_price;
	}
	public String getCoupon_code() {
		return coupon_code;
	}
	public void setCoupon_code(String coupon_code) {
		this.coupon_code = coupon_code;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	
}

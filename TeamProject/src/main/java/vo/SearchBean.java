package vo;

import java.sql.Date;

public class SearchBean {
	private String id;
	private String business_lisence;
	private String road_address;
	private String jibun_address;
	private String category;
	private String place_name;
	private float star_score;
	private String tell_number;
	private String logo_img;
	private String ori_logo_img;
	private Date date;
	private int recommend;
	public SearchBean() {};
	public SearchBean(String road_address, String jibun_address, String place_name, String tell_number) {
		super();
		this.road_address = road_address;
		this.jibun_address = jibun_address;
		this.place_name = place_name;
		this.tell_number = tell_number;
	}
	@Override
	public String toString() {
		return "SearchBean [id=" + id + ", business_lisence=" + business_lisence + ", road_address=" + road_address
				+ ", jibun_address=" + jibun_address + ", category=" + category + ", place_name=" + place_name
				+ ", star_score=" + star_score + ", tell_number=" + tell_number + ", logo_img=" + logo_img
				+ ", ori_logo_img=" + ori_logo_img + ", date=" + date + ", recommend=" + recommend + "]";
	}	
	
	public String getOri_logo_img() {
		return ori_logo_img;
	}
	public void setOri_logo_img(String ori_logo_img) {
		this.ori_logo_img = ori_logo_img;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBusiness_lisence() {
		return business_lisence;
	}
	public void setBusiness_lisence(String business_lisence) {
		this.business_lisence = business_lisence;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public String getLogo_img() {
		return logo_img;
	}
	public void setLogo_img(String logo_img) {
		this.logo_img = logo_img;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getRoad_address() {
		return road_address;
	}
	public void setRoad_address(String road_address) {
		this.road_address = road_address;
	}
	public String getJibun_address() {
		return jibun_address;
	}
	public void setJibun_address(String jibun_address) {
		this.jibun_address = jibun_address;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public float getStar_score() {
		return star_score;
	}
	public void setStar_score(float star_score) {
		this.star_score = star_score;
	}
	public String getTell_number() {
		return tell_number;
	}
	public void setTell_number(String tell_number) {
		this.tell_number = tell_number;
	}	
	
}

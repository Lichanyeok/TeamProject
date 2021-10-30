package vo;

import java.sql.Date;

public class ReviewBean {

//CREATE TABLE review (
//	rev_num INT AUTO_INCREMENT PRIMARY KEY,// 예약번호 (PK)
//	ran_num VARCHAR(36) UNIQUE NOT NULL, // 예약 번호 + 아이디값 (예약번호 15자리, 아이디 20자리, 특수문자'_' 1자리)
//	rev_store VARCHAR(20), // 매장 이름
//	rev_name VARCHAR(20), // 리뷰 작성자 이름 or 닉네임
//	rev_score FLOAT, // 별점 or 평점
//	rev_content VARCHAR(500), // 리뷰 내용
//	rev_pic VARCHAR(250), // 사진 명
//	rev_pic_origin VARCHAR(250), // 원본 사진 명
//	rev_menu VARCHAR(30), // 주문한 메뉴 (주문내역 테이블에서 가져와서 저장)
//	rev_date DATE,// 리뷰 작성일
//	rev_like INT // 좋아요 갯수 저장
//);

int rev_num;
String ran_num;
String rev_store;
String rev_name;
float rev_score;
String rev_content;
String rev_pic;
String rev_pic_origin;
String rev_menu;
Date rev_date;
int rev_like;
String prev_pic;
String prev_pic_origin;
int listCount; // 리뷰 개수 저장
float totalScore; // 리뷰 평점 저장

public int getRev_num() {
	return rev_num;
}
public void setRev_num(int rev_num) {
	this.rev_num = rev_num;
}
public String getRan_num() {
	return ran_num;
}
public void setRan_num(String ran_num) {
	this.ran_num = ran_num;
}
public String getRev_store() {
	return rev_store;
}
public void setRev_store(String rev_store) {
	this.rev_store = rev_store;
}
public String getRev_name() {
	return rev_name;
}
public void setRev_name(String rev_name) {
	this.rev_name = rev_name;
}
public float getRev_score() {
	return rev_score;
}
public void setRev_score(float rev_score) {
	this.rev_score = rev_score;
}
public String getRev_content() {
	return rev_content;
}
public void setRev_content(String rev_content) {
	this.rev_content = rev_content;
}
public String getRev_pic() {
	return rev_pic;
}
public void setRev_pic(String rev_pic) {
	this.rev_pic = rev_pic;
}
public String getRev_pic_origin() {
	return rev_pic_origin;
}
public void setRev_pic_origin(String rev_pic_origin) {
	this.rev_pic_origin = rev_pic_origin;
}
public String getRev_menu() {
	return rev_menu;
}
public void setRev_menu(String rev_menu) {
	this.rev_menu = rev_menu;
}
public Date getRev_date() {
	return rev_date;
}
public void setRev_date(Date rev_date) {
	this.rev_date = rev_date;
}
public int getRev_like() {
	return rev_like;
}
public void setRev_like(int rev_like) {
	this.rev_like = rev_like;
}
public String getPrev_pic() {
	return prev_pic;
}
public void setPrev_pic(String prev_pic) {
	this.prev_pic = prev_pic;
}
public String getPrev_pic_origin() {
	return prev_pic_origin;
}
public void setPrev_pic_origin(String prev_pic_origin) {
	this.prev_pic_origin = prev_pic_origin;
}
public int getListCount() {
	return listCount;
}
public void setListCount(int listCount) {
	this.listCount = listCount;
}
public float getTotalScore() {
	return totalScore;
}
public void setTotalScore(float totalScore) {
	this.totalScore = totalScore;
}
	
}

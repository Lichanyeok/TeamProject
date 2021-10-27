package vo;

import java.util.Date;

public class ReserveBean {
	private String storeName;
	private String loadAddress;
	private String address;
	private String storeNumber;
	private String id;
	private String reserve_date;
	private String reserve_time;
	private int people;
	private String customerNeeds;
	private int payment_price;
	private int setA;
	private int setB;
	private String total_order_menu;
	private String ran_num;
	private int reserve_type;
	private int check_review;

	

	@Override
	public String toString() {
		return "ReserveBean [storeName=" + storeName + ", loadAddress=" + loadAddress + ", address=" + address
				+ ", storeNumber=" + storeNumber + ", id=" + id + ", reserve_date=" + reserve_date + ", reserve_time="
				+ reserve_time + ", people=" + people + ", customerNeeds=" + customerNeeds + ", payment_price="
				+ payment_price + ", setA=" + setA + ", setB=" + setB + ", total_order_menu=" + total_order_menu + "]";
	}

	public ReserveBean() {};
	
	public ReserveBean(String storeName, String loadAddress, String address, String storeNumber, String reserve_date,
			String reserve_time, int people, String customerNeeds, String total_order_menu,
			String ran_num) {
		super();
		this.storeName = storeName;
		this.loadAddress = loadAddress;
		this.address = address;
		this.storeNumber = storeNumber;
		this.reserve_date = reserve_date;
		this.reserve_time = reserve_time;
		this.people = people;
		this.customerNeeds = customerNeeds;
		this.total_order_menu = total_order_menu;
		this.ran_num = ran_num;
	}

	public ReserveBean(String storeName, String loadAddress, String address, String storeNumber, String id,String reserve_date, String reserve_time,
			int people, String customerNeeds, int setA, int setB, String total_order_menu) {
		super();
		this.id = id;
		this.storeName = storeName;
		this.loadAddress = loadAddress;
		this.address = address;
		this.storeNumber = storeNumber;
		this.reserve_date = reserve_date;
		this.reserve_time = reserve_time;
		this.people = people;
		this.customerNeeds = customerNeeds;	
		this.setA = setA;
		this.setB = setB;
		this.total_order_menu = total_order_menu;
	}
	
	public ReserveBean(String storeName, String loadAddress, String address, String storeNumber, String id,String reserve_date, String reserve_time,
			int people, String customerNeeds, String total_order_menu, int payment_price) {
		super();
		this.id = id;
		this.storeName = storeName;
		this.loadAddress = loadAddress;
		this.address = address;
		this.storeNumber = storeNumber;
		this.reserve_date = reserve_date;
		this.reserve_time = reserve_time;
		this.people = people;
		this.customerNeeds = customerNeeds;
		this.payment_price = payment_price;
		this.total_order_menu = total_order_menu;
	}
	
	public int getCheck_review() {
		return check_review;
	}

	public void setCheck_review(int check_review) {
		this.check_review = check_review;
	}

	public int getReserve_type() {
		return reserve_type;
	}

	public void setReserve_type(int reserve_type) {
		this.reserve_type = reserve_type;
	}

	public String getRan_num() {
		return ran_num;
	}

	public void setRan_num(String ran_num) {
		this.ran_num = ran_num;
	}

	public String getTotal_order_menu() {
		return total_order_menu;
	}

	public void setTotal_order_menu(String total_order_menu) {
		this.total_order_menu = total_order_menu;
	}

	public int getPayment_price() {
		return payment_price;
	}

	public void setPayment_price(int payment_price) {
		this.payment_price = payment_price;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getLoadAddress() {
		return loadAddress;
	}
	public void setLoadAddress(String loadAddress) {
		this.loadAddress = loadAddress;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getStoreNumber() {
		return storeNumber;
	}
	public void setStoreNumber(String storeNumber) {
		this.storeNumber = storeNumber;
	}
	
	public String getReserve_date() {
		return reserve_date;
	}

	public void setReserve_date(String reserve_date) {
		this.reserve_date = reserve_date;
	}

	public String getReserve_time() {
		return reserve_time;
	}

	public void setReserve_time(String reserve_time) {
		this.reserve_time = reserve_time;
	}

	public int getPeople() {
		return people;
	}
	public void setPeople(int people) {
		this.people = people;
	}
	public String getCustomerNeeds() {
		return customerNeeds;
	}
	public void setCustomerNeeds(String customerNeeds) {
		this.customerNeeds = customerNeeds;
	}
	public int getSetA() {
		return setA;
	}
	public void setSetA(int setA) {
		this.setA = setA;
	}
	public int getSetB() {
		return setB;
	}
	public void setSetB(int setB) {
		this.setB = setB;
	}
	
	
	
}

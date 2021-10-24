package vo;

import java.util.Date;

public class ReserveBean {
	private String storeName;
	private String loadAddress;
	private String address;
	private String storeNumber;
	private String id;
	private Date date;
	private String time;
	private int people;
	private String customerNeeds;
	private int setA;
	private int setB;
	
	
	
	@Override
	public String toString() {
		return "ReserveBean [storeName=" + storeName + ", loadAddress=" + loadAddress + ", address=" + address
				+ ", storeNumber=" + storeNumber + ", id="+ id + ", date=" + date + ", time=" + time + ", people=" + people
				+ ", customerNeeds=" + customerNeeds + ", setA=" + setA + ", setB=" + setB + "]";
	}

	public ReserveBean() {};
	
	public ReserveBean(String storeName, String loadAddress, String address, String storeNumber, String id,Date date, String time,
			int people, String customerNeeds, int setA, int setB) {
		super();
		this.id = id;
		this.storeName = storeName;
		this.loadAddress = loadAddress;
		this.address = address;
		this.storeNumber = storeNumber;
		this.date = date;
		this.time = time;
		this.people = people;
		this.customerNeeds = customerNeeds;
		this.setA = setA;
		this.setB = setB;
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
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
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

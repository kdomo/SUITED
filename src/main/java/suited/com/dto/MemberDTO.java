package suited.com.dto;


import java.text.SimpleDateFormat;

public class MemberDTO {

	private String id;
	private String password;
	private String nickname;
	private String name;
	private String gender;
	private int age;
	private String address;
	private String phone;
	private String kakao_login;
	private String signup_date;
	private String withdrawal_yn;
	private String admin_yn;
	
	public MemberDTO() {}
	
	public MemberDTO(String id, String password, String nickname, String name, String gender, int age, String address,
			String phone, String kakao_login, long signup_date, String withdrawal_yn, String admin_yn) {
		super();
		this.id = id;
		this.password = password;
		this.nickname = nickname;
		this.name = name;
		this.gender = gender;
		this.age = age;
		this.address = address;
		this.phone = phone;
		this.kakao_login = kakao_login;
		this.signup_date = toStringDate(signup_date);
		this.withdrawal_yn = withdrawal_yn;
		this.admin_yn = admin_yn;
	}
	
	public String toStringDate(long date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(date);
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getKakao_login() {
		return kakao_login;
	}
	public void setKakao_login(String kakao_login) {
		this.kakao_login = kakao_login;
	}
	public String getSignup_date() {
		return signup_date;
	}
	public void setSignup_date(String signup_date) {
		this.signup_date = signup_date;
	}
	public String getWithdrawal_yn() {
		return withdrawal_yn;
	}
	public void setWithdrawal_yn(String withdrawal_yn) {
		this.withdrawal_yn = withdrawal_yn;
	}
	public String getAdmin_yn() {
		return admin_yn;
	}
	public void setAdmin_yn(String admin_yn) {
		this.admin_yn = admin_yn;
	}
	
	
	
}

package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import suited.com.dto.MemberDTO;


public class MemberDAO {
	private BasicDataSource bds;

	public MemberDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context) iCtx.lookup("java:comp/env");
			bds = (BasicDataSource) envCtx.lookup("jdbc/bds");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws Exception {
		return bds.getConnection();
	}

	public int insert(MemberDTO dto) throws Exception {
		String sql = "insert into tbl_member values(?,?,?,?,?,?,?,?,?,?,?,?)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getNickname());
			pstmt.setString(4, dto.getName());
			pstmt.setString(5, dto.getGender());
			pstmt.setInt(6, dto.getAge());
			pstmt.setString(7, dto.getAddress());
			pstmt.setString(8, dto.getPhone());
			pstmt.setString(9, dto.getKakao_login());
			pstmt.setString(10, dto.getSignup_date());
			pstmt.setString(11, dto.getWithdrawal_yn());
			pstmt.setString(12, dto.getAdmin_yn());

			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} 
		return -1;
	}
	
	public boolean login(String id, String password) throws Exception {
		String sql = "select * from tbl_member where id=? AND password=?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, id);
			pstmt.setString(2, password);

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} 
		return false;
	}
	
	public MemberDTO selectById(String id) throws Exception {
		String sql = "select * from tbl_member where id=?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, id);

			ResultSet rs = pstmt.executeQuery();
			MemberDTO dto = new MemberDTO();
			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPassword(rs.getString("password"));
				dto.setNickname(rs.getString("nickname"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setAge(rs.getInt("age"));
				dto.setAddress(rs.getString("address"));
				dto.setPhone(rs.getString("phone"));
				dto.setKakao_login(rs.getString("kakao_login"));
				dto.setWithdrawal_yn(rs.getString("withdrawal_yn"));
				dto.setAdmin_yn(rs.getString("admin_yn"));
			}
			return dto;
		}
	}
	
	public boolean idCheck(String id) throws Exception {
		String sql = "select * from tbl_member where id=?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, id);

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			} else {
				return false;
			}
		}
	}
	public boolean nicknameCheck(String nickname) throws Exception {
		String sql = "select * from tbl_member where nickname=?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, nickname);

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			} else {
				return false;
			}
		}
	}
	public String getKakaoMember(String kakao_value) throws Exception {
		String sql = "select id from tbl_member where kakao_login = ? and not kakao_login = 0";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, kakao_value);

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString("id");
			}
			return null;
		}
	}
	public boolean kakaoLogin(String kakao_value) throws Exception {
		String sql = "select * from tbl_member where kakao_login = ?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, kakao_value);

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} 
		return false;
	}
	public MemberDTO selectByKakaoValue(String kakao_value) throws Exception {
		String sql = "select * from tbl_member where kakao_login = ?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, kakao_value);

			ResultSet rs = pstmt.executeQuery();
			MemberDTO dto = new MemberDTO();
			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPassword(rs.getString("password"));
				dto.setNickname(rs.getString("nickname"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setAge(rs.getInt("age"));
				dto.setAddress(rs.getString("address"));
				dto.setPhone(rs.getString("phone"));
				dto.setKakao_login(rs.getString("kakao_login"));
				dto.setWithdrawal_yn(rs.getString("withdrawal_yn"));
				dto.setAdmin_yn(rs.getString("admin_yn"));
			}
			return dto;
		}
	}
	
	
	public boolean adminConfirm(String id) throws Exception {
		String sql = "select * from tbl_member where id = ? AND admin_yn = ?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, id);
			pstmt.setString(2, "1");

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}else {
				return false;
			}
		}
	}
	
	public int updateById(String id,String password,String nickname,String address,String phone) throws Exception {
		String sql = "update tbl_member set password=?,nickname=?,address=?,phone=? where id=?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, password);
			pstmt.setString(2, nickname);
			pstmt.setString(3, address);
			pstmt.setString(4, phone);
			pstmt.setString(5, id);

			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} 
		return -1;
	}
}

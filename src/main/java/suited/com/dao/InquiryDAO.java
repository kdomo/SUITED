package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import suited.com.dto.InquiryDTO;
import suited.com.dto.ProductDTO;

public class InquiryDAO {
	private BasicDataSource bds;
	
	public InquiryDAO() {
		try{
			Context iCtx = new InitialContext(); // 불러오는 메서드를 사용하기 위해서 만들어주는 객체
			Context envCtx = (Context)iCtx.lookup("java:comp/env"); // 설정해준 리소스가 있는 경로까지 찾아가는 작업
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws Exception{
		return bds.getConnection();
	}
	
	public ArrayList<ProductDTO> getProductCode() throws Exception{
		String sql = "select * from tbl_product";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ProductDTO> list = new ArrayList<>();
			ProductDTO Pdto = new ProductDTO();
			while (rs.next()) {
				String product_code = rs.getString("product_code");
				String product_name = rs.getString("product_name");
				list.add(new ProductDTO(product_code, product_name));
			}return list;
		}
	}
	
	public int sendAnswer(int seq_inquiry, String answer) throws Exception{
		String sql = "update tbl_inquiry set answer_yn = '1', answer = ? where seq_inquiry = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, answer);
			pstmt.setInt(2, seq_inquiry);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
	
	
	public InquiryDTO selectBySeq(int sEq_inquiry) throws Exception{
		String sql = "select * from tbl_inquiry where seq_inquiry = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, sEq_inquiry);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int seq_inquiry = rs.getInt("seq_inquiry");
				String title = rs.getString("title");
				String product_code = rs.getString("product_code");
				String id = rs.getString("id");
				String content = rs.getString("content");
				String inquiry_date = rs.getString("inquiry_date");
				String answer_yn = rs.getString("answer_yn");
				String answer = rs.getString("answer");
				InquiryDTO dto = new InquiryDTO(seq_inquiry, id, product_code, title, content, inquiry_date, answer_yn, answer);
				return dto;
			}
			return null;
		}
	}
	
	// startRange와 endRange를 받아준다. 리스트에 값을 체워준다.
	public ArrayList<InquiryDTO> getInquiryList(HashMap<String, Integer> ranges) throws Exception{
		// 서브쿼리를 사용한다.
		String sql = "select * from"
				+ "(select row_number() over(order by seq_inquiry desc) 순위,"
				+ "a.* from tbl_inquiry a)"
				+ "where 순위 between ? and ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, ranges.get("startRange"));
			pstmt.setInt(2, ranges.get("endRange"));
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<InquiryDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_inquiry = rs.getInt("seq_inquiry");
				String title = rs.getString("title");
				String id = rs.getString("id");
				String inquiry_date = rs.getString("inquiry_date");
				String answer_yn = rs.getString("answer_yn");
				list.add(new InquiryDTO(seq_inquiry, id, null, title, null, inquiry_date, answer_yn, null));
			}
			return list;
		}
	}
	
	public ArrayList<InquiryDTO> selectListById(HashMap<String, Integer> ranges, String loginId) throws Exception{
		// 서브쿼리를 사용한다.
		String sql = "select * from"
				+ "(select row_number() over(order by seq_inquiry desc) 순위,"
				+ "a.* from tbl_inquiry a where id = ?)"
				+ "where 순위 between ? and ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, loginId);
			pstmt.setInt(2, ranges.get("startRange"));
			pstmt.setInt(3, ranges.get("endRange"));
			
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<InquiryDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_inquiry = rs.getInt("seq_inquiry");
				String title = rs.getString("title");
				String id = rs.getString("id");
				String inquiry_date = rs.getString("inquiry_date");
				String answer_yn = rs.getString("answer_yn");
				list.add(new InquiryDTO(seq_inquiry, id, null, title, null, inquiry_date, answer_yn, null));
			}
			return list;
		}
	}
	
	// 1. 전체 데이터가 몇개인지 뽑아내는 작업
	public int countAll() throws Exception{
		String sql = "select count(*) from tbl_inquiry";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) return rs.getInt(1);
		}return -1;
	}
	
	public int countById(String id) throws Exception{
		String sql = "select count(*) from tbl_inquiry where id = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) return rs.getInt(1);
		}return -1;
	}
	
	
	// 문의 작성한 내용을 DB에 추가해주는 메서드
	public int insert(InquiryDTO dto) throws Exception{
		String sql = "insert into tbl_inquiry values(seq_inquiry.nextval, ?, ?, ?, ?, ?, ?, null)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getProduct_code());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getInquiry_date());
			pstmt.setString(6, dto.getAnswer_yn());
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}
		return -1;
	}
}

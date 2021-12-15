package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import suited.com.dto.BlacklistDTO;

public class BlacklistDAO {
	private BasicDataSource bds;
	
	public BlacklistDAO(){
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
	
	public int deleteById(String checklist) throws Exception{
		String sql = "delete from tbl_blacklist where id = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, checklist);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) {
				return rs;
			}
		}return -1;
	}
	
	public int insert(BlacklistDTO dto) throws Exception{
		String sql = "insert into tbl_blacklist values(?, ?, ?, ?)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getBlack_update());
			pstmt.setString(4, dto.getReason());
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		}return -1;
	}
	
	public ArrayList<BlacklistDTO> getByIdList(String id1) throws Exception{
		String sql = "select * from tbl_blacklist where id = ?";
		
		try (Connection con = this.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				
				pstmt.setString(1, id1);
				
				ResultSet rs = pstmt.executeQuery();
				ArrayList<BlacklistDTO> list = new ArrayList<>();
				while(rs.next()) {
					String id = rs.getString("id");
					String name = rs.getString("name");
					String black_update = rs.getString("black_update");
					String reason = rs.getString("reason");
					list.add(new BlacklistDTO(id, name, black_update, reason));
					
				}return list;
			}
	}
	
	public String getNameSelectById(String id) throws Exception{
		String sql = "select * from tbl_member where id = ?";
		
		try (Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			String name = "";
			if(rs.next()) {
				name = rs.getString("name");
				
			}return name;
		}
	}
	
	public int countAll() {
		String sql = "select count(*) from tbl_blacklist";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) return rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<BlacklistDTO> getBlackList(HashMap<String, Integer> ranges){
		String sql = "select * from"
				+ "(select row_number() over(order by black_update desc) 순위,"
				+ "a.* from tbl_blacklist a)"
				+ "where 순위 between ? and ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, ranges.get("startRange"));
			pstmt.setInt(2, ranges.get("endRange"));
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BlacklistDTO> list = new ArrayList<>();
			while(rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				String black_update = rs.getString("black_update");
				String reason = rs.getString("reason");
				list.add(new BlacklistDTO(id, name, black_update, reason));
			}
			return list;			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}

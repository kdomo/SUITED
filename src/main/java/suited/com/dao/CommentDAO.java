package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import suited.com.dto.CommentDTO;

public class CommentDAO {
	private BasicDataSource bds;
	
	public CommentDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws Exception{
		return bds.getConnection();
	}
	
	public int countAll() {
		String sql = "select count(*) from tbl_comment";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) return rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int countByCode(String product_code) {
		String sql = "select count(*) from tbl_comment where product_code = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, product_code);
			ResultSet rs = pstmt.executeQuery();
            
			if(rs.next()) return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 제품 상세 페이지 내의 리뷰에서 사용되는 getCommentList
	public ArrayList<CommentDTO> getCommentList(int startRange, int endRange, String product_code){
		String sql = "select * from "
				+ "(select row_number() over(order by seq_review desc) 순위,"
				+ "a.* from tbl_comment a where product_code = ?) "
				+ "where 순위 between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, product_code);
			pstmt.setInt(2, startRange);
			pstmt.setInt(3, endRange);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<CommentDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_review = rs.getInt("seq_review");
				String nickname = rs.getString("nickname");
				String content = rs.getString("content");
				String written_comment_date = rs.getString("written_comment_date");
				String id = rs.getString("id");
				
				list.add(new CommentDTO(seq_review, nickname, content, written_comment_date, product_code, id));
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 리뷰 모아보기에서 사용되는 getCommentList
	public ArrayList<CommentDTO> getCommentList2(int startRange, int endRange){
		String sql = "select * from "
				+ "(select row_number() over(order by seq_review desc) 순위,"
				+ "a.* from tbl_comment a)"
				+ "where 순위 between ? and ?";
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, startRange);
			pstmt.setInt(2, endRange);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<CommentDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq_review = rs.getInt("seq_review");
				String nickname = rs.getString("nickname");
				String content = rs.getString("content");
				String written_comment_date = rs.getString("written_comment_date");
				String product_code = rs.getString("product_code");
				String id = rs.getString("id");
				
				list.add(new CommentDTO(seq_review, nickname, content, written_comment_date, product_code, id));
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<CommentDTO> selectAll(String product_code){
		String sql = "select * from tbl_comment where product_code=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, product_code);
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<CommentDTO> list = new ArrayList<>();
			while(rs.next()){
				int seq_review = rs.getInt("seq_review");
				String nickname = rs.getString("nickname");
				String content = rs.getString("content");
				String written_comment_date = rs.getString("written_comment_date");
				String id = rs.getString("id");
				list.add(new CommentDTO(seq_review, nickname, content, written_comment_date, product_code, id));
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int insert(CommentDTO dto) {
		String sql = "insert into tbl_comment values(seq_review.nextval, ?, ?, ?, ?, ?)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setString(1, dto.getNickname());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWritten_comment_date());
			pstmt.setString(4, dto.getProduct_code());
			pstmt.setString(5, dto.getId());
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int deleteBySeq(int seq_review) {
		String sql = "delete from tbl_comment where seq_review = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, seq_review);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int deleteByCode(String product_code) {
		String sql = "delete from tbl_comment where product_code = ?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, product_code);
			
			int rs = pstmt.executeUpdate();
			if(rs != -1) return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}

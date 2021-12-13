package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.sun.net.httpserver.Authenticator.Result;

import suited.com.dto.BasketDTO;

public class BasketDAO {
	private BasicDataSource bds;

	public BasketDAO() {
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

	public int insert(BasketDTO dto) throws Exception {
		String sql = "insert into tbl_basket values(?,?,?)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getProduct_code());
			pstmt.setInt(3, dto.getQuantity());
			
			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} 
		return -1;
	}
	
//	public ArrayList<CommentDTO> getCommentList(int startRange, int endRange, String product_code){
//		String sql = "";
//		try(Connection con = this.getConnection();
//			PreparedStatement pstmt = con.prepareStatement(sql);) {
//			pstmt.setString(1, product_code);
//			pstmt.setInt(2, startRange);
//			pstmt.setInt(3, endRange);
//			
//			ResultSet rs = pstmt.executeQuery();
//			ArrayList<CommentDTO> list = new ArrayList<>();
//			while(rs.next()) {
//				int seq_review = rs.getInt("seq_review");
//				String nickname = rs.getString("nickname");
//				String content = rs.getString("content");
//				String written_comment_date = rs.getString("written_comment_date");
//				String id = rs.getString("id");
//				
//				list.add(new CommentDTO(seq_review, nickname, content, written_comment_date, product_code, id));
//			}
//			return list;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return null;
//}
}

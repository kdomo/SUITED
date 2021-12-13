package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.sun.net.httpserver.Authenticator.Result;

import suited.com.dto.CertifiedDTO;



public class CertifiedDAO {
	private BasicDataSource bds;

	public CertifiedDAO() {
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

	public int insert(CertifiedDTO dto) throws Exception {
		String sql = "insert into tbl_certified values(?,?,?)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getIdHash());
			pstmt.setString(3, dto.getIdHashChecked());
			
			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} 
		return -1;
	}
	public String getIdHashById(String id) throws Exception {
		String sql = "select idHash from tbl_certified where id = ?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, id);
			
			ResultSet rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getString("idHash");
		} 
		return null;
	}
	public int setChecked(String id) throws Exception {
		String sql = "update tbl_certified set idHashChecked = 1 where id = ?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, id);
			
			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} 
		return -1;
	}
	public String getChecked(String id) throws Exception {
		String sql = "select idHashChecked from tbl_certified where id = ?";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, id);
			
			ResultSet rs  = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString("idHashChecked");
			}
		} 
		return null;
	}
}

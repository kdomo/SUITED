package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;


public class Order_productDAO {
	private BasicDataSource bds;
	
	public Order_productDAO() {
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
	
	public int insert(String product_code,int order_quantity) throws Exception {
		String sql = "insert into tbl_order_product values(concat(to_char(sysdate,'YYYYMMDD'),ltrim(to_char((seq_order.currval),'000000'))),?,?)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, product_code);
			pstmt.setInt(2, order_quantity);
			

			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} 
		return -1;
	}
	
	public String getseq() throws Exception {
		String sql = "select concat(to_char(sysdate,'YYYYMMDD'),ltrim(to_char((seq_order.currval),'000000'))) from dual";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			ResultSet rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getString(1);
		} 
		return null;
	}
}

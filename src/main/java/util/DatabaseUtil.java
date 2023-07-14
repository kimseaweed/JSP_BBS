package util;

import java.sql.*;

public class DatabaseUtil  {
	public static Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","C##dbexam","m1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
public static void close(Connection conn,PreparedStatement pstmt,ResultSet rs) {
	try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
	try {if(pstmt != null) {pstmt.close();}} catch(Exception e) {e.printStackTrace();}
	try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
}
	
}

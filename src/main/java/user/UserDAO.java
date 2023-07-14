package user;

import java.sql.*;

import util.DatabaseUtil;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
	}
	
	public int login(String userID,String userPassword) {
		String query="SELECT userPassword FROM usert WHERE userID = ?";
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공 (아이디와 일치하는 레코드가 있고, 해당 비번과 입력값이 같음)
				}else {
					return 0; //비밀번호 일치하지 않음 (아이디와 일치하는 레코드 있으나 비번이 일치하지 않음)
				}
			}
			return -1; //아이디 없음 (아이디 일치하는 레코드가 없음)
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DatabaseUtil.close(conn, pstmt, rs);
		}
		return -2; //데이터베이스 오류
	}
	
	public int join(User user) {
		String query="INSERT INTO usert VALUES(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DatabaseUtil.close(conn, pstmt, rs);
		}
		return -1; //데이터베이스 오류
	}
	
}

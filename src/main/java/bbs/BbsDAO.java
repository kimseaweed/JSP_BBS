package bbs;

import java.sql.*;
import java.util.ArrayList;

import util.DatabaseUtil;

public class BbsDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	public BbsDAO() {
	}
	
	
	public int getNext() {
		String sql = "SELECT bbsID FROM bbs ORDER BY bbsID desc"; //bbs 아이디를 내림차순으로 정렬한다
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; //첫 행에 1을 더한다 (내림차순으로 조회했으니 첫행은 가장 최근 게시물의 번호)
 			}
			return 1; //검색결과가 없으면 1을 리턴한다.
		} catch (SQLException e) {
			System.err.println("getnext 오류");
			e.printStackTrace();
		}finally {
			DatabaseUtil.close(conn, pstmt, rs);
		}
		return -1; //데이터베이스 오류
	}
	public int write(String bbsTitle,String userID,String bbsContent) {
		String sql = "INSERT INTO BBS VALUES(?,?,?,sysdate,?,1)";
		int next = getNext();
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,next);
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3,userID);
			pstmt.setString(4,bbsContent);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("write오류");
			e.printStackTrace();
		}finally {
			DatabaseUtil.close(conn, pstmt, rs);
		}
		return -1; //데이터베이스 오류
	}
	public ArrayList<Bbs> getList(int pageNumber){
		int next = getNext();
		String sql = "SELECT bbsid, bbstitle, userID,bbsdate,bbscontent,bbsAvailable "
				+ "FROM bbs WHERE bbsID <? AND bbsAvailable = 1 AND ROWNUM <= 10 ORDER BY bbsID DESC"; //bbs 아이디를 내림차순으로 정렬한다
		ArrayList<Bbs> list=new ArrayList<Bbs>();
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, next-(pageNumber-1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString("bbsTitle"));
				bbs.setUserID(rs.getString("userID"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setBbsContent(rs.getString("bbsContent"));
				bbs.setBbsAvailable(rs.getInt("bbsAvailable"));
				list.add(bbs);
 			}
		} catch (SQLException e) {
			System.err.println("getlist오류");
			e.printStackTrace();
		}finally {
			DatabaseUtil.close(conn, pstmt, rs);
		}
		return list; 
	}
	public boolean nextPage(int pageNumber) {
		int next = getNext();
		String sql = "SELECT * FROM bbs WHERE bbsAvailable = 1 AND bbsID <? AND ROWNUM <= 10 ORDER BY bbsID DESC"; //bbs 아이디를 내림차순으로 정렬한다
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, next-(pageNumber-1)*10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
 			}
		} catch (SQLException e) {
			System.err.println("nextpage오류");
			e.printStackTrace();
		}finally {
			DatabaseUtil.close(conn, pstmt, rs);
		}
		return false; 
	}
	public Bbs getBbs(int bbsID) {
		String sql = "SELECT * FROM bbs where bbsID = ?"; //bbs 아이디를 내림차순으로 정렬한다
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString("bbsTitle"));
				bbs.setUserID(rs.getString("userID"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setBbsContent(rs.getString("bbsContent"));
				bbs.setBbsAvailable(rs.getInt("bbsAvailable"));
				return bbs;
 			}
			
		} catch (SQLException e) {
			System.out.println("getBbs 오류");
			e.printStackTrace();
		}finally {
			DatabaseUtil.close(conn, pstmt, rs);
		}
		return null; //데이터베이스 오류
	}
	public int getUpdate(int bbsID, String bbsTitle,String bbsContent) {
		String sql = "update bbs set bbsTitle=?, bbsContent=? where bbsID=?";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,bbsTitle);
			pstmt.setString(2,bbsContent);
			pstmt.setInt(3,bbsID);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("update오류");
			e.printStackTrace();
		}finally {
			DatabaseUtil.close(conn, pstmt, rs);
		}
		return -1; //데이터베이스 오류
	}
	public int getDelete(int bbsID) {
		String sql = "update bbs set bbsavailable=2 where bbsID=?";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,bbsID);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("delete 오류");
			e.printStackTrace();
		}finally {
			DatabaseUtil.close(conn, pstmt, rs);
		}
		return -1; //데이터베이스 오류
	}
}

package dao;

import java.util.*;
import java.sql.*;
import bean.boardBean;


public class boardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	public boardDAO() {
		try {
			 Class.forName("oracle.jdbc.OracleDriver");
			 conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","1234");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int totalcount() {
		String sql = "SELECT count(*) FROM Board";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			int total = rs.getInt(1);
			return total;
		} catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	public ArrayList<boardBean> select(int tpage) {
		String sql = "select x.num, x.title, x.userid, to_char(x.BDATE,'yyyy-MM-dd') as bdate FROM(SELECT rownum as num, a.title, a.userid, a.bdate FROM(SELECT title, userid, bdate FROM board ORDER BY num) a WHERE rownum <= ?) x WHERE x.num >= ? ORDER BY x.num";
		ArrayList<boardBean> postList = new ArrayList<boardBean>();
		boardBean boardbean = null;
		try {
			pstmt = conn.prepareStatement(sql);
			
			int a = tpage * 10;
			int b = (tpage-1) * 10 + 1;
			
			pstmt.setInt(1, a);
			pstmt.setInt(2, b);
			rs = pstmt.executeQuery();
	
			while(rs.next()) {
				boardbean = new boardBean();
				boardbean.setNum(rs.getInt(1));
				boardbean.setTitle(rs.getString(2));
				boardbean.setUserid(rs.getString(3));
				boardbean.setBdate(rs.getString(4));
				postList.add(boardbean);
			}
			return postList;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public int insert(boardBean boardbean) throws SQLException {
		String sql = "INSERT INTO Board VALUES(num.nextval, ?, ?, sysdate, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardbean.getTitle());
			pstmt.setString(2, boardbean.getUserid());
			pstmt.setString(3, boardbean.getContent());
			pstmt.setString(4, boardbean.getPassword());
			pstmt.executeUpdate();
			conn.commit();
			return 1;
		} catch(Exception e) {
			conn.rollback();
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public boardBean selectDetail(int num) {
		String sql = "SELECT title, userid, TO_CHAR(bdate,'yyyy-MM-dd'), content, password FROM Board WHERE num=?";
		try {
			boardBean boardbean = new boardBean();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			rs.next();
			boardbean.setTitle(rs.getString(1));
			boardbean.setUserid(rs.getString(2));
			boardbean.setBdate(rs.getString(3));
			boardbean.setContent(rs.getString(4));
			boardbean.setPassword(rs.getString(5));
			return boardbean;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public int update(boardBean boardbean) throws SQLException {
		String sql = "UPDATE Board SET title=?, userid=?, content=? WHERE num=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardbean.getTitle());
			pstmt.setString(2, boardbean.getUserid());
			pstmt.setString(3, boardbean.getContent());
			pstmt.setInt(4, boardbean.getNum());
			pstmt.executeUpdate();
			conn.commit();
			return 1;
		} catch(Exception e) {
			conn.rollback();
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public int delete(boardBean boardbean) throws SQLException {
		String sql = "DELETE FROM Board WHERE num=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardbean.getNum());
			pstmt.executeUpdate();
			conn.commit();
			return 1;
		} catch(Exception e) {
			conn.rollback();
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}

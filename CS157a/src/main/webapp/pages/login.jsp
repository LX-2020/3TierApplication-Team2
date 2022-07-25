<%@ page import = "java.sql.*"%>
<%
String username = request.getParameter("username");
String password1 = request.getParameter("password");

try
{
    Class.forName("com.mysql.jdbc.Driver");
    String VERIFY_USERS_SQL = "SELECT * FROM users WHERE userName = ? and password = ?;";
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sjsu-bq", "root", "Timecardmnew2244");
    PreparedStatement ps = conn.prepareStatement(VERIFY_USERS_SQL);
    ps.setString(1, username);
    ps.setString(2, password1);

    System.out.println(ps);
    ResultSet rs = ps.executeQuery();
    int cnt=0;
    if (rs.next()){
        cnt = rs.getInt(1);
        response.sendRedirect("frontPage.jsp");
        System.out.println("successfully logged in! Woooop!");
    }
    if (cnt == 0){
        System.out.println("Unsuccessful login. Verify username and password.");
    }

}catch(Exception e){
    System.out.print(e);
}
%>
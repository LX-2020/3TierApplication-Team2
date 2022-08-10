<%@ page import = "java.sql.*"%>
<%
String username = request.getParameter("username");
String password1 = request.getParameter("password");

try
{
    System.out.println("Trying to login ....");
    Class.forName("com.mysql.jdbc.Driver");
    String VERIFY_USERS_SQL = "SELECT * FROM users WHERE userName = ? and password = ?;";
    System.out.println("SQL=" + VERIFY_USERS_SQL);
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sjsu-bq", "root", "nd63nt34");
    PreparedStatement ps = conn.prepareStatement(VERIFY_USERS_SQL);
    ps.setString(1, username);
    ps.setString(2, password1);
    System.out.println(ps);
    ResultSet rs = ps.executeQuery();
    int cnt=0;
    if (rs.next()){
        cnt = rs.getInt(1);
        System.out.println("successfully logged in! Woooop!");
        response.sendRedirect("homePage.jsp");
    }
    if (cnt == 0){
        System.out.println("Unsuccessful login. Verify username and password.");
        out.print("Unsuccessful login. Verify username and password.");
        response.sendRedirect("loginerror.html");
    }

}catch(Exception e){
    System.out.print(e);
}
%>
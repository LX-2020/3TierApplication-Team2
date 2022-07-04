<%@ page import = "java.sql.*"%>
<%
String email = request.getParameter("email");
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
String username = request.getParameter("username");
String password = request.getParameter("password");
String authorizationNumber = request.getParameter("authorizationNumber");

try{
    Class.forName("com.mysql.jdbc.Driver");
    java.util.Date now = new java.util.Date();
	java.sql.Date sqlDate = new java.sql.Date(now.getTime());
    String INSERT_USERS_SQL = "INSERT INTO users" + " (email, firstName, lastName, username, password, authorizationNumber, dateCreated) VALUES " + " (?, ?, ?, ?, ?, ?, ?);";
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sjsu-bq", "root", "Timecardmnew2244");
    PreparedStatement ps = conn.prepareStatement(INSERT_USERS_SQL);
    ps.setString(1,email);
    ps.setString(2,firstName);
    ps.setString(3,lastName);
    ps.setString(4,username);
    ps.setString(5,password);
    ps.setString(6,authorizationNumber);
    ps.setDate(7, sqlDate);

    System.out.println(ps);
    int x = ps.executeUpdate();
    if(x>0){
        System.out.print("Registration done successfully...");
    }else{
        System.out.print("Registration failed...");
    }
}catch(Exception e){
    System.out.print(e);
}
%>
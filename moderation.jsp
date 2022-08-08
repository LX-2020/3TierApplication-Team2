<%@ page import = "java.sql.*"%>
<%
String username = request.getParameter("username"); //username they entered
String qORa = request.getParameter("qORa"); //which button they clicked on radio button.
String password1 = request.getParameter("assetNumber"); //the ques or ans id to delete.

session.getAttribute("username");

try
{
    Class.forName("com.mysql.jdbc.Driver");
    //find auth
    String VERIFY_AUTH_SQL = "SELECT authorizationNumber FROM users WHERE userName = ?;"; //grab auth number for that username.
    //find question and delete
    String DELETE_QUES_SQL = "DELETE FROM questions WHERE question_id = ?;";
    //find answer and delete
    String DELETE_ANSW_SQL = "DELETE FROM answers WHERE answer_id = ?;";

    System.out.println("they chose: " + qORa);


    //verification
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sjsu-bq", "root", "Timecardmnew2244");
    PreparedStatement ps = conn.prepareStatement(VERIFY_AUTH_SQL);
    ps.setString(1, username);

    //question delete
    Connection conn1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/sjsu-bq", "root", "Timecardmnew2244");
    PreparedStatement ps1 = conn.prepareStatement(DELETE_QUES_SQL);
    ps1.setString(1, password1);

    //answer delete
    Connection conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/sjsu-bq", "root", "Timecardmnew2244");
    PreparedStatement ps2 = conn.prepareStatement(DELETE_ANSW_SQL);
    ps2.setString(1, password1);

    System.out.println(ps);
    ResultSet rs = ps.executeQuery();
    int cnt=0;
    if (rs.next())
    {
        cnt = rs.getInt(1);
        if (rs.getInt(1) <= 1)
        {
            System.out.println("Error. Permission Denied. Not high enough Authorization.");
        }
        else{
            System.out.println("Valid permissions! proceed to deletion decision.");
            System.out.println("they for sure chose: " + qORa);
            System.out.println(""+qORa);
            if (qORa.equals("q"))
            {
                //time to delete a question!
                System.out.println(ps1);
                int x = ps1.executeUpdate();
                System.out.println("WE SHOULD BE DELETING A QUESTION!!!");
                if(x>0)
                {
                    System.out.print("Successfully deleted question with that id!");
                }else{
                System.out.print("NO ENTRY IN DATABASE THAT MATCHES THAT QUESTION NUMBER!");
                }
            }
            else
            {
                //time to delete an answer!
                System.out.println("WE SHOULD BE DELETING A ANSWER!!");
                System.out.println(ps2);
                int y = ps2.executeUpdate();
                if(y>0)
                {
                    System.out.print("Successfully deleted an answer with that id!");
                }else{
                System.out.print("NO ENTRY IN DATABASE THAT MATCHES THAT answer NUMBER!");
                }
            }

        }
    }
    if (cnt == 0){
        System.out.println("Error. No entry in database for that username you entered.");
    }

}catch(Exception e){
    System.out.print(e);
}
%>


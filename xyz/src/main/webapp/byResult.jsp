<%@ page import="java.sql.*"%> 
<%@ page import="java.util.Date" %>
<% Class.forName("com.mysql.cj.jdbc.Driver"); %>
<!DOCTYPE html>
<html>
	<head> 
	<meta charset="UTF-8">
  	<link rel="StyleSheet" href="homePageStyle.css">
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">       
	</head>

<body> 
  	<%@ include file = "mainPage.jsp" %>
<article>
<div class="ex1"> 

	<%		
	
	 java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/sjsu-bq?autoReconnect=true&useSSL=false",user, password);
     	
    Statement stmt = con2.createStatement();
	ResultSet rs = 
    		stmt.executeQuery("SELECT  q.question_id, question_text, answer_text, a.dateUpdated " 
            		+ "FROM questions q, answers a, Category c "
            		+ "WHERE q.question_id = a.question_id "
            				+ "AND q.category_id = c.category_id "
            				+ "AND q.category_id = 1");  
   
    while (rs.next()) {
    out.println(rs.getInt(1) + ".");
    out.println(rs.getString(2) + "<br/><br/>");
    out.println(rs.getString(3) + "<br/><br/>");
    out.println(rs.getString(4) + "<br/><br/>");
    }
	
    %>
    
</div>
</article>
</body>
</html>
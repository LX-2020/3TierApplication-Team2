<%@ page import="java.sql.*"%> 
<%@ page import="java.util.Date" %>
<% Class.forName("com.mysql.cj.jdbc.Driver"); %>
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
	<% //for tomcat server
         
            java.sql.Connection con; 
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sjsu-bq?autoReconnect=true&useSSL=false",user, password);
       
            Statement stmt = con.createStatement();
            ResultSet rs = 
            		stmt.executeQuery("SELECT questions.question_id,question_text,answer_text,answers.dateUpdated, answers.user_id FROM questions,answers WHERE questions.question_id = answers.question_id ORDER BY dateUpdated DESC");
           
        
    %>
	<div class="box">
	</div>
	<div class="column">
	<% while(rs.next()) {%>
  		<div class="row">
    		<table>  		
    		
      			<tr>
        			<th><%= rs.getString("question_text")%></th>       
      			</tr>
      			<tr>
        			<td><%= rs.getString("answer_text")%></td>        
      			</tr>         
    		</table>
  		</div>
		<%} %>
  		
   		
	</div>

    
    </div>	
   	</article>
   
  
</body>
</html>
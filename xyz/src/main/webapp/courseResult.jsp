<%@ page import="java.sql.*"%> 
<%@ page import="java.util.Date" %>

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
	  	
    Statement stmt = conSC.createStatement();
	ResultSet rs = 
    		stmt.executeQuery("SELECT  q.question_id, question_text, answer_text, a.dateUpdated " 
            		+ "FROM questions q, answers a, Category c "
            		+ "WHERE q.question_id = a.question_id "
            				+ "AND q.category_id = c.category_id "
            				+ "AND q.category_id = 2");  
	
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

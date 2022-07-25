<%@ page import="java.sql.*"%> 
<%@ page import="java.util.Date" %>
<% Class.forName("com.mysql.cj.jdbc.Driver"); %>
<!DOCTYPE html>
<html>
	<head> 
	<meta charset="UTF-8">
  	<link rel="StyleSheet" href="homePageStyle.css">
  	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">       
	</head>

<body> 
  	<header>
   	<h1>SJSU Burning Questions</h1>
   	<div class="styled">
  			<button type="button" onclick="askQuestion()">Ask a question</button>
  		</div> 	
	<div class="topnav">		
		<a class="active" href="#home">Home</a>
		<a href="#category">Category</a>
		<a href="#account">Account</a> 		
  		<form action="searchResult.jsp" method="POST">
  			<input  type="text" name="searchKey"  placeholder="Search question here..">
  			<button type="submit"><i class="fa fa-search"></i></button>
  		</form> 
  					
  		
  		
   	</div>   	
   	</header>
	
 	<div class="form-popup" id="newQuestion">    
 	<form action="abc.jsp" method="POST" class="form-container">
    	
	 <%
  
    	String db = "Team2";
        String user = "root";
        String password = "620302mlx";
        
        java.sql.Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/Team2?autoReconnect=true&useSSL=false",user, password);
        
        PreparedStatement addquestion = con1.prepareStatement(
        		"INSERT INTO questions(question_text, dateCreated) "
        		+ "VALUES (?,?)" );
        
        if (request.getParameter("add")!= null) { 

        	String qtext = request.getParameter("questiontext"); 
                
        Date date = new Date();
		Timestamp timeStamp = new Timestamp(date.getTime());
		
		addquestion.setString(1, qtext);		
		addquestion.setTimestamp(2, timeStamp);
		int result = addquestion.executeUpdate();
        }
        
       	
    %> 
    
   	<h3>Please ask your question here:</h3>

    	<textarea id="questiontext" name="questiontext" >What...</textarea>

    	<button name="add" type="submit" class="btn">add</button>
    	<button type="button" class="btn cancel" onclick="closeForm()">Close</button> 
  	</form>
	</div>
  
<script>
function askQuestion() {  
	document.getElementById("newQuestion").style.display = "block";
}

function closeForm() {
  document.getElementById("newQuestion").style.display = "none";
}	
</script>	
	</div>
	<article>
	<div class="ex1"> 
	
		<%
		
		    java.sql.Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/Team2?autoReconnect=true&useSSL=false",user, password);
	                   	                     		   
	        PreparedStatement pstmt = con2.prepareStatement("SELECT  q.question_id, question_text, answer_text, a.dateUpdated "
     			   + "FROM questions q, answers a "
     			   + "WHERE q.question_id = a.question_id "
     			   + "AND question_text LIKE ?");
	        
	        
	        String key = "%" + request.getParameter("searchKey") + "%";
	        pstmt.setString(1, key);
        	
        	ResultSet rs = pstmt.executeQuery();
		       
		   
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
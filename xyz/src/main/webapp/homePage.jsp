<%@ page import="java.sql.*"%> 
<%@ page import="java.util.Date" %>
<% Class.forName("com.mysql.cj.jdbc.Driver"); %>
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
   
	
	<article>
	<div class="ex1"> 
    <% //for tomcat server
     
        try {
            
            java.sql.Connection con; 
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Team2?autoReconnect=true&useSSL=false",user, password);
           
            
            out.println("What's your \"questions\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = 
            		stmt.executeQuery("SELECT questions.question_id,question_text,answer_text,answers.dateUpdated, answers.user_id FROM questions,answers WHERE questions.question_id = answers.question_id ORDER BY dateUpdated DESC");
            while (rs.next()) {
                out.println(rs.getInt(1) + ". " + rs.getString(2) + "<br/><br/>");
                out.println(rs.getString(3) + "<br/><br/>");
                out.println("Last Updated by: " + rs.getString(5) + " " + rs.getDate(4) + "<br/><br/>");
                
            }
            
            
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
    </div>	
   	</article>
   
  
</body>
</html>
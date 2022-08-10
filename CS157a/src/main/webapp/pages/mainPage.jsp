<%@ page import="java.sql.*"%> 
<%@ page import="java.util.Date" %>
<% Class.forName("com.mysql.cj.jdbc.Driver"); %>
<!-- mainPage contains web page header, navigation bar and ask question function -->
<html>	
	<head> 
	<meta charset="UTF-8">
  	<link rel="StyleSheet" href="homePageStyle.css">
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">       
	</head>


<body> 
	
   
   	<h1>SJSU Burning Questions</h1>
   	<!-- top navigation bar contains Home, Account, Moderation, Log out links, search bar, and Category drop down menu --> 	
	<div class="topnav">
	<ul>		
		<li><a class="active" href="homePage.jsp">Home</a></li>		
		
		<li><a href="#account">Account</a></li>
		<li><a href="moderation.jsp">Moderation</a></li>
		<li><a href="../../../../CS157a/src/main/webapp/pages/login.html">Log Out</a></li>
		<li>
			<div class="dropdown">
    			<button class="dropbtn">Category 
      				<i class="fa fa-caret-down"></i>
    			</button>
    			<div class="dropdown-content">
      				<a href="courseResult.jsp">course</a>
      				<a href="slResult.jsp">schoolLife</a>
      				<a href="activityResult.jsp">activity</a>
      				<a href="byResult.jsp">internship</a>     				    				   		
    			</div>
    		</div>
  		</li>
  		
		<!-- search bar -->				
  		<li><form action="searchResult.jsp" method="POST">
  			<ul>
  			<li><input  type="text" name="searchKey"  placeholder="Search question here.."></li>
  			<li><button type="submit"><i class="fa fa-search"></i></button></li>
  			</ul>
  		</form></li>
  		
  		<!-- ask question button -->
  		<li class="ask">
  			<button type="button" onclick="askQuestion()">Ask a question</button>
  		</li>			
  	</ul>	
  		
   	</div>
   	
   	<!-- pop up form for ask question button -->
 	<div class="form-popup" id="newQuestion">    
   	<form action="homePage.jsp" method="POST" class="form-container">
      <%@ include file = "dbConnection.jsp" %>
      	
      <%
      	//add new question to the database questions table
          PreparedStatement addquestion = conAsk.prepareStatement(
          		"INSERT INTO questions(question_id, question_text, dateCreated) "
          		+ "VALUES (?,?,?)" );
          
          if (request.getParameter("add")!= null) { 

          	String qtext = request.getParameter("questiontext");
                  
            Date date = new Date();
  		      Timestamp timeStamp = new Timestamp(date.getTime());
  		
            addquestion.setInt(1, 1);
        		addquestion.setString(2, qtext);		
        		addquestion.setTimestamp(3, timeStamp);
        		int result = addquestion.executeUpdate();
          }
                	
      %> 
      <!-- pop up form format -->
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
   
  
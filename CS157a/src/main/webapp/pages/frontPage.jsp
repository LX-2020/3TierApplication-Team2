<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<% Class.forName("com.mysql.cj.jdbc.Driver"); %>
<html>
  <head>   
    <style>
    body{
    	
    	background-color: #E6E6FA;
    	background-image: url("https://cpb-us-w2.wpmucdn.com/blogs.sjsu.edu/dist/f/94/files/2022/01/general-campus-dschmitz-021616-8616.jpg");
    
    }
    div.ex1 {
  		background-color: #e9e9e9;
  		width: 100%;
  		height: 100%;
  		overflow: scroll;
	}
    h1{
    	text-align: center;
    }
  	
  	nav {
  		float: left;
  		width: 10%;
  		height: 100%; 
  		background: #ccc;
  		padding: 20px;
  	}  		  
  		
    /* top navigation bar style */	
  	.topnav {
  		overflow: hidden;
  		background-color: #e9e9e9;
  		width: 85.6%;
	}
	.topnav a {
  		float: left;
  		display: block;
  		color: black;
  		text-align: center;
  		padding: 14px 20px;
  		text-decoration: none;
  		font-size: 17px;
	}
	.topnav a:hover {
  		background-color: #ddd;
  		color: black;
	}
	.topnav a.active {
  		background-color: #2196F3;
  		color: white;
	}

	
    /* search box in top navigation bar */
    .topnav .search-container {
    	float: right;
    }

    .topnav input[type=text] {
    	padding: 6px;
    	margin-top: 8px;
    	font-size: 17px;
    	border: none;
    }
	.topnav .search-container button {
  		float: right;
  		padding: 6px 10px;
 		margin-top: 8px;
  		margin-right: 16px;
  		background: #ddd;
  		font-size: 17px;
  		border: none;
  		cursor: pointer;
	}

	.topnav .search-container button:hover {
 		background: #ccc;
	}

	/* Ask question button style*/
	.styled {
    	border: 0;
    	line-height: 2.5;
    	padding: 0 20px;
    	font-size: 1rem;
    	text-align: center;
    	color: #fff;
    	text-shadow: 1px 1px 1px #000;
    	border-radius: 10px;
   		background-color: rgba(220, 0, 0, 1);
    	background-image: linear-gradient(to top left,
                                      rgba(0, 0, 0, .2),
                                      rgba(0, 0, 0, .2) 30%,
                                      rgba(0, 0, 0, 0));
    	box-shadow: inset 2px 2px 3px rgba(255, 255, 255, .6),
                inset -2px -2px 3px rgba(0, 0, 0, .6);
    	float: right;
	}

	.styled:hover {
    	background-color: rgba(255, 0, 0, 1);
	}

	.styled:active {
    	box-shadow: inset -2px -2px 3px rgba(255, 255, 255, .6),
                inset 2px 2px 3px rgba(0, 0, 0, .6);
	}

	/* new question form */
	.form-popup {
  		display: none;
  		position: fixed;
  		center: 0;
  		right: 15px;
 		border: 3px solid #f1f1f1;
 		z-index: 9;
	}

	/* Add styles to the form container */
	.form-container {
 		max-width: 100%;
  		padding: 30px;
  		background-color: white;
	}

	textarea {
  		width: 100%;
  		height: 250px;
  		padding: 12px 20px;
  		box-sizing: border-box;
  		border: 2px solid #ccc;
  		border-radius: 4px;
  		background-color: #f8f8f8;
  		font-size: 16px;
  		resize: none;
	}

	/* Set a style for the submit button */
	.form-container .btn {
  		background-color: #04AA6D;
  		color: white;
  		padding: 10px 50px;
  		border: none;
  		cursor: pointer;
  		width: 25%;
  		margin-bottom:20px;
  		opacity: 1;
	}

	/* Add a red background color to the cancel button */
	.form-container .cancel {
  		background-color: red;
	}

	/* Add some hover effects to buttons */
	.form-container .btn:hover, .open-button:hover {
  		opacity: 1;
	}

	/* center display */	
  	article {
  		float: left;
  		padding: 20px;
  		width: 70%;
  		background-color: #f1f1f1;
  		height: 100%; 
	}

</style>   
</head>


<body> 

   <h1>SJSU Burning Questions</h1>
   	
	<div class="topnav">
   		<a class="active" href="#home">Home</a>
  		<a href="#category">Category</a>
  		<a href="#account">Account</a>
  		<input type="text" placeholder="Search..">
  		<button class="styled"
        	type="button"
    		onclick="askQuestion()">
    		Ask a question
		</button>
    </div>

    <nav>  	
    	<ul>
      	<li><a href="#">Contact Us</a></li>
     	<li><a href="#">Ask question</a></li>
    	</ul>    	
	</nav>
	
	
 	<div class="form-popup" id="newQuestion">    
 	<form action="frontPage.jsp" method="POST" class="form-container">
    	
    <%!
    public class addQuestion{
    	String db = "Team2";
        String user = "root";
        String password = "620302mlx";
        
        java.sql.Connection con1; 
        PreparedStatement addquestion = null;
        ResultSet rs = null;
        
        public addQuestion(){
        try {
                                 
            con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/Team2?autoReconnect=true&useSSL=false",user, password);
        
            addquestion = con1.prepareStatement(
            		"INSERT INTO questions(question_text, dateCreated) "
            		+ "VALUES (?,?)" );
            
        } catch(SQLException e) { 
        	e.printStackTrace(); 
        }
        }
        
        public int setQuestion (String text, Timestamp timeStamp) {
        	
        	int result = 0;
        	
        	try {
        	
        	addquestion.setString(1, text);
        	addquestion.setTimestamp(2, timeStamp);
        	result = addquestion.executeUpdate();
        	
        	}catch (SQLException e) {
        		e.printStackTrace();
        	}
        	
        	return result;
        	
        }
    }
    %> 
    <%
    	int result = 0;
    	
    if (request.getParameter("add")!= null) { 
    		String qtext = new String();    	    	
    	
    		if (request.getParameter("questiontext") != null){
    			qtext = request.getParameter("questiontext");
    		}
    	
    		Date date = new Date();
    		Timestamp timeStamp = new Timestamp(date.getTime());
    	
    		addQuestion question = new addQuestion();
    		result = question.setQuestion(qtext, timeStamp);
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
     String db = "sjsu-bq";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "Timecardmnew2244";
        try {
            
            java.sql.Connection con; 

            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sjsu-bq?autoReconnect=true&useSSL=false",user, password);

           // Class.forName("com.mysql.cj.jdbc.Driver");
           // con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Team2?autoReconnect=true&useSSL=false",user, password);

            
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
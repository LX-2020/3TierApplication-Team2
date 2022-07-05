<%@ page import="java.sql.*"%> 
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
  	</div>
  
  	
  
    <nav>  	
    	<ul>
      	<li><a href="#">Contact Us</a></li>
     	<li><a href="#">Ask question</a></li>
    	</ul>
    	
	</nav>
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
           
            
            out.println("What's your \"questions\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT questions.question_id,question_text,answer_text,answers.dateUpdated, answers.user_id FROM questions,answers WHERE questions.question_id = answers.question_id ");
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
<%@ page import="java.sql.*"%> 
<%@ page import="java.util.Date" %>
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
                    
            Statement stmt = con.createStatement();
            ResultSet rs = 
            		stmt.executeQuery("SELECT questions.question_id,question_text,answer_text,answers.dateUpdated, answers.user_id FROM questions,answers WHERE questions.question_id = answers.question_id ORDER BY dateUpdated DESC");
           
        
    %>
    
	<div class="box">
	
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
      			
      			<tr class="ask">     			   	      			
  					<td><button type="button" onclick="answerQuestion(<%= rs.getInt("question_id") %>)">Answer</button></td>  				 
  				</tr>   				     
    		</table>
  		</div>
		<%} %>
  		
   		</div>
	</div>
	
	

    <script>
		function answerQuestion(id) {  
			document.getElementById("answer").style.display = "block";
			document.getElementById("id").value = id;
			
			
		}

		function closeForm() {
  			document.getElementById("answer").style.display = "none";
		}	
	</script>
	
	<div class="form-popup" id="answer">    
 		<form action="homePage.jsp" method="POST" class="form-container">
 			<input  id="id"></input>	
 			
 			<h3>Add an answer:</h3>						
    	    <textarea id="answertext" name="answertext" >Add an answer...</textarea>      	    	    
    		<button name="add" type="submit" class="btn">add</button>
    		<button type="button" class="btn cancel" onclick="closeForm()">Close</button> 
  	
 		</form>
  	</div> 
  			
    </div>	
    
 
    <%    
    	//
    	//out.print(request.getParameter("id"));
        PreparedStatement addanswer = conAns.prepareStatement(
        		"INSERT INTO answers(question_id, answer_text, dateUpdated) "
        		+ "VALUES (?,?,?)" );
        
        if (request.getParameter("add")!= null) { 

        	String qtext = request.getParameter("answertext"); 
        	int qid = Integer.parseInt(request.getParameter("id"));
        	
                
        Date date = new Date();
		Timestamp timeStamp = new Timestamp(date.getTime());
		
		
		
		addanswer.setInt(1, qid);
		addanswer.setString(2, qtext);		
		addanswer.setTimestamp(3, timeStamp);
		int result = addanswer.executeUpdate();
        }
        
       	
    %> 
    
   	</article>  
</body>
</html>
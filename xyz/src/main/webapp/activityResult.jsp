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
                    
         Statement stmt = con.createStatement();
         //database query get question id and question text    			           				
         ResultSet rsq = stmt.executeQuery( "SELECT DISTINCT question_id, question_text FROM questions q, Category c "
        		 							+ " WHERE q.category_id = c.category_id "
        		            				+ " AND q.category_id = 4");  
         
         int num = 0;       
         String qtext[] = new String[100];
         int qids[] = new int[100];         
         //save question text in string array, save question id in int array
         while(rsq.next()) {qtext[num]=rsq.getString("question_text"); qids[num]=rsq.getInt("question_id"); num++;}
    %>
		<!-- question and answer list in table format -->
       	<div class="box">   	
     	<div class="column">
     	
        <%  ResultSet rs2 = null;
        //database query on answers
         for (int i=0;i<num; i++) { 
        	 
          	String query1 = "SELECT answer_text, dateUpdated  FROM answers WHERE question_id=" + qids[i];       
          	rs2 = stmt.executeQuery(query1);
        %> 
          	<!-- list questions and answers -->
          	<div class="row">
    			<table>  		   		
      				<tr>     			
        				<th><%= qtext[i]%></th>       
      				</tr>
      			<% while(rs2.next()){%>
      				<tr>     				
      					<td><%=rs2.getString("answer_text") %>></td>
      				</tr> 
      			<% }%>
      				<tr class="ask">     			   	      			
  						<td><button type="button" onclick="answerQuestion(<%= qids[i] %>)">Answer</button></td> 			 
  					</tr>   				     
          	</table>
  		</div>
        <%} %>  		
   	 </div>
	 </div>
	
	
	<!-- answer button click response -->
    <script>
		function answerQuestion(id) {  
			document.getElementById("answer").style.display = "block";
			document.getElementById("qid").value = id;						
		}

		function closeForm() {
  			document.getElementById("answer").style.display = "none";
		}	
	</script>
	
	<!--  answer button popup answer textarea -->
	<div class="form-popup" id="answer">    
 		<form action="homePage.jsp" method="POST" class="form-container">
 			ID: <input id="qid" name="qid" readonly="readonly"></input>
 			
 			<h3>Add an answer:</h3>						
    	    <textarea id="answertext" name="answertext" >Add an answer...</textarea>      	    	    
    		<button name="add" type="submit" class="btn">add</button>
    		<button type="button" class="btn cancel" onclick="closeForm()">Close</button> 
  	
 		</form>
  	</div> 
  	
	 <%    
    	// add new answer of the question to database answers table	
        PreparedStatement addanswer = conAns.prepareStatement(
        		"INSERT INTO answers(question_id, answer_text, dateUpdated) "
        		+ "VALUES (?,?,?)" );
        
    	String sid = request.getParameter("qid"); 
    	
        if (request.getParameter("add")!= null) { 

        	String atext = request.getParameter("answertext"); 

        	int qid = Integer.parseInt(sid);
        	               
        	Date date = new Date();
			Timestamp timeStamp = new Timestamp(date.getTime());
						
			addanswer.setInt(1, qid);
			addanswer.setString(2, atext);		
			addanswer.setTimestamp(3, timeStamp);
			int result = addanswer.executeUpdate();
        }
               	
    %> 
      			
    </div>	
   
   	</article>  
</body>
</html>
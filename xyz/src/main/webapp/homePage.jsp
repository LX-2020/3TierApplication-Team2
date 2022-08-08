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
                    
           Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
          //  ResultSet rsa = 
            //		stmt.executeQuery( "SELECT question_id, answer_text, dateUpdated "
            //				+ " FROM answers");
            			           				
          // ResultSet rsq =
        //		   stmt.executeQuery( "SELECT question_id, question_text FROM questions" );
           
         /* ResultSet rs = stmt.executeQuery(" SELECT q.question_id,q.question_text,a.answer_text,a.dateUpdated, a.user_id "
          +" FROM questions q,answers a "
          +" WHERE q.question_id = a.question_id "
          +" ORDER BY q.question_id");*/
          
          ResultSet rs1, rs2 = null;
          PreparedStatement ps = null;

          String query = " SELECT q.question_id,q.question_text,a.answer_text,a.dateUpdated, a.user_id "
                  +" FROM questions q,answers a "
                  +" WHERE q.question_id = a.question_id "
                  +" ORDER BY q.question_id";

          ps = con.prepareStatement(query);                
          rs1 = ps.executeQuery();
          rs2 = ps.executeQuery();
    %>
    
	<div class="box">
	
	<div class="column">
	
	
	<% while(rs1.next()) {%>
  		<div class="row">
    		<table>  		   		
      			<tr>     			
        			<th><%= rs1.getString("question_text")%></th>       
      			</tr>
      			<%int temp = rs1.getInt("question_id"); %>
      			<%while(rs2.next()){ %>
      				<%if (rs2.getInt("question_id")==temp){%>
      			<tr>     				
      					<td><%=rs2.getString("answer_text") %>></td>
      			</tr> 
      			
      				<%}%>
      			<%}%>
      			<tr class="ask">     			   	      			
  					<td><button type="button" onclick="answerQuestion(<%= rs1.getInt("question_id") %>)">Answer</button></td> 			 
  				</tr>   				     
    		</table>
  		</div>
		<%} %>
  		
   		</div>
	</div>
	
	

    <script>
		function answerQuestion(id) {  
			document.getElementById("answer").style.display = "block";
			document.getElementById("qid").value = id;			
			
		}

		function closeForm() {
  			document.getElementById("answer").style.display = "none";
		}	
	</script>
	
	<div class="form-popup" id="answer">    
 		<form action="homePage.jsp" method="POST" class="form-container">
 			ID: <input id="qid" name="qid" readonly="readonly"></input>
 			
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
        
    	String sid = request.getParameter("qid"); 
    	
        if (request.getParameter("add")!= null) { 

        	String qtext = request.getParameter("answertext"); 

        	int qid = Integer.parseInt(sid);
        	
                
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="java.sql.*"%> 
<%@ page import="java.util.Date" %>
<% Class.forName("com.mysql.cj.jdbc.Driver"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="form-popup" id="likes">    
   	<form action="homePage.jsp" method="POST" class="form-container">
   		<input id="uid" name="uid" type="hidden" readonly="readonly"></input>
   		<input id="qid" name="qid" type="hidden" readonly="readonly"></input>
   		<input id="aid" name="aid" type="hidden" readonly="readonly"></input>
      	
      <%
          	if (request.getParameter("yes")!= null) { 
          		PreparedStatement likesStmt = conAsk.prepareStatement(
          		"INSERT INTO likes(user_id, question_id, answer_id) "
          		+ "VALUES (?,?,?)" );

          		String uid_str = request.getParameter("uid");
          		String qid_str = request.getParameter("qid");
          		String aid_str = request.getParameter("aid");

          		int uid = Integer.parseInt(uid_str);
          		int qid = Integer.parseInt(qid_str);
          		int aid = Integer.parseInt(aid_str);

	          	likesStmt.setInt(1, uid);
	    		likesStmt.setInt(2, qid);		
	    		likesStmt.setInt(3, aid);
	    		int likesResult = likesStmt.executeUpdate();
	    		System.out.println(likesResult);
	    		if(likesResult==1){
	    		%> 
	    			<script>alert("Saved")</script>
	    		<%
	    		}
	    	}
                	
      %> 
      <!-- pop up form format -->
     	<h3>Are you sure ?</h3>
      	<button name="yes" type="submit" class="btn">Yes</button>
      	<button type="button" class="btn cancel" onclick="closeForm()">No</button> 
    </form>
</div>
</body>
</html>
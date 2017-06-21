<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.shopping.* " %>
<%@ page import = "java.sql.* " %>
<%@ page import = "java.util.* " %>
<% List<Category> categories = Category.getCategories(); %>
<%
    request.setCharacterEncoding("UTF-8");

    String action = request.getParameter("action");

    if(action != null && action.equals("complexsearch")) {
    	int pageNo = 1;
    	String strPageNo = request.getParameter("pageNo");
    	if(strPageNo != null && strPageNo.trim().equals("")) {
    		pageNo = Integer.parseInt(strPageNo);
    	}
       String keyword = request.getParameter("keyword");
       double lowNormalprice = Double.parseDouble(request.getParameter("lowNormalprice")); 
       double highNormalprice = Double.parseDouble(request.getParameter("highNormalprice")); 
       double lowMemberprice = Double.parseDouble(request.getParameter("lowMemberprice")); 
       double highMemberprice = Double.parseDouble(request.getParameter("highMemberprice"));
       int categoryid = Integer.parseInt(request.getParameter("categoryid"));
       int[] idArray;
       if(categoryid == 0) {
    	   idArray = null;
       }else {
    	   idArray = new int[1];
           idArray[0] = categoryid;    
       }
       Timestamp startDate;
       Timestamp endDate;
       String strStartDate = request.getParameter("startDate");
       String strEndDate = request.getParameter("endDate");
       if(strStartDate == null || strStartDate.trim().equals("")) {
    	   startDate = null;
       }else {
    	   startDate = Timestamp.valueOf(request.getParameter("startDate"));
       }
       if(strEndDate == null || strEndDate.trim().equals("")) {
    	   endDate = null;
       }else {
    	   endDate = Timestamp.valueOf(request.getParameter("endDate"));
       }
         
       List<Product> products = ProductMgr.getInstance().findProducts(idArray, keyword, lowNormalprice, highNormalprice, lowMemberprice, highMemberprice, startDate, endDate, 1, 3);
       out.println(products.size()); 
%>
<center>You have successfully added the product!</center>

<center>Search Result</center>
<table border="2" align="center">
<tr>
<td>ID</td>
<td>Name</td>
<td>Description</td>
<td>Normal Price</td>
<td>Member Price</td>
<td>Category id</td>
<td>Product date</td>
<td>Opeartion</td>
</tr>
<%
for(Iterator<Product> it = products.iterator(); it.hasNext();) {
	Product p = it.next();
%>
<tr>
<td><%=p.getId() %></td>
<td><%=p.getName() %></td>
<td><%=p.getDescr() %></td>
<td><%=p.getNormalprice() %></td>
<td><%=p.getMemberprice() %></td>
<td><%=p.getCategoryid() %></td>
<td><%=p.getPdate() %></td>
<td>
<a href="ProductDelete.jsp?id=<%=p.getId()%>">delete</a>
</td>
<td>
<a href="ProductModify.jsp?id=<%=p.getId()%>">modify product</a>
</td>
</tr>
<%
}
%>
</table>
<% 
return;
} 
%>
<center><a href="ProductSearch.jsp?">Next Page</a></center>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
<!--
function checkdata() {
		with(document.forms["complex"]) {
				if(lowNormalprice == null || lowNormalprice.value == "") {
					lowNormalprice.value = -1;
				}
				if(highNormalprice == null || highNowmalprice.value == "") {
					lowNormalprice.value = -1;
				}
				if(lowMemberprice == null || lowNowmalprice.value == "") {
					lowMemberprice.value = -1;
				}
				if(highMemberprice == null || lowNowmalprice.value == "") {
					highMemberprice.value = -1;
				}
		}
}
-->
</script>
</head>
<body>
<center>Simple search</center>
<form name="form" action="ProductSearch.jsp" method="post" onSubmit="">
<table width="750" align="center" border="1" align="center"> 
<select></select>
<input type="text"name="name">
<input type="text"name="keyword">
<input type="submit"value="search">
</table>
</form>

<center>Complex Search</center>
<form name="form" action="ProductSearch.jsp" method="post" onSubmit="checkdata()">
<input type="hidden"name="action"value="complexsearch">
<table width="750" align="center" border="1" align="center"> 
    <tr> 
        <td colspan="2" align="center">category: </td> 
        <td> <select name="categoryid">
        <%for(Iterator<Category> it = categories.iterator(); it.hasNext();) {
        	Category c = it.next();
        	String preStr="";
        	for(int i=1;i<c.getGrade();i++){
        		preStr+="--";
        	}
        	%>
        	
        	<option value="<%=c.getId()%>"><%=c.getName() %></option>
        	<%} %>
        	</select></td>
    </tr>
    <tr> 
        <td>keyword: </td> 
        <td><input type="text" name="keyword" size="30" maxlength="10"></td> 
    </tr> 
    <tr> 
        <td>normal price: </td> 
        <td>From: <input type="text" name="lowNormalprice" size="30" maxlength="10"></td> 
        <td>To: <input type="text" name="highNormalprice" size="30" maxlength="10"></td> 
    </tr> 
    <tr> 
        <td>member price: </td> 
        <td>Form: <input type="text" name="lowMemberprice" size="30" maxlength="10"></td> 
        <td>To: <input type="text" name="highMemberprice" size="30" maxlength="10"></td> 
        
    </tr> 
    <tr>
		<td>pdate: </td>
		<td>From: <input type=text name="startDate" size="15" maxlength="12">
			To:<input type=text name="endDate" size="15" maxlength="12">
		</td>
	</tr>
    <tr> 
        <td></td>
        <td><input type="submit" name="submit"/> <input type="reset" value="reset"></td> 
    </tr> 
</table> 
</form> 
</body>
</html>

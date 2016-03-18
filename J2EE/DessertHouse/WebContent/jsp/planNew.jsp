<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="edu.nju.desserthouse.model.*" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script src="//cdn.bootcss.com/jquery/2.1.4/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<title>计划管理</title>
</head>
<body class = "main-bg">
	<%
		List<Shop> shopList = (List<Shop>)request.getAttribute("shopList");
		List<Dessert> dessertList = (List<Dessert>)request.getAttribute("dessertList");
		String[] dateArr = (String[])request.getAttribute("dateArr");
	%>
	<nav class="navbar navbar-default nav-bg" role="navigation">
		<div class="navbar-header">
			<label class="navbar-brand active">DessertHouse</label>
		</div>
		<div>
			<ul class="nav navbar-nav ">
				<li><a href="/DessertHouse/dessertManage">商品管理</a></li>
				<li><a href="/DessertHouse/planManage">计划管理</a></li>
				<li><a href="/DessertHouse/memberManage">会员管理</a></li>
			</ul>

			<ul class="nav navbar-nav pull-right">
				<li><a href="/DessertHouse/logout">注销</a></li>
			</ul>
		</div>
		</nav>
	<div class="main color-white">
		 <div class = "leftnav">
			<ul class="nav nav-pills nav-stacked">
				<li><a class="left-nav-item" href="/DessertHouse/planManage" >已通过计划</a></li>
				<li><a class="left-nav-item" href="/DessertHouse/planPending" >待审批计划</a></li>
				<li><a class="left-nav-item" href="/DessertHouse/planRejected" >未通过计划</a></li>
				<li><a class="left-nav-item active" href="/DessertHouse/planNew" >制定新计划</a></li>
			</ul>
		 </div>
		 <div class="right-table">
		 	<form method="post">
		 		<div class="control-group">
					<label class="control-label">所属店面：</label>
					<select class="plan-select" id="js-select-shop">
					<%
						for (Shop temp : shopList) {
					%>
					<option value='<%=temp.getSid() %>'><%=temp.getSid() %> : <%=temp.getSname() %></option>
					<%
						}
					%>
      				</select>
      				
      				<label class="control-label">开始时间：</label>
					<select class="plan-select" id="js-select-date">
					<%
						for (int i = 0;i<dateArr.length;i++) {
					%>
					<option value='<%=dateArr[i] %>'><%=dateArr[i] %></option>
					<%
						}
					%>
      				</select>
				</div>
					<%
						String[] weekDay ={"星期一","星期二","星期三","星期四","星期五","星期六","星期天"};
						for (int i = 0;i<7;i++) {
							
					%>
					<table class="table table-hover table-condensed " id="js-table">
						<thead>
					      <tr>
					         <th id='js-weekday-<%=i %>'><%=weekDay[i] %></th>
					      </tr>
						</thead>
					   <tbody>
						<%
							int j = 0;
							for (Dessert item : dessertList) {
						%>
						<tr>
							<td>
								<label class="control-label " id='js-did-<%=i %>-<%=j %>'><%=item.getDid() %></label>
							</td>
							<td>
								<label class="control-label" id='js-name-<%=i %>-<%=j %>'><%=item.getName() %></label>
							</td>
							<td>
								<img src='<%=item.getImage() %>' class="img-rounded"/>
							</td>
							<td>
								<input type="number" name="value" class="plan-amount" id='js-amount-<%=i %>-<%=j %>' min = "0" value = "0">
								<label class="control-label ">个</label>
							</td>
							<td>
								<input type="number" name="value" class="plan-amount" id='js-yuan-<%=i %>-<%=j %>' min = "00" value = "0">
								<label class="control-label ">.</label>
								<input type="number" name="value" class="plan-amount" id='js-jiao-<%=i %>-<%=j %>' min = "00" value = "0">
								<label class="control-label ">元</label>
							</td>
						</tr>
						
						<%j++;} %>
						</tbody>
					</table>
					<%
						}
					%>	
					<div>
					<input type="submit" class="btn btn-success btn-add-shop " value="提交计划" onclick="submitPlan()"/>	
					</div>					
		 	</form>
		 
		 </div>
	</div>
	
	<script src="../dist/js/jquery-1.9.1.min.js"></script>
	<script src="../dist/js/bootstrap.js"></script>
	<script type="text/javascript" charset="utf-8">
		function submitPlan(){
			var sid = $("#js-select-shop").val();
			var date = $("#js-select-date").val();
			var num = $("#js-table").find("tr").length-1;
			//获得所有商品信息
			//字符串内容为：天|天|天
			//天中内容为：商品;商品;商品
			//商品中内容为：id 个数 元 角分
			var dessert="";
			var i = 0;
			var id = "";
			for(;i<7;i++){
				var j = 0;
				for(;j<num;j++){
					id="#js-did-";
					id = id+i;
					id += "-";
					id = id+j;
					dessert = dessert+$(id).html()+" ";
					id="#js-amount-";
					id = id+i;
					id += "-";
					id = id+j;
					dessert = dessert+$(id).val()+" ";
					id="#js-yuan-";
					id = id+i;
					id += "-";
					id = id+j;
					dessert = dessert+$(id).val()+" ";
					id="#js-jiao-";
					id = id+i;
					id += "-";
					id = id+j;
					dessert = dessert+$(id).val()+";";
				}
				dessert = dessert+"|";
			}
			$.ajax({
				type : "post",
				url : "/DessertHouse/createPlan",
				async : false,
				data : {
					sid:sid,
					date:date,
					dessert:dessert
				},
				success : function(data) {
					alert("添加成功");
				},
				error : function() {
					alert("添加失败");
				}
			});
		}
	</script>
</body>
</html>
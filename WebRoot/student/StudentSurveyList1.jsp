<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>学生基本信息</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/bootstrap-responsive.css" />
<link rel="stylesheet" href="css/common.css" />

<link rel="stylesheet" href="css/teacher_information.css" />
<link rel="stylesheet" href="css/teaching_management.css" />
</head>

<body>
	<%@ include file="/include/header.jsp"%>
	<%@ include file="/include/student_main_nav.jsp"%>
	<div class="content">
		<div class="container">
			<div class="row">
				<%@ include file="/include/stuLeftBar.jsp"%>
				<div class="span9">
					<div class="span9 div-content-white-bgr">
						<div class="div-inf-bar">

							<label>问卷调查</label>
						</div>
						<div class="div-inf-tbl">
							<table class="table table-bordered table-condensed"
								id="surveyList">
								<thead>
									<tr>
										<th width="120px">问卷</th>
										<th width="80px">开始</th>
										<th width="80px">结束</th>
										<th width="80px">发起单位</th>
										<th width="80px">操作</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="suPageBean.list" var="s">
										<tr>
											<td><s:property value="#s.title" /></td>
											<td id="start<s:property value="#s.surveyId" />"><s:property
													value="%{getText('{0,date,yyyy-MM-dd}',{#s.startTime})}" /></td>
											<td id="end<s:property value="#s.surveyId" />"><s:property
													value="%{getText('{0,date,yyyy-MM-dd}',{#s.endTime})}" /></td>
											<td><s:property value="#s.sponsor" /></td>
											<td><a
												href="Student_Survey_Information_selectSurveyInfo?surveyId=<s:property value="#s.surveyId" />"
												onclick="return judgeDate(<s:property value="#s.surveyId" />);">填写</a></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
							<div>
								<input type=button class="btn btn-bottom" onclick="upPage()"
									id="upPage" value="上一页">&nbsp;&nbsp;<span id="page"><s:property
										value="suPageBean.page" /></span>&nbsp;&nbsp;<input type="button"
									class="btn btn-bottom" onclick="downPage()" id="downPage"
									value="下一页"><span class="left-distance">共&nbsp;&nbsp;<span
									id="totalPage"><s:property value="suPageBean.totalPage" /></span>&nbsp;&nbsp;页
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/include/footer.jsp"%>
	<script type="text/javascript" src="js/jquery1.12.1.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
	<script>
	var msg = "${requestScope.Message}";
	if (msg != "") {
		alert(msg);
	}
<%request.removeAttribute("Message");%>
	//显示后将request里的Message清空，防止回退时重复显示。
		$(function() {
			alert(message);
			$(".container").css("min-height",
					$(document).height() - 90 - 88 - 41 + "px");//container的最小高度为“浏览器当前窗口文档的高度-header高度-footer高度”
		});
		//查找下一页或上一页问卷列表
		function selectSurveys(page) {

			$("#surveyList tbody").html("");
			$.getJSON("Json_selectStuOrTchrSurveys", {
				page : page
			}, function(data) {
				$("#page").html(data.suPageBean.page);
				$("#totalPage").html(data.suPageBean.totalPage);
				if (data.suPageBean.list.length == 0) {
					alert("未找到相关数据！");
				} else {
					$.each(data.suPageBean.list, function(i, value) {
						var start = value.startTime.substr(0, value.startTime
								.indexOf('T'));
						var end = value.endTime.substr(0, value.endTime
								.indexOf('T'));
						$("#surveyList").append(
								"<tr><td>" + value.title + "</td><td id='start"+value.surveyId+"'>" + start
										+ "</td><td id='end"+value.surveyId+"'>" + end + "</td><td>"
										+ value.sponsor
										+ "</td><td><a href='Student_Survey_Information_selectSurveyInfo?surveyId="+value.surveyId+"' onclick='return judgeDate("+value.surveyId+");'>填写</a></td></tr>");
					});
				}

			});
		}
		//上一页
		function upPage() {
			var page = parseInt($("#page").html());
			if (page == 1) {
				alert("这已经是第一页！");
			} else {
				selectSurveys(page - 1);
			}
		}

		//下一页
		function downPage() {
			var totalPage = parseInt($("#totalPage").html());
			var page = parseInt($("#page").html());
			if (page == totalPage) {
				alert("这已经是最后一页！");
			} else {
				selectSurveys(page + 1);
			}
		}
		
		function judgeDate(surveyId){
			var start=$("#start"+surveyId+"").html();
			var end=$("#end"+surveyId+"").html();
			var date1 = new Date(start);
			var date2 = new Date(end);
			var myDate = new Date();
			if(date1.getTime()>myDate.getTime()){
				alert("还未到问卷填写时间！");
				return false;
			}
			if(date2.getTime()<myDate.getTime()){
				alert("问卷填写时间已过！");
				return false;
			}
			return true;
			
		}
	</script>
</body>
</html>

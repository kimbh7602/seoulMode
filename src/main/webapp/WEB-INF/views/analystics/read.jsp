<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="application/vnd.ms-excel; name='My_Excel', text/html; charset=utf-8"%>

<%
 response.setHeader("Content-Disposition", "inline; filename=Coursenew_Excel_" +new java.sql.Date(System.currentTimeMillis()) + "_.xls");   
 response.setHeader("Content-Description", "JSP Generated Data");
%>




<!-- Course SelectBox -->
<script type="text/javascript">
//AJAX select box
var course = function(province){
	
$.ajax({
 type: "GET",
 url: "<c:url value='/examAjax'/>",
 dataType:"json",
 data: {"COURSE_SEQ":province},
 success: function(result){
	 var list = result.data;
	 console.log('exam success');
  //SELECT BOX ì´ê¸°í           
  $("#exam").find("option").remove().end().append("<option value=''>Exam Select</option>");
 
  //ë°°ì´ ê°ì ë§í¼ option ì¶ê°
   $.each(list, function(i){
    $("#exam").append("<option value='"+list[i].EXAM_SERIES+"'>"+list[i].EXAM_NAME+"</option>")
   });    
  },
   error: function (jqXHR, textStatus, errorThrown) {
	
   alert("ì¤ë¥ê° ë°ìíììµëë¤.("+textStatus+")("+errorThrown+")");
  }                     
 });
}
</script>

<!-- Exam SelectBox -->
<script type="text/javascript">
//AJAX select box
var exam = function(examVal){
	var courseVal = $("#course").val();
$.ajax({
 type: "GET",
 url: "<c:url value='/questionAjax'/>",
 dataType:"json",
 data: {"COURSE_SEQ":courseVal,"EXAM_SERIES":examVal},
 success: function(result){
	 var list = result.data;
	 console.log('question success');
  //SELECT BOX ì´ê¸°í           
  $("#question").find("option").remove().end().append("<option value=''>Quetion Select</option>");
 
  //ë°°ì´ ê°ì ë§í¼ option ì¶ê°
   $.each(list, function(i){
    $("#question").append("<option value='"+list[i].QUESTION_SEQ+"'>"+list[i].QUESTION_NAME+"</option>")
   });    
  },
   error: function (jqXHR, textStatus, errorThrown) {
	
   alert("ì¤ë¥ê° ë°ìíììµëë¤.("+textStatus+")("+errorThrown+")");
  }                     
 });
}
</script>

<!-- Question SelectBox -->
<!-- Pie Chart -->
<script type="text/javascript">
//AJAX select box
var question = function(questionVal){
   var courseVal = $("#course").val();
   var examVal = $("#exam").val();
$.ajax({
 type: "GET",
 url: "<c:url value='/responseAjax'/>",
 dataType:"json",
 data: {"COURSE_SEQ":courseVal,"EXAM_SERIES":examVal, "QUESTION_SEQ":questionVal},
 success: function(result){
    var column = result.col;
    var row = result.row;
    var rowVal = new Array();
     $.each(column, function(i){
      $.each(row, function(j){
         if(column[i].VIEW_SEQ == row[j].VIEW_SEQ){
            rowVal[i] = row[j].CNT;
         }
      }) ;
    });
     $.each(rowVal, function(i){
       if(rowVal[i] == null){
          rowVal[i] = 0;
       } 
     });
    console.log(rowVal[0]);
    console.log('response success');
    var formTag = '<p>'+column[0].QUESTION_NAME+'</p>';
    var formTag2 = '';
      
      formTag += '<table id="datatable" class="table table-striped table-bordered" style="font-size:13px;"> <tr>';
      $.each(column, function(k){
         formTag += '<th> '+column[k].VIEW_NAME+' </th>';
      });
      formTag +='</tr>';
      $.each(rowVal, function(m){
         formTag += '<td>'+rowVal[m]+'</td>';
      });
      formTag +='</table>';
      
      formTag2 += '<div id="dvData" style="display:none;">';
      formTag2 += '<table> <tr>';
      $.each(column, function(k){
         formTag2 += '<th> '+column[k].VIEW_NAME+' </th>';
      });
      formTag2 +='</tr>';
      $.each(rowVal, function(m){
         formTag2 += '<td>'+rowVal[m]+'</td>';
      });
      formTag2 +='</table>';
      formTag2 +='</div>';
      alert(formTag);
   $('#response-div').html(formTag);
   $('#response-div-hidden').html(formTag2);
   
   var graphVal = new Array();
   $.each(column, function(i){
     graphVal[i] = [column[i].VIEW_NAME, rowVal[i]];
   });
   $.jqplot ('graph', [graphVal],
           {
             seriesDefaults: {
               renderer: $.jqplot.PieRenderer,
               rendererOptions: {
                 showDataLabels: true
               }
             },
             legend: { show:true, location: 'e' }
           }
   );
   alert("sucess");
  },
   error: function (jqXHR, textStatus, errorThrown) {
   
   alert("Error.("+textStatus+")("+errorThrown+")");
  }                     
 });
}
</script>

<script>
$(function(){
	$("#btnExport").click(function (e) {
		alert($('#dvData').html());
		
		var uri = encodeURI('data:application/vnd.ms-excel,' + $('#dvData').html());
		window.open(uri);
	    e.preventDefault();
	});
});
</script>


        <!-- page content -->
        <div class="right_coll" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Analystics Chart<small></small></h3>
              </div>
			
              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
              <br>
               
              
              <div class="col-md-12 col-sm-12 col-xs-12">
              <div class="x_panel">
              <div class="form-group">
              <label>Course Selects</label>
              <select id="course" name="COURSE_SEQ" class="form-control col-md-7 col-xs-12" onchange="course(this.value);">
              	<option value="">Course Select</option>
                <c:forEach items="${resultMap.courseList}" var="resultData" varStatus="loop">
                  <option value="${resultData.COURSE_SEQ }">${resultData.COURSE_NAME }</option>
                </c:forEach>
              </select>
              </div>
              <br><br>
              <div class="form-group">
              <label>Exam Selects</label>
              <select id="exam" name="EXAM_SERIES" class="form-control col-md-7 col-xs-12" onchange="exam(this.value);">
              	<option value="">Exam Select</option>
              </select>
              </div>
              <br><br>
              <div class="form-group">
              <label>Question Selects</label>
              <select id="question" name="QUESTION_SEQ" class="form-control col-md-7 col-xs-12" onchange="question(this.value);">
              	<option value="">Question Select</option>
              </select>
              </div>
              </div>
              </div>
              
              <!-- Graph Div -->
              <div class="form-group col-md-12 col-sm-12 col-xs-12">
              	<div class="x_panel">
              		<label>Chart</label>
              		<div class="clearfix"></div>
              		<div id="graph" style="width:600px; height:350px;"></div>
              	</div>
              </div>
              
              <!-- Table Div -->
              <div class="form-group col-md-12 col-sm-12 col-xs-12">
              	<div class="x_panel">
              		<label>Table</label>
              		<br>
              		<input type="button" id="btnExport" value="Export into Excel" />
              		<div class="clearfix"></div>
              		<div class="x_content">
              			<div id="response-div"></div>
              			<div id="response-div-hidden"></div>
              		</div>
              	</div>
              </div>
              
              </div>
              
            </div>
        </div>
        <!-- page content -->
        


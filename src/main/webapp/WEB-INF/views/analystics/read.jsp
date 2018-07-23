<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
  //SELECT BOX 초기화           
  $("#exam").find("option").remove().end().append("<option value=''>Exam Select</option>");
 
  //배열 개수 만큼 option 추가
   $.each(list, function(i){
    $("#exam").append("<option value='"+list[i].EXAM_SERIES+"'>"+list[i].EXAM_NAME+"</option>")
   });    
  },
   error: function (jqXHR, textStatus, errorThrown) {
	
   alert("오류가 발생하였습니다.("+textStatus+")("+errorThrown+")");
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
	 var col = result.col;
	 var row = result.row;
	 var val = result.val;
	 console.log('question success');
  //SELECT BOX 초기화           
  $("#question1").find("option").remove().end().append("<option value=''>Quetion Select</option>");
 
  //배열 개수 만큼 option 추가
   $.each(list, function(i){
    $("#question1").append("<option value='"+list[i].QUESTION_SEQ+"'>"+list[i].QUESTION_NAME+"</option>")
   });    
  
  var formTag2 = '';
   formTag2 += '<div id="dvData">';
   formTag2 += '<table> <tr>';
   $.each(col, function(i){
      formTag2 += '<th> '+col[i].QUESTION_NAME+' </th>';
   });
   formTag2 +='</tr>';
   $.each(row, function(i){
      formTag2 += '<tr><td>'+row[i].MEMBER_NAME+'</td>';
      $.each(val, function(j){
    	 formTag2 += '<td>'+val[j].VIEW_NAME+'</td>';
      });
      formTag2 += '</tr>';
   });
   formTag2 +='</table>';
   formTag2 +='</div>';
   $('#response-div-hidden').html(formTag2);
  },
   error: function (jqXHR, textStatus, errorThrown) {
	
   alert("오류가 발생하였습니다.("+textStatus+")("+errorThrown+")asdfsasdfsafs");
  }                     
 });
}
</script>

<!-- Question1 SelectBox -->
<!-- Pie Chart -->
<script type="text/javascript">
//AJAX select box
var question1 = function(questionVal){
   var courseVal = $("#course").val();
   var examVal = $("#exam").val();
$.ajax({
 type: "GET",
 url: "<c:url value='/responseAjax'/>",
 dataType:"json",
 data: {"COURSE_SEQ":courseVal,"EXAM_SERIES":examVal, "QUESTION_SEQ":questionVal},
 success: function(result){
 	var list = result.data;
 	
 	$("#question2").find("option").remove().end().append("<option value=''>Quetion Select</option>");
 
  //배열 개수 만큼 option 추가
   $.each(list, function(i){
    $("#question2").append("<option value='"+list[i].QUESTION_SEQ+"'>"+list[i].QUESTION_NAME+"</option>")
   });
 
    var column = result.col;
    var row = result.row;
    var rowVal = new Array(column.length);
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
      
      formTag += '<table id="datatable" class="table table-striped table-bordered" style="font-size:13px;"> <tr>';
      $.each(column, function(k){
         formTag += '<th> '+column[k].VIEW_NAME+' </th>';
      });
      formTag +='</tr>';
      $.each(rowVal, function(m){
         formTag += '<td>'+rowVal[m]+'</td>';
      });
      formTag +='</table>';
      
      
      alert(formTag);
   $('#response-div').html(formTag);
   
   
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

<!-- Question2 SelectBox -->
<script type="text/javascript">
//AJAX select box
var question2 = function(questionVal2){
   var courseVal = $("#course").val();
   var examVal = $("#exam").val();
   var questionVal1 = $("#question1").val();
$.ajax({
 type: "GET",
 url: "<c:url value='/crossResponseAjax'/>",
 dataType:"json",
 data: {"COURSE_SEQ":courseVal,"EXAM_SERIES":examVal, "QUESTION_SEQ1":questionVal1, "QUESTION_SEQ2":questionVal2},
 success: function(result){
    var column = result.col;
    var row = result.row;
    var value = result.val;
    var rowVal = new Array(row.length);
    for(var i = 0; i < row.length; i++){
    	rowVal[i] = new Array(column.length);
    }
    console.log(value);
    console.log(row[0].VIEW_SEQ);
    console.log(column[0].VIEW_SEQ);
    
    //INSERT TABLE VALUE
    $.each(rowVal, function(i){
    	$.each(rowVal[i], function(j){
    		$.each(value, function(k){
    			if(row[i].VIEW_SEQ == value[k].OR2){
    				if(column[j].VIEW_SEQ == value[k].OR1){
    					rowVal[i][j] = value[k].CNT;
    				}
    			}
    		})
    	});
    });
     $.each(rowVal, function(i){
       $.each(rowVal[i], function(j){
    	   if(rowVal[i][j] == null){
    		   rowVal[i][j] = 0;
    	   }
       }) ;
     });
     
     
    console.log(rowVal[0]);
    console.log('response success');
    
    //CREATE TABLE
    var formTag = '<p>'+column[0].QUESTION_NAME+'</p>';
      
      formTag += '<table id="datatable" class="table table-striped table-bordered" style="font-size:13px;"> <tr>';
      formTag += '<th></th>';
      $.each(column, function(k){
         formTag += '<th> '+column[k].VIEW_NAME+' </th>';
      });
      formTag +='</tr>';
      $.each(rowVal, function(i){
      	formTag += '<tr><td>'+row[i].VIEW_NAME+'</td>';
      	$.each(rowVal[i], function(j){
         formTag += '<td>'+rowVal[i][j]+'</td>';
         });
      	formTag += '</tr>';
      });
      formTag +='</table>';
      
      $.each(rowVal, function(i){
    	  $.each(rowVal[i], function(j){
    		  console.log(i, j, rowVal[i][j]);
    	  });
      });
      alert(formTag);
   $('#response-div').html(formTag); // DRAW GRAPH
   
   		
	   	var lineVal = new Array(row.length);
   		var lineGraphVal = [];
   		var lineform = new Array();
	    for(var i = 0; i < row.length; i++){
	    	lineVal[i] = [];
	    	for(var j = 0; j < column.length; j++){
	    		lineVal[i].push(rowVal[i][j]);
	    	}
	    	lineGraphVal.push(lineVal[i]);
	    }
	    
	    console.log(lineGraphVal);
	    
	    
	    
	   $.jqplot ('graph', lineGraphVal, {
	       // Give the plot a title.
	       title: 'Plot With Options',
	       // You can specify options for all axes on the plot at once with
	       // the axesDefaults object.  Here, we're using a canvas renderer
	       // to draw the axis label which allows rotated text.
	       axesDefaults: {
	         labelRenderer: $.jqplot.CanvasAxisLabelRenderer
	       },
	       // Likewise, seriesDefaults specifies default options for all
	       // series in a plot.  Options specified in seriesDefaults or
	       // axesDefaults can be overridden by individual series or
	       // axes options.
	       // Here we turn on smoothing for the line.
	       seriesDefaults: {
	           rendererOptions: {
	               smooth: false
	           }
	       
	       },
	       // An axes object holds options for all axes.
	       // Allowable axes are xaxis, x2axis, yaxis, y2axis, y3axis, ...
	       // Up to 9 y axes are supported.
	       axes: {
	         // options for each axis are specified in seperate option objects.
	         xaxis: {
	           label: column[0].QUESTION_NAME,
	           // Turn off "padding".  This will allow data point to lie on the
	           // edges of the grid.  Default padding is 1.2 and will keep all
	           // points inside the bounds of the grid.
	           pad: 0
	         },
	         yaxis: {
	           label: row[0].QUESTION_NAME
	         }
	       }
	     });
   
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
              <select id="question1" name="QUESTION_SEQ1" class="form-control col-md-7 col-xs-12" onchange="question1(this.value);">
              	<option value="">Question Select</option>
              </select>
              </div>
              <br><br>
              <div class="form-group">
              <label>Question Selects</label>
              <select id="question2" name="QUESTION_SEQ2" class="form-control col-md-7 col-xs-12" onchange="question2(this.value);">
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
        


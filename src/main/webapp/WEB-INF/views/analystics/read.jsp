<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- Organization SelectBox -->
<script type="text/javascript">
//AJAX select box
var organization = function(province){
	
$.ajax({
 type: "GET",
 url: "<c:url value='/courseAjax'/>",
 dataType:"json",
 data: {"ORGANIZATION_SEQ":province},
 success: function(result){
	 var list = result.data;
	 console.log('course success');
  //SELECT BOX ì´ê¸°í           
  $("#course").find("option").remove().end().append("<option value=''>Course Select</option>");
 
  //ë°°ì´ ê°ì ë§í¼ option ì¶ê°
   $.each(list, function(i){
    $("#course").append("<option value='"+list[i].COURSE_SEQ+"'>"+list[i].COURSE_NAME+"</option>")
   });    
  },
   error: function (jqXHR, textStatus, errorThrown) {
	
   alert("ì¤ë¥ê° ë°ìíììµëë¤.("+textStatus+")("+errorThrown+")");
  }                     
 });
}
</script>

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
    $("#exam").append("<option value='"+list[i].SURVEY_SEQ+"'>"+list[i].SURVEY_NAME+"</option>")
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
 data: {"COURSE_SEQ":courseVal,"SURVEY_SEQ":examVal},
 success: function(result){
	 var list = result.data;
	 var col = result.col;
	 var row = result.row;
	 var val = result.val;
	 
	 var colLeng = col.length;
	 
	 console.log('question success');
  //SELECT BOX ì´ê¸°í           
  $("#question1").find("option").remove().end().append("<option value=''>Quetion Select</option>");
 
  //ë°°ì´ ê°ì ë§í¼ option ì¶ê°
   $.each(list, function(i){
    $("#question1").append("<option value='"+list[i].QUESTION_SEQ+"'>"+list[i].QUESTION_NAME+"</option>")
   });    
  
  var formTag2 = '';
   formTag2 += '<div id="dvData" style="visibility:hidden">';
   formTag2 += '<table> <tr>';
   $.each(col, function(i){
      formTag2 += '<th> '+col[i].QUESTION_KEYWORD+' </th>';
   });
   formTag2 +='</tr>';
   var count = 0;
      
      $.each(val, function(j){
    	 if(j%colLeng == 0){
    		 formTag2 += '<tr>';
    	 }
    	 formTag2 += '<td>'+val[j].OBJECTIVE_RESPONSE+'</td>';
    	 if(j%colLeng == colLeng-1){
    		 formTag2 += '</tr>';
    	 }
      });
   formTag2 +='</table>';
   formTag2 +='</div>';
   $('#response-div-hidden').html(formTag2);
  },
   error: function (jqXHR, textStatus, errorThrown) {
	
   alert("ì¤ë¥ê° ë°ìíììµëë¤.("+textStatus+")("+errorThrown+")asdfsasdfsafs");
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
 data: {"COURSE_SEQ":courseVal,"SURVEY_SEQ":examVal, "QUESTION_SEQ":questionVal},
 success: function(result){
 	var list = result.data;
 	
 	$("#question2").find("option").remove().end().append("<option value=''>Quetion Select</option>");
 
  //ë°°ì´ ê°ì ë§í¼ option ì¶ê°
   $.each(list, function(i){
    $("#question2").append("<option value='"+list[i].QUESTION_SEQ+"'>"+list[i].QUESTION_NAME+"</option>")
   });
  
  	var btnChart1 = '<button id="pie-chart-1" onclick="pie1();">Pie Chart</button> <button id="bar-chart-1" onclick="bar1();">Bar Chart</button> <button id="line-chart-1" onclick="line1();">Line Chart</button>';
 	$('#btn-chart-1').html(btnChart1);
 	
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
 data: {"COURSE_SEQ":courseVal,"SURVEY_SEQ":examVal, "QUESTION_SEQ1":questionVal1, "QUESTION_SEQ2":questionVal2},
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
    			if(row[i].VIEW_NAME == value[k].OR2){
    				if(column[j].VIEW_NAME == value[k].OR1){
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
   $('#response-div').html(formTag); // CREATE TABLE
   
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

<!-- Pie Chart -->
<script>
var pie1 = function(){
		alert("pie chart");
		   var questionVal = $("#question1").val();
		   var courseVal = $("#course").val();
		   var examVal = $("#exam").val();
		   
		$.ajax({
		 type: "GET",
		 url: "<c:url value='/responseAjax'/>",
		 dataType:"json",
		 data: {"COURSE_SEQ":courseVal,"SURVEY_SEQ":examVal, "QUESTION_SEQ":questionVal},
		 success: function(result){
		 	var list = result.data;
		    var column = result.col;
		    var row = result.row;
		    var rowVal = new Array(column.length);
		    $("#graph-label-val").find("label").remove().end();
		    $("#graph").find(".jqplot-table-legend").remove().end();
		    $("#graph").find(".jqplot-axis").remove().end();
		    $("#graph").find(".jqplot-title").remove().end();
		    $("#graph").find("canvas").remove().end();
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

<!-- Bar Chart -->
<script>
var bar1 = function(){
		alert("bar chart");
		   var questionVal = $("#question1").val();
		   var courseVal = $("#course").val();
		   var examVal = $("#exam").val();
		$.ajax({
		 type: "GET",
		 url: "<c:url value='/responseAjax'/>",
		 dataType:"json",
		 data: {"COURSE_SEQ":courseVal,"SURVEY_SEQ":examVal, "QUESTION_SEQ":questionVal},
		 success: function(result){
		 	var list = result.data;
		    var column = result.col;
		    var row = result.row;
		    var rowVal = new Array(column.length);
		    $("#graph-label-val").find("label").remove().end();
		    $("#graph").find(".jqplot-table-legend").remove().end();
		    $("#graph").find(".jqplot-axis").remove().end();
		    $("#graph").find(".jqplot-title").remove().end();
		    $("#graph").find("canvas").remove().end();
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
		   
		   var ticks = new Array();
		   $.each(column, function(i){
		     ticks.push(i+1);
		   });
		   $.jqplot ('graph', [rowVal],
		           {
		             seriesDefaults: {
		               renderer: $.jqplot.BarRenderer,
// 		               rendererOptions: {
// 		                 showDataLabels: true
						 rendererOptions: {	
							barWidth: 20,      //bar width 설정
                            barPadding: -15,  //bar padding
                            barMargin: 0      //bar간 간격 
 		               }	
		             },
		             axes: {
		                 xaxis: {
		                     renderer: $.jqplot.CategoryAxisRenderer,
		                     ticks : ticks
		                 }
		             },
		             legend: { show:true, location: 'e' }
		           }
		   );
		   var graphLabel = '';
		   $.each(column, function(i){
			  var j = i+1;
			  graphLabel += '<label>'+j+' : '+column[i].VIEW_NAME+'</label><br>'; 
		   });
		   $('#graph-label-val').html(graphLabel);
		   alert("sucess");
		  },
		   error: function (jqXHR, textStatus, errorThrown) {
		   
		   alert("Error.("+textStatus+")("+errorThrown+")");
		  }                     
		 });
	}
</script>

<!-- Line Chart -->
<script>
var line1 = function(){
		alert("line chart");
		   var questionVal = $("#question1").val();
		   var courseVal = $("#course").val();
		   var examVal = $("#exam").val();
		$.ajax({
		 type: "GET",
		 url: "<c:url value='/responseAjax'/>",
		 dataType:"json",
		 data: {"COURSE_SEQ":courseVal,"SURVEY_SEQ":examVal, "QUESTION_SEQ":questionVal},
		 success: function(result){
		 	var list = result.data;
		    var column = result.col;
		    var row = result.row;
		    var rowVal = new Array(column.length);
		    $("#graph-label-val").find("label").remove().end();
		    $("#graph").find(".jqplot-table-legend").remove().end();
		    $("#graph").find(".jqplot-axis").remove().end();
		    $("#graph").find(".jqplot-title").remove().end();
		    $("#graph").find("canvas").remove().end();
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
		   
		     var ticks = [];
			   $.each(column, function(i){
			     ticks.push(i+1);
			   });
			   $.jqplot ('graph', [rowVal], {
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
			           ticks : ticks,
			           // Turn off "padding".  This will allow data point to lie on the
			           // edges of the grid.  Default padding is 1.2 and will keep all
			           // points inside the bounds of the grid.
			           pad: 0
			         },
			         yaxis: {
			           label: "Y Axis"
			         }
			       },
			       legend: { show:true, location: 'e' }
			     });
			   var graphLabel = '';
			   $.each(column, function(i){
				  var j = i+1;
				  graphLabel += '<label>'+j+' : '+column[i].VIEW_NAME+'</label><br>'; 
			   });
			   $('#graph-label-val').html(graphLabel);
		   alert("sucess");
		  },
		   error: function (jqXHR, textStatus, errorThrown) {
		   
		   alert("Error.("+textStatus+")("+errorThrown+")");
		  }                     
		 });
	}
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
              <label>Organization Selects</label>
              <select id="organization" name="ORGANIZATION_SEQ" class="form-control col-md-7 col-xs-12" onchange="organization(this.value);">
              	<option value="">Course Select</option>
                <c:forEach items="${resultMap.organizationList}" var="resultData" varStatus="loop">
                  <option value="${resultData.ORGANIZATION_SEQ }">${resultData.ORGANIZATION_NAME }</option>
                </c:forEach>
              </select>
              </div>
              <br><br>
              <div class="form-group">
              <label>Course Selects</label>
              <select id="course" name="COURSE_SEQ" class="form-control col-md-7 col-xs-12" onchange="course(this.value);">
              	<option value="">Course Select</option>
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
              		<div id="btn-chart-1"></div>
              		<div id="graph-div">
              			<div id="graph" style="width:600px; height:350px;"></div>
              		</div>
              		<div id="graph-label">
              			<div id="graph-label-val"></div>
              		</div>
              		<!-- <div id="graph2" style="width:600px; height:350px;"></div> -->
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
        


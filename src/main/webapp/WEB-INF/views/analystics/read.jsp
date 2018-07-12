<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
$(function(){
	$.jqplot ('graph', [[['ì²«ë²ì§¸', 50], ['ëë²ì§¸', 22], ['ì¸ë²ì§¸', 38], ['ë¤ë²ì§¸', 30]]],
	        {
	          seriesDefaults: {
	            //ìíì¼ë¡ ë ëë§
	            renderer: $.jqplot.PieRenderer,
	            //ìíìë¨ì ê°ë³´ì¬ì£¼ê¸°(ììì %íì¼ë¡ ë³í)
	            rendererOptions: {
	              showDataLabels: true
	            }
	          },
	          //ì°ì¸¡ ììë³ íì´í ì¶ë ¥
	          legend: { show:true, location: 'e' }
	        }
	);
});
</script>

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
	 console.log('response success');
	 alert(column);
	 alert(row);
	 var formTag = "<p>씨발</p>";
		formTag += '<table id="datatable-buttons" class="table table-striped table-bordered"> <thead> <tr>';
		$.each(column, function(i){
			formTag += '<th>'+column[i].VIEW_NAME+'</th>';
		});
		formTag +='</tr> </thead> <tbody>';
		$.each(row, function(i){
			formTag += '<td>'+row[i].CNT+'</td>';
		});
		formTag +='</tbody></table>';
		alert(formTag);
   $('#response-div').html(formTag);
	alert("sucess");
  },
   error: function (jqXHR, textStatus, errorThrown) {
	
   alert("ì¤ë¥ê° ë°ìíììµëë¤.("+textStatus+")("+errorThrown+")");
  }                     
 });
}
</script>


        <!-- page content -->
        <div class="right_coll" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Chart Js <small>Some examples to get you started</small></h3>
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
              <br/>
              <div class="form-group">
              <input type="button" id="btn-graph" value="Draw" class="btn btn-default btn-sm">
              <div id="graph" style="width:400px; height:300px;"></div>
              </div>
              <div class="form-group">
              <label>Table?</label>
              <div id="response-div"></div>
              </div>
              <div class="form-group">
              <label>Course Selects</label>
              <select id="course" name="COURSE_SEQ" class="form-control col-md-7 col-xs-12" onchange="course(this.value);">
              	<option value="">Course Select</option>
                <c:forEach items="${resultMap.courseList}" var="resultData" varStatus="loop">
                  <option value="${resultData.COURSE_SEQ }">${resultData.COURSE_NAME }</option>
                </c:forEach>
              </select>
              </div>
              <div class="form-group">
              <label>Exam Selects</label>
              <select id="exam" name="EXAM_SERIES" class="form-control col-md-7 col-xs-12" onchange="exam(this.value);">
              	<option value="">Exam Select</option>
              </select>
              </div>
              <div class="form-group">
              <label>Question Selects</label>
              <select id="question" name="QUESTION_SEQ" class="form-control col-md-7 col-xs-12" onchange="question(this.value);">
              	<option value="">Question Select</option>
              </select>
              </div>
              
              </div>
              
              <!-- <label>Exam Selects</label>
              <div id="examSeriesDIV"></div> -->
              
            </div>
            

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Line graph<small>Sessions</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="lineChart"></canvas>
                  </div>
                </div>
              </div>

              <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Bar graph <small>Sessions</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="mybarChart"></canvas>
                  </div>
                </div>
              </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
              <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Radar <small>Sessions</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="canvasRadar"></canvas>
                  </div>
                </div>
              </div>

              <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Donut Graph <small>Sessions</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="canvasDoughnut"></canvas>
                  </div>
                </div>
              </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
              <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Pie Graph Chart <small>Sessions</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="pieChart"></canvas>
                  </div>
                </div>
              </div>

              <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Pie Area Graph <small>Sessions</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <canvas id="polarArea"></canvas>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- page content -->

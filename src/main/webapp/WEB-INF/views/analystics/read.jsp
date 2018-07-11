<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
$(function(){
	$.jqplot ('graph', [[['첫번째', 50], ['두번째', 22], ['세번째', 38], ['네번째', 30]]],
	        {
	          seriesDefaults: {
	            //원형으로 렌더링
	            renderer: $.jqplot.PieRenderer,
	            //원형상단에 값보여주기(알아서 %형으로 변환)
	            rendererOptions: {
	              showDataLabels: true
	            }
	          },
	          //우측 색상별 타이틀 출력
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
  //SELECT BOX 초기화           
  $("#question").find("option").remove().end().append("<option value=''>Quetion Select</option>");
 
  //배열 개수 만큼 option 추가
   $.each(list, function(i){
    $("#question").append("<option value='"+list[i].QUESTION_SEQ+"'>"+list[i].QUESTION_NAME+"</option>")
   });    
  },
   error: function (jqXHR, textStatus, errorThrown) {
	
   alert("오류가 발생하였습니다.("+textStatus+")("+errorThrown+")");
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
              <input type="button" id="btn-graph" value="그리기" class="btn btn-default btn-sm">
              <div id="graph" style="width:400px; height:300px;"></div>
              </div>
              <label>Course Selects</label>
              <select id="course" name="COURSE_SEQ" class="form-control col-md-7 col-xs-12" onchange="course(this.value);">
              	<option value="">Course Select</option>
                <c:forEach items="${resultMap.courseList}" var="resultData" varStatus="loop">
                  <option value="${resultData.COURSE_SEQ }">${resultData.COURSE_NAME }</option>
                </c:forEach>
              </select>
              <label>Exam Selects</label>
              <select id="exam" name="EXAM_SERIES" class="form-control col-md-7 col-xs-12" onchange="exam(this.value);">
              	<option value="">Exam Select</option>
              </select>
              <label>Question Selects</label>
              <select id="question" name="QUESTION_SEQ" class="form-control col-md-7 col-xs-12" onchange="question(this.value);">
              	<option value="">Question Select</option>
              </select>
              
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

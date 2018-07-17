<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="question_idx" value="0"/>
<!-- page content -->
        <div class="right_coll	" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Insert <small>Some examples to get you started</small></h3>
              </div>
            </div> 
            <div class="clearfix"></div>
            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Survey Board <small>Users</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <p class="text-muted font-13 m-b-30">
                    	설문조사의 제목, 질문, 보기를 직접 작성한 후 등록 버튼을 눌러주세요.
                    </p>
                        <div class="panel-body">
                            <div class="row">

                                <div class="col-lg-12">
                                <!-- enctype을 설정해주면 Resolver에서 인지함. -->
                                    <form role="form" enctype="multipart/form-data" method="POST" action="<c:url value='/member/merge' />">
	                                    <input type="hidden" name="forwardView" value="/survey/list"/>
	                                    <p> 제목 </p>
	                                    <input type="text" name = "survey_name">
	                                    <input type="hidden" name="SURVEY_SEQ"/>
	                                    <hr>
	                                    <div id="question">
	                                    	<div class = "form-group" id="insert_check">
	                                    		
	                                    	</div>
	                                    	<hr>
	                                    	<div class = "form-group">
		                                    	<label>질문</label>
												<select class ="question_flag" id ="question_flag">
												<c:forEach items="${resultList}" var="resultData" varStatus="loop">
													<option value="${resultData.QUESTION_FLAG_SEQ}">${resultData.QUESTION_FLAG_NAME}</option>
												</c:forEach>
												</select>
		                                    	<input class ="form-control" type="text" name="question" id ="question" value=""/>
		                                    	<hr>
		                                    	<div id="view">
		                                    		<input class="viewAdd" type="button" value ="보기 추가"></input><hr>
		                                    	</div>
		                                    	<div id="views">
		                                    	</div>
	                                    	</div>
	                                    </div>
                                        <button type="submit" class="btn btn-default">${paramMap.action == 'update' ? 'Update' : 'Insert' } Button</button>
                                        <button type="reset" class="btn btn-default">Reset Button</button>
                                    </form>
                                        <button  class="btn btn-default" id ="btnquesAdds">질문 추가</button>
                                </div>
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /.panel-body -->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->
        
<script>
var ve_idx=0;			// #view를 구분하는 idx
$(document).on("change",".question_flag",function(){
	var select = $('#question_flag option:selected').val();
	if(select == "UUID_8000"){
		// 속성바꾸기
		alert(select);
		$.fn.changeobject();
	}else if(select == "UUID_8001"){
		alert(select);
		$.fn.changeobject();
		// select 박스의 속성을 바꿈
	}else if(select == "UUID_8002"){
		alert(select);
		$.fn.changesubject();
		// 보기추가 부분을 Input 하나로.
	}
});
$.fn.changeobject = function(){
	ve_idx = 1;
	var object_html ='<label>보기</label>'
    	+'<input ve="'+(ve_idx)+'"type="text" id="view" name="view'+(ve_idx)+'"/>'
        +'<input ve="'+(ve_idx)+'"type="button" class="btnviewremove'+(ve_idx)+'" value="Remove"><hr>';
	$('#views').html(object_html);
    $('[name = "question"]').val("");
}
$.fn.changesubject = function(){
	ve_idx = 1;
	var subject_html = "<input type='textarea'>";
	$('#views').html(subject_html);
    $('[name = "question"]').val("");
}

$(document).on("click",".viewAdd",function(){
	ve_idx++;
	$('#views').append(
		'<label>보기</label>'
    	+'<input ve="'+(ve_idx)+'"type="text" id="view" name="view'+(ve_idx)+'"/>'
        +'<input ve="'+(ve_idx)+'"type="button" class="btnviewremove'+(ve_idx)+'" value="Remove"><hr>'
    	);
	$('.btnviewremove'+ve_idx).on('click',function(){
		$(this).prev().remove(); // remove the label
		$(this).prev().remove(); // remove the input
        $(this).next ().remove (); // remove the hr
        $(this).remove (); // remove the button
		});
    });
$(function() {
   $("#btnquesAdds")
         .click(
               function() {
                  var views = [];
                  var question = $('[name = "question"]').val();
            	  for(var i =0; i<=ve_idx;i++){
            		  views.push($('[name = "view'+i+'"]').val());
            	  }
            	  var survey_name = $('[name="survey_name"]').val();
            	  var survey_seq = $('[name="SURVEY_SEQ"]').val();
            	  var question_flag = $('#question_flag option:selected').val();
            	  var alldata = {"QUESTION_NAME": question , "views" : views, "SURVEY_NAME" : survey_name ,"SURVEY_SEQ":survey_seq,"QUESTION_FLAG":question_flag};
            	  console.log(alldata);
                  $.ajax({
                      type : "POST",
                      url : "<c:url value='/ws/survey_insert'/>",
                      data : alldata,
                      traditional : true,
                      success : function(data) {
                    	  var test = "";
                    		  for(var i=0;i<data.inputdata.length;i++){
                    			test+='<p> 보기 '+(++i)+') '+data.inputdata[--i].VIEW_NAME+'</p>'
                    			}
                    	console.log(test);
                    	$('#insert_check').append (
                    		'<div class = "form-group">'+
                    		'<p>질문명 :'+data.QUESTION_NAME+' </p>'+
                    		test +
                    		'<p>확인</p>'
                    		);
                		$.fn.changeobject();
                      },
                    
                      error : function(xhr,status, exception) {
                        return false;         
                      }
                   });
   });
});
</script>
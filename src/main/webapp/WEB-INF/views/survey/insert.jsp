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
	                                    <hr>
	                                    <div id="question">
	                                    	<div class = "form-group">
		                                    	<label>질문</label>
												<input type="button" id="btnquesAdds" value="Add">
												<select class ="question_flag" addve ="0" id ="question_flag0">
													<option id="object_single" value="객관식단수">객관식단수</option>
													<option id="object_plural" value="객관식복수">객관식복수</option>
													<option id="subject_plural" value="주관식">주관식</option>
												</select>
		                                    	<input class ="form-control" type="text" name="question"/>
		                                    	<hr>
		                                    	<div id="view0">
		                                    		<input qe="0" addve="0" class="viewAdd" type="button" value ="보기 추가"></input><hr>
		                                    	</div>
		                                    	<div id="views0">
		                                    	</div>
	                                    	</div>
	                                    </div>
                                        <button type="submit" class="btn btn-default">${paramMap.action == 'update' ? 'Update' : 'Insert' } Button</button>
                                        <button type="reset" class="btn btn-default">Reset Button</button>
                                    </form>
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
var ques_idx = 0;		// 질문 idx 
var view_idx = 0;		// 질문에 있는 보기추가 버튼 idx
var ve_idx=0;			// #view를 구분하는 idx
var ques_view_idx =0;	// 질문의 보기들의 idx]

$(document).on("change",".question_flag",function(){
	var question_flag_idx = $(this).attr("addve");
	console.log(question_flag_idx);
	var select = $('#question_flag'+question_flag_idx+' option:selected').val();
	if(select == "객관식단수"){
		// Default 값 그대로 
		alert(select);
	}else if(select == "객관식복수"){
		alert(select);
		$.fn.changeobject(this);
		// select 박스의 속성을 바꿈
	}else if(select == "주관식"){
		alert(select);
		$.fn.changesubject(this);
		// 보기추가 부분을 Input 하나로.
	}
});
var question_html =
$.fn.changeobject = function(object){
	var view_object_idx = $(object).attr("addve");
	var object_html = "<label>보기</label>"
    	+"<input ve='"+(view_idx)+"'type='text' id='view'/>"
        +"<input ve='"+(view_idx)+"'type='button' class='btnviewremove'value='Remove'><hr>"
	$('#views'+view_object_idx).html(object_html);
}

$.fn.changesubject = function(object){
	var view_subject_idx = $(object).attr("addve");
	var subject_html = "<input type='textarea'>";
	$('#views'+view_subject_idx).html(subject_html);
}

$(document).on("click",".viewAdd",function(){
	var viewadd_ques_idx = $(this).attr("qe");
	var viewadd_view_idx = $(this).attr("addve");
	var this_view_idx = viewadd_ques_idx+'viewadd_ques_idx'+ viewadd_view_idx + 'viewadd_view_idx'+ (ques_view_idx++);			// 생성된 보기를 구분하기위한 idx (수정해야함).
	console.log('this_view_idx:'+this_view_idx);
	var viewadd_ve_idx= $(this).attr("addve");			// 클릭한 보기추가 버튼의 idx
	console.log('viewadd_ve_idx:'+viewadd_ve_idx);
	$('#views'+viewadd_ve_idx).append(
		'<label>보기</label>'
    	+'<input ve="'+(this_view_idx)+'"type="text" id="view"/>'
        +'<input ve="'+(this_view_idx)+'"type="button" class="btnviewremove" value="Remove"><hr>'
    	);
	$('.btnviewremove').on('click',function(){
		$(this).prev().remove(); // remove the label
		$(this).prev().remove(); // remove the input
        $(this).next ().remove (); // remove the hr
        $(this).remove (); // remove the button
		});
    });
$(document).ready (function () {                
    $('#btnquesAdds').click (function () {                                        
        $('#question').append (                        
            '<div id="form-group'+ ++ques_idx +'">'
            +'<label>질문</label>'
            +'<input qe="'+(ques_idx)+'" type="button" class="btnremove" value="Remove">'
			+'<select id ="question_flag'+(ques_idx)+'" class ="question_flag" addve="'+(ques_idx)+'">'
			+'<option id="object_single" value="객관식단수">객관식단수</option>'
			+'<option id="object_plural" value="객관식복수">객관식복수</option>'
			+'<option id="subject_plural" value="주관식">주관식</option></select>'
            +'<input class ="form-control" type="text" name="question"/><hr>'
            +'<div id="view'+(++view_idx)+'"><input qe="'+(ques_idx)+'" addve="'+(view_idx) +'"class="viewAdd" type="button" value ="보기 추가">'
            +'</input><hr></div><div id="views'+(view_idx)+'"></div></div>'
        ); // end append
        $('.btnremove').on('click', function () {
        	var idx= $(this).attr("qe");		// 클릭한 질문제거 버튼의 ques_idx
            $(this).prev().remove (); // remove the label
            $(this).next ().remove (); // remove the input
            $(this).next ().remove (); // remove the <hr>
            $(this).next ().remove (); // remove the button
            $(this).remove (); // remove the button
            $('#form-group'+idx).remove(); // remove the div
            ques_idx--;
            view_idx--;
        });
    }); // end click
}); // end ready 
</script>
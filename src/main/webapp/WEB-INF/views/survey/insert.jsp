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
	                                    <input type="hidden" name="MEMBER_SEQ" value="${resultMap.MEMBER_SEQ }" />
	                                    <p> 제목 </p>
	                                    <input type="text" name = "survey_name">
	                                    <hr>
	                                    <div id="question">
	                                    	<div class = "form-group">
		                                    	<label>질문</label>
												<input type="button" id="btnquesAdds" value="Add">
		                                    	<input class ="form-control" type="text" name="question"/>
		                                    	<hr>
		                                    	<div id="view0">
		                                    		<input addve="0" id="viewAdd" type="button" value ="보기 추가"></input><hr>
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
var ques_idx = 0;
var view_idx = 0;
$(document).ready (function () {                
    $('#btnquesAdds').click (function () {                                        
        $('#question').append (                        
            '<div id="form-group'+ ++ques_idx +'">'
            +'<label>질문</label>'
            +'<input qe="'+(ques_idx)+'" type="button" class="btnremove" value="Remove">'
            +'<input class ="form-control" type="text" name="question"/><hr>'
            +'<div id="view'+(++view_idx)+'"><input addve="'+(view_idx) +'"id="viewAdd" type="button" value ="보기 추가">'
            +'</input><hr></div></div>'
        ); // end append
        $('.btnremove').on('click', function () {
        	var idx= $(this).attr("qe");
        	console.log(idx);
            $(this).prev().remove (); // remove the label
            $(this).next ().remove (); // remove the input
            $(this).next ().remove (); // remove the <hr>
            $(this).next ().remove (); // remove the button
            $(this).remove (); // remove the button
            $('#form-group'+idx).remove(); // remove the div
        });
    }); // end click
    $('#viewAdd').click (function(){
    	var this_view_idx = ques_idx + view_idx;
    	console.log('this_view_idx:'+this_view_idx);
    	var ve_idx= $(this).attr("addve");
    	console.log('ve_idx:'+ve_idx);
    	$('#view'+ve_idx).append(
    		'<label>보기</label>'
        	+'<input ve="'+(this_view_idx)+'"type="text" id="view"/>'
            +'<input ve="'+(this_view_idx)+'"type="button" class="btnviewremove" value="Remove"><hr>'
        	);
    	$('.btnviewremove').on('click',function(){
    		$(this).prev().remove(); // remove the label
    		$(this).prev().remove(); // remove the input
            $(this).next ().remove (); // remove the hr
            $(this).remove (); // remove the button
    		})
        });
}); // end ready 
</script>
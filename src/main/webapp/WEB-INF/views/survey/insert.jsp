<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="question_idx" value="0"/>
<script>
$(document).ready (function () {                
    $('#btnAdds').click (function () {                                        
        $('#button').append (                        
            '<div id="question"><label>질문</label><input type="button" id="btnremove" value="Remove"><br><input class ="form-control" type="text" name="question"/><button id="viewAdd" type="button">보기 추가</button><br></div>'                    
        ); // end append                            
        $('#btnremove').on('click', function () {
            $(this).prev().remove (); // remove the label
            $(this).next ().remove (); // remove the <br>
            $(this).next ().remove (); // remove the input
            $(this).next ().remove (); // remove the button
            $(this).remove (); // remove the button
            $('#question').remove(); // remove the div
        });
    }); // end click
    $('#viewAdd').click (function(){
    	$('#view').append(
        	'<input type="text" id="view"/><t>'
        	);
        });
}); // end ready 
</script>
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
										<input type="button" id="btnAdds" value="Add">
	                                    <div id="button">
	                                    	<div class = "form-group">
		                                    	<label>질문</label>
		                                    	<input class ="form-control" type="text" name="question"/>
		                                    	<hr>
		                                    	<div id="view">
			                                    	<input id="viewAdd" type="button">보기 추가</button>
		                                    	</div>
	                                    	</div>
	                                    </div>
<%-- 	                                    
                                        <div class="form-group">
                                            <label>MEMBER_ID Text Input </label>
                                            <input class="form-control" type="text" name="MEMBER_ID" value="${resultMap.MEMBER_ID }">
                                        </div>
                                        <div class="form-group">
                                            <label>Member PASSWORD Text Input </label>
                                            <input class="form-control" type="password" name="PASSWORD" value="${resultMap.PASSWORD }">
                                        </div>
                                        <div class="form-group">
                                            <label>Member Name Text Input </label>
                                            <input class="form-control" type="text" name="NAME" value="${resultMap.NAME }">
                                        </div>
                                        <div class="form-group">
                                            <label>EMAIL Text Input with Placeholder </label>
                                            <input class="form-control" type="text" name="EMAIL" placeholder="incubator@clustringincubation.com" value="${resultMap.EMAIL }">
                                            <p class="help-block">Base form incubator@clustringincubation.com</p>
                                        </div>
                                        <div class="form-group">
                                            <label>CELLPHONE Text Input with Placeholder </label>
                                            <input class="form-control" type="text" name="CELLPHONE" placeholder="000-0000-0000" value="${resultMap.CELLPHONE }">
                                            <p class="help-block">Base form 000-0000-0000</p>
                                        </div>
                                         --%>
                                        <div class="form-group">
                                            <hr>
<!--                                             <input type="file" name="ATTACHEDFILES"/>
                                            <input type="file" name="ATTACHEDFILES02" /> -->
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
$(document).ready (function () {                
    $('.btnAdd').click (function () {                                        
        $('.buttons').append (                        
            '<input type="text" name="txt"> <input type="button" class="btnRemove" value="Remove"><br>'                    
        ); // end append                            
        $('.btnRemove').on('click', function () { 
            $(this).prev().remove (); // remove the textbox
            $(this).next ().remove (); // remove the <br>
            $(this).remove (); // remove the button
        });
    }); // end click                                            
}); // end ready 
</script>
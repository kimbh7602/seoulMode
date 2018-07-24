<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- page content -->
<c:set var="question_idx" value="0" />
<c:set var="view_idx" value="0" />

<div class="right_coll" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>
					Read <small>Some examples to get you started</small>
				</h3>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<form role="form" method="POST"
						action="<c:url value='/survey/response' />">
						<div class="x_title">
							<input type="hidden" name="SUEVEY_SEQ"
								value="${paramMap.SURVEY_SEQ}"> <input type="hidden"
								name="forwardView" value="/survey/list">
							<h2>${paramMap.SURVEY_NAME}<small>설문조사 회차</small>
							</h2>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<div class="panel-body">
								<c:forEach items="${resultList}" var="resultData"
									varStatus="loop">
									<div class="row">
										<p>${resultData.QUESTION_NUM})${resultData.QUESTION_NAME}</p>
										<input type="hidden" name="QUESTION_FLAG"
											value="${resultData.QUESTION_FLAG_SEQ}"> <input
											type="hidden" name="QUESTION_SEQ"
											value="${resultData.QUESTION_SEQ}">
										<c:forEach items="${resultData.VIEWS}" var="questionData"
											varStatus="loop2">
											<c:choose>
												<c:when
													test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8000'}">
													<pre><input type="radio" name="OBJECTIVE_RESPONSE_SINGULAR"
													value="${questionData.VIEW_SEQ}">${questionData.VIEW_NUM})${questionData.VIEW_NAME}
													</pre>
												</c:when>
												<c:when
													test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8001'}">
													<pre><input type="checkbox" name="OBJECTIVE_RESPONSE_PLURAL" ques_seq ="${resultData.QUESTION_SEQ}"
															value="${questionData.VIEW_SEQ}">${questionData.VIEW_NUM})${questionData.VIEW_NAME}
													</pre>
												</c:when>
												<c:when
													test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8002'}">
													<!-- <input type ="text"/> -->
													<textarea name="SUBJECTIVE_RESPONSE" rows="5"
														required="required" wrap="hard"></textarea>
												</c:when>
												<c:when
													test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8003'}">
													<!-- <input type ="text"/> -->
													<textarea name="SUBJECTIVE_RESPONSE" cols="50" rows="10"
														required="required" wrap="hard"></textarea>
												</c:when>
												<c:when
													test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8004'}">
													<input type="radio" name="SATISFACTION_RESPONSE" value="1">1
													<input type="radio" name="SATISFACTION_RESPONSE" value="2">2
													<input type="radio" name="SATISFACTION_RESPONSE" value="3">3
													<input type="radio" name="SATISFACTION_RESPONSE" value="4">4
													<input type="radio" name="SATISFACTION_RESPONSE" value="5">5
												</c:when>
											</c:choose>
										</c:forEach>
										<c:if test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8001'}">
											<input type="hidden" flag="${resultData.QUESTION_SEQ}" name="VIEW_IDX" value=0>
										</c:if>
									</div>
									<c:set var="question_idx" value="${question_idx+1}" />
									<hr>
								</c:forEach>
							</div>
						</div>
						<button type="submit" class="btn btn-default">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
    $("input:checkbox[name=OBJECTIVE_RESPONSE_PLURAL]").change(function(){
        if($("input:checkbox[name=OBJECTIVE_RESPONSE_PLURAL]").is(":checked")){
        	var id = $(this).attr("ques_seq");
         	var length = $("input[type=checkbox][name=OBJECTIVE_RESPONSE_PLURAL][ques_seq="+id+"]:checked").length;
        	$.fn.countup(id,length);
        }else{
        	var id = $(this).attr("ques_seq");
         	var length = $("input[type=checkbox][name=OBJECTIVE_RESPONSE_PLURAL][ques_seq="+id+"]:checked").length;
        	$.fn.countdown(id,length);
        }
    });
});


$.fn.countup = function(object,object2){
	$("[flag = '"+object+"']").val(object2);
}

$.fn.countdown = function(object,object2){
	$("[flag = '"+object+"']").val(object2);
}
</script>
<!-- /page content -->
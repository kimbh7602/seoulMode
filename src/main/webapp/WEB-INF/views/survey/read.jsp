<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- page content -->
<c:set var="subjective_idx" value="0"/>
<c:set var="object_plural_idx" value="0"/>
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
							<input type="hidden" name="SURVEY_SEQ"
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
									<c:if test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8000'}"></c:if>
									<c:if test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8001'}">
									<c:set var="object_plural_idx" value="${object_plural_idx + 1}"/>
									</c:if>
									<c:if test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8002'}">
									<c:set var="subjective_idx" value="${subjective_idx + 1}"/>
									</c:if>
									<c:if test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8003'}">
									<c:set var="subjective_idx" value="${subjective_idx + 1}"/>
									</c:if>
									<c:if test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8004'}"></c:if>
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
													<pre><input type="radio" name="OBJECTIVE_RESPONSE_SINGULAR,${resultData.QUESTION_SEQ}"
													value="${questionData.VIEW_NAME}">${questionData.VIEW_NUM})${questionData.VIEW_NAME}
													</pre>
												</c:when>
												<c:when
													test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8001'}">
													<pre><input type="checkbox" name="OBJECTIVE_RESPONSE_PLURAL" ques_seq ="${resultData.QUESTION_SEQ}"
															value="${questionData.VIEW_NAME}">${questionData.VIEW_NUM})${questionData.VIEW_NAME}
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
													<input type="radio" name="SATISFACTION_RESPONSE,${resultData.QUESTION_SEQ}" value="1">1
													<input type="radio" name="SATISFACTION_RESPONSE,${resultData.QUESTION_SEQ}" value="2">2
													<input type="radio" name="SATISFACTION_RESPONSE,${resultData.QUESTION_SEQ}" value="3">3
													<input type="radio" name="SATISFACTION_RESPONSE,${resultData.QUESTION_SEQ}" value="4">4
													<input type="radio" name="SATISFACTION_RESPONSE,${resultData.QUESTION_SEQ}" value="5">5
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
						<input type="hidden" name= "OBJECT_PLURAL_IDX" value ="${object_plural_idx}">
						<input type="hidden" name= "SUBJECTIVE_IDX" value ="${subjectivce_idx}">
						<small>등록을 누르기 전에 응답하지않은 문항이 있는지 확인해주세요.</small>
						<button type="submit" class="btn btn-default">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$.fn.subjective_idx('${subjective_idx}');
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


$.fn.subjective_idx = function(subjective_idx){
	$("[name = SUBJECTIVE_IDX]").val(subjective_idx);
	console.log(subjective_idx);
}

$.fn.countup = function(object,object2){
	$("[flag = '"+object+"']").val(object2);
}

$.fn.countdown = function(object,object2){
	$("[flag = '"+object+"']").val(object2);
}
</script>
<!-- /page content -->
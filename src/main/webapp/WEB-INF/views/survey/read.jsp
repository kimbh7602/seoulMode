<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- page content -->
<c:set var="question_idx" value="0"/>
<c:set var="view_idx" value="0"/>

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
					<form role="form" method="POST" action="<c:url value='/survey/response' />">
					<div class="x_title">
						<input type="hidden" name="SUEVEY_SEQ" value="${paramMap.SURVEY_SEQ}">
						<h2>${paramMap.SURVEY_NAME}<small>설문조사 회차</small>
						</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<div class="panel-body">
						<c:forEach items="${resultList}" var="resultData" varStatus="loop">
								<div class="row">
									<p>${resultData.QUESTION_NUM})${resultData.QUESTION_NAME}</p>
									<input type="hidden" name="${question.idx}QUESTION_FLAG" value="${resultData.QUESTION_FLAG_SEQ}">
									<input type="hidden" name="${question.idx}QUESTION_SEQ" value="${resultData.QUESTION_SEQ}">
									<c:forEach items="${resultData.VIEWS}" var="questionData"
										varStatus="loop2">
										<c:set var="view_idx" value="${view_idx+1}"/>
										<c:choose>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8000'}">
												<pre><input type="radio" name="${question_idx}chk_view"
													value="${questionData.VIEW_SEQ}">${questionData.VIEW_NUM})${questionData.VIEW_NAME}
													</pre>
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8001'}">
												<pre ><input type="checkbox" name="${question_idx}checkbox${view_idx}"
													value="${questionData.VIEW_SEQ}">${questionData.VIEW_NUM})${questionData.VIEW_NAME}
													</pre>
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8002'}">
												<!-- <input type ="text"/> -->
												<textarea name="${question_idx}content${view_idx}" rows="5"
													required="required" wrap="hard"></textarea>
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8003'}">
												<!-- <input type ="text"/> -->
												<textarea name="${question_idx}content${view_idx}" cols="50" rows="10"
													required="required" wrap="hard"></textarea>
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8004'}">
												<input type="radio" name="${question_idx}" value ="1">1
												<input type="radio" name="${question_idx}" value ="2">2
												<input type="radio" name="${question_idx}" value ="3">3
												<input type="radio" name="${question_idx}" value ="4">4
												<input type="radio" name="${question_idx}" value ="5">5
											</c:when>
										</c:choose>
									</c:forEach>
								</div>
							<c:set var="view_idx" value="0"/>
							<c:set var="question_idx" value="${question_idx+1}"/>
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

</script>
<!-- /page content -->
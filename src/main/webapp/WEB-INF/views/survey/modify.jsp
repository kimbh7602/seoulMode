<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- page content -->
<c:set var="question_idx" value="0"/>
<c:set var="view_idx" value="0"/>

<div class="right_coll" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>
					Modify <small>Some examples to get you started</small>
				</h3>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<form role="form" method="POST" action="<c:url value='/survey/modify_enrollment' />">
					<div class="x_title">
						<input type="hidden" name="SUEVEY_SEQ" value="${paramMap.SURVEY_SEQ}">
						<input type="hidden" name="forwardView" value="/survey/list">
						<h2>${paramMap.SURVEY_NAME}<small>설문조사 회차</small>
						</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<div class="panel-body">
						<c:forEach items="${resultList}" var="resultData" varStatus="loop">
								<div class="row">
									${resultData.QUESTION_NUM})<input type="text" style="width: 60%;" name="QUESTION_NAME" value="${resultData.QUESTION_NAME}">
									<input type="hidden" name="QUESTION_FLAG" value="${resultData.QUESTION_FLAG_SEQ}">
									<input type="hidden" name="QUESTION_SEQ" value="${resultData.QUESTION_SEQ}">
									<hr>
									<c:forEach items="${resultData.VIEWS}" var="questionData"
										varStatus="loop2">
										<c:set var="view_idx" value="${view_idx+1}"/>
										<c:choose>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8000'}">
												<input type="hidden" name="VIEW_SEQ" value="${questionData.VIEW_SEQ}">
												<pre >${questionData.VIEW_NUM})<input type="text"  style="width: 60%;" name="VIEW_NAME" value="${questionData.VIEW_NAME}">
												</pre>
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8001'}">
												<input type="hidden" name="VIEW_SEQ" value="${questionData.VIEW_SEQ}">
												<pre >${questionData.VIEW_NUM})<input type="text"  style="width: 60%;" name="VIEW_NAME" value="${questionData.VIEW_NAME}">
												</pre>
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8002'}">
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8003'}">
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8004'}">
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
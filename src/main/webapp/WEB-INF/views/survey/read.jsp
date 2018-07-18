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
					<div class="x_title">
						<h2>${paramMap.SURVEY_NAME}<small>설문조사 회차</small>
						</h2>
						<div class="clearfix"></div>
					</div>
					<form role="form" enctype="multipart/form-data" method="POST" action="<c:url value='/survey/response' />">
					<div class="x_content">
						<c:forEach items="${resultList}" var="resultData" varStatus="loop">
							<div class="panel-body">
								<div class="row">
									<p>${resultData.QUESTION_NUM})${resultData.QUESTION_NAME}</p>
									<c:forEach items="${resultData.VIEWS}" var="questionData"
										varStatus="loop2">
										<c:set var="view_idx" value="${view_idx+1}"/>
										<c:choose>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8000'}">
												<input type="radio" name="${question_idx}chk_view${view_idx}"
													value="${questionData.VIEW_SEQ}">${questionData.VIEW_NUM})${questionData.VIEW_NAME}
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8001'}">
												<input type="checkbox" name="${question_idx}checkbox${view_idx}"
													value="${questionData.VIEW_SEQ}">${questionData.VIEW_NUM})${questionData.VIEW_NAME}
														<hr>
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8002'}">
												<!-- <input type ="text"/> -->
												<textarea name="${question_idx}content${view_idx}" rows="1"
													required="required" wrap="hard"></textarea>
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8003'}">
												<!-- <input type ="text"/> -->
												<textarea name="${question_idx}content${view_idx}" cols="50" rows="10"
													required="required" wrap="hard"></textarea>
											</c:when>
											<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8004'}">
											<!-- 이부분은 1~5 점 RadioButton 으로 선택할 수있게 -->
											</c:when>
										</c:choose>
									</c:forEach>
								</div>
							</div>
							<c:set var="view_idx" value="0"/>
							<c:set var="question_idx" value="${question_idx+1}"/>
						</c:forEach>
					</div>
					<button type="submit" class="btn btn-default">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	
</script>
<!-- /page content -->
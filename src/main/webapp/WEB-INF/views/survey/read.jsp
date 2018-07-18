<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- page content -->
<div class="right_coll" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>
					Read <small>Some examples to get you started</small>
				</h3>
			</div>

			<!--               <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div> -->
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
					<div class="x_content">
 						<c:forEach items="${resultList}" var="resultData"  varStatus="loop">
								<div class="panel-body">
									<div class="row" flag ="${resultData.QUESTION_FLAG_SEQ}">
										<p>${resultData.QUESTION_NAME}</p>
										<c:forEach items="${resultData.VIEWS}" var="questionData" varStatus="loop2">
											<c:choose>
													<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8002'}" >
														<!-- <input type ="text"/> -->
														<textarea name="content" cols="50" rows="10" required="required" wrap="hard"></textarea>
													</c:when>
													<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8000'}" >
														<input type="radio" name="chk_view" value="${questionData.VIEW_SEQ}">${questionData.VIEW_NAME}
													</c:when>
													<c:when test="${resultData.QUESTION_FLAG_SEQ == 'UUID_8001'}" >
														<input type="checkbox" name="checkbox" value="${questionData.VIEW_SEQ}">${questionData.VIEW_NAME}
														<hr>
													</c:when>
											</c:choose>
										</c:forEach>
									</div>
								</div>
 						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
</script>
<!-- /page content -->
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
						<c:forEach items="${resultData}" var="questionData" varStatus="loop2">
							<c:when test="${questionData.QUESTION_NAME eq 'qq'}">
							</c:when>
							<c:otherwise>
								<div class="panel-body">
									<div class="row">
										<div class="col-lg-12">
											<p>${questionData.QUESTION_NAME}</p>
										</div>
									</div>
								</div>
							</c:otherwise>
 						</c:forEach>
 						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
console.log('${resultData}');
</script>
<!-- /page content -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- page content -->
<div class="right_coll" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>
					List <small>Some examples to get you started</small>
				</h3>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>
							Survey Board <small>Users</small>
						</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<p class="text-muted font-13 m-b-30">수강생이 수강중인 과정에 대한 설문조사입니다.
						</p>
						<table id="datatable" class="table table-striped table-bordered">
							<c:choose>
								<c:when test="${resultMap.auth eq 'ROLE_USER'}">
									<thead>
										<tr>
											<th>설문조사 명</th>
											<th>SEQ</th>
											<th>기관</th>
											<th>응답여부</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${resultList}" var="resultData"
											varStatus="loop">
											<tr>
												<td>${resultData.SURVEY_NAME}</td>
												<td>${resultData.SURVEY_SEQ}</td>
												<td>${resultData.ORGANIZATION_NAME}</td>
												<td><a
													href="<c:url value='/survey/read?SURVEY_SEQ=${resultData.SURVEY_SEQ}'/>">미응답</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:when>

								<c:when test="${resultMap.auth eq 'ROLE_ADMIN'}">
									<thead>
										<tr>
											<th>설문조사 명</th>
											<th>SEQ</th>
											<th>기관</th>
											<th>Delete</th>
											<th>Modify</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${resultList}" var="resultData"
											varStatus="loop">
											<tr>
												<td><a
													href="<c:url value='/survey/read?SURVEY_SEQ=${resultData.SURVEY_SEQ}'/>">${resultData.SURVEY_NAME}</a></td>
												<td>${resultData.SURVEY_SEQ}</td>
												<td>${resultData.ORGANIZATION_NAME}</td>
												<td><a
													href="<c:url value='/survey/delete?SURVEY_SEQ=${resultData.SURVEY_SEQ}&forwardView=${resultData.forwardView}'/>">삭제</a></td>
												<td><a
													href="<c:url value='/survey/modify?SURVEY_SEQ=${resultData.SURVEY_SEQ}'/>">수정</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:when>
							</c:choose>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /page content -->
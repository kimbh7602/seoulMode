<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="question_idx" value="0" />
<!-- page content -->
<div class="right_coll	" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>
					Insert <small>Some examples to get you started</small>
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
						<p class="text-muted font-13 m-b-30">설문조사의 제목, 해당 과정, 질문, 보기를 직접 작성한
							후 등록 버튼을 눌러주세요.</p>
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-12">
									<!-- enctype을 설정해주면 Resolver에서 인지함. -->
									<form role="form" method="POST"
										action="<c:url value='/survey/course_rel_insert' />">
										<input type="hidden" name="forwardView" value="/survey/list" />
										<p>제목</p>
										<input type="text" name="SURVEY_NAME"/>
										<input type="hidden" name="SURVEY_SEQ"/>
										<div id="question">
											<div class="form-group" id="insert_check"></div>
											<hr>
											<div class="form-group">
												<label>질문</label> <select class="question_flag"
													id="question_flag" name="question_flag" style="height: 25;">
													<c:forEach items="${resultList[0]}" var="resultData"
														varStatus="loop1">
														<option value="${resultData.QUESTION_FLAG_SEQ}">${resultData.QUESTION_FLAG_NAME}</option>
													</c:forEach>
												</select>
												<span class="help-block">질문작성 전 질문형태를 설정해주세요.</span>
												 <input class="form-control" type="text" name="question"
													id="question" value="" />
												<hr>
												<div id="view">
													<input class="viewAdd" type="button" value="보기 추가"></input>
													<hr>
												</div>
												<div id="views"></div>
											</div>
											<hr>
											<p>과정 선택</p>
											<span class="help-block">설문을 입력하기 전 과정을 선택해주세요.</span>
											<select class="course_seq" id ="course_seq" name="COURSE_SEQ"style="height: 25;">
												<c:forEach items="${resultList[1]}" var="resultData"
													varStatus="loop0">
													<option value="${resultData.COURSE_SEQ}">${resultData.ORGANIZATION_NAME} ) ${resultData.COURSE_NAME}</option>
												</c:forEach>
											</select>
											<hr>
										</div>
										<div>
											<button class="btn btn-default" id="btnquesAdds">질문
												추가</button>
											<span class="help-block">질문을 완성한 후 눌러주세요.</span>
											<hr>
										</div>
										<button type="submit" class="btn btn-default">${paramMap.action == 'update' ? '수정' : '등록' }</button>
										<!-- <button type="reset" class="btn btn-default"></button> -->
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
<style>
p{font-size:20px};
</style>
<script>
	var ve_idx = 0; // #view를 구분하는 idx
	var ques_idx = 0; // 질문 갯수 Count
	$(document).on("change", ".question_flag", function() {
		var select = $('#question_flag option:selected').val();
		if (select == "UUID_8000") {
			// 속성바꾸기
			alert(select);
			$.fn.changeobjectsingular();
		} else if (select == "UUID_8001") {
			alert(select);
			$.fn.changeobjectplural();
		} else if (select == "UUID_8002") {
			alert(select);
			$.fn.changesubject();
		} else if (select == "UUID_8003") {
			alert(select);
			$.fn.changesatisfaction();
		} else if (select == "UUID_8004") {
			alert(select);
			$.fn.changedescription();
		}
	});
	$.fn.changeobjectsingular = function() { // 객관식단수 선택 시 
		ve_idx = 1;
		var object_html = '<label>보기</label>' + '<input ve="' + (ve_idx)
				+ '"type="text" id="view" name="view' + (ve_idx) + '"/>'
				+ '<input ve="' + (ve_idx)
				+ '"type="button" class="btnviewremove" value="Remove"><hr>'
				+ '<input type = "hidden" name ="flag" value="singular">';
		$('#views').html(object_html);
		var object_html_view = '<input class="viewAdd" type="button" value ="보기 추가"></input><hr>';
		$('#view').html(object_html_view);
		$('[name = "question"]').val("");
	}
	$.fn.changeobjectplural = function() { // 객관식복수 선택 시 
		ve_idx = 1;
		var object_html = '<label>보기</label>' + '<input ve="' + (ve_idx)
				+ '"type="text" id="view" name="view' + (ve_idx) + '"/>'
				+ '<input ve="' + (ve_idx)
				+ '"type="button" class="btnviewremove" value="Remove"><hr>'
				+ '<input type = "hidden" name ="flag" value="plural">';
		$('#views').html(object_html);
		var object_html_view = '<input class="viewAdd" type="button" value ="보기 추가"></input><hr>';
		$('#view').html(object_html_view);
		$('[name = "question"]').val("");
	}
	$.fn.changesubject = function() { // 주관식 선택 시
		ve_idx = 98765;
		var subject_html = "<input type='hidden' name='flag' value='subject' ve='" + (ve_idx) + "'>";
		$('#views').html(subject_html);
		var subject_html_view = "<hr>";
		$('#view').html(subject_html_view);
		$('[name = "question"]').val("");
	}
	$.fn.changesatisfaction = function() { // 만족도 선택 시
		ve_idx = 98765;
		var satisfaction_html = "<input type='hidden' name='flag' value='satisfaction' ve='" + (ve_idx) + "'>";
		$('#views').html(satisfaction_html);
		var satisfaction_html_view = "<hr>";
		$('#view').html(satisfaction_html_view);
		$('[name = "question"]').val("");
	}
	$.fn.changedescription = function() { // 만족도 선택 시
		ve_idx = 98765;
		var description_html = "<input type='hidden' name='flag' value='description' ve='" + (ve_idx) + "'>";
		$('#views').html(description_html);
		var description_html_view = "<hr>";
		$('#view').html(description_html_view);
		$('[name = "question"]').val("");
	}
	
	$.fn.confirm = function(object){
		$('[name = "SURVEY_SEQ"]').val(object.SURVEY_SEQ);
	}

	$(document)
			.on(
					"click",
					".viewAdd",
					function() {
						ve_idx++;
						$('#views')
								.append(
										'<label>보기</label>'
												+ '<input ve="'
												+ (ve_idx)
												+ '"type="text" id="view" name="view'
												+ (ve_idx)
												+ '"/>'
												+ '<input ve="'
												+ (ve_idx)
												+ '"type="button" class="btnviewremove" value="Remove"><hr>');
					});

	$(document).on("click", ".btnviewremove", function() {
		$(this).prev().remove(); // remove the label
		$(this).prev().remove(); // remove the input
		$(this).next().remove(); // remove the hr
		$(this).remove(); // remove the button
		ve_idx--;
	});

	$(function() {
		$("#btnquesAdds").click(
				function() {
					ques_idx++;
					var views = [];
					var views_num = [];
					var question = $('[name = "question"]').val();
					if (ve_idx == 98765) {
						views.push($('[name="flag"]').val());
						views_num.push($('[name="flag"]').attr("ve"));
					} else {
						for (var i = 1; i <=ve_idx; i++) {
							views.push($('[name = "view' + i + '"]').val());
							views_num.push($('[name = "view' + i + '"]').attr("ve"));
						}
					}

					var survey_name = $('[name="SURVEY_NAME"]').val();
					var survey_seq = $('[name="SURVEY_SEQ"]').val();
					var question_flag = $('#question_flag option:selected').val();

					var alldata = {
						"QUESTION_NUM" : ques_idx,
						"QUESTION_NAME" : question,
						"views" : views,
						"views_num" : views_num,
						"SURVEY_NAME" : survey_name,
						"SURVEY_SEQ" : survey_seq,
						"QUESTION_FLAG" : question_flag
					};
					// 180717 ERD 수정한 후 , 질문 INDEX 추가하자.
					$.ajax({
						type : "POST",
						url : "<c:url value='/ws/survey_insert'/>",
						data : alldata,
						traditional : true,
						success : function(data) {
							var test = "";
							for (var i = 0; i < data.inputdata.length; i++) {
								test += '<p> 보기 ' + (++i) + ') '
										+ data.inputdata[--i].VIEW_NAME
										+ '</p>'
							}
							console.log(test);
							$('#insert_check').append(
									'<div class = "form-group">' + '<p>질문명 :'
											+ data.QUESTION_NAME + ' </p>'
											+ test + '<p>확인</p>');
							$.fn.confirm(data);
						},

						error : function(xhr, status, exception) {
						}
					});
				});
	});
</script>
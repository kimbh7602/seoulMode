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
						<p class="text-muted font-13 m-b-30">설문조사의 제목, 해당 과정, 질문, 질문 키워드, 보기를 직접 작성한 후 등록 버튼을 눌러주세요.</p>
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-12">
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
												<p>질문 키워드</p> 
												<span class="help-block">통계를 위해 질문의 키워드를 정해주세요.</span>
												<input class="form-control" type="text" name="question_keyword" id="question_keyword" value="" />
												<hr>
												<div id="view">
													<input class="viewAdd" type="button" value="보기추가">
													<hr>
												</div>
												<div id="views"></div>
											</div>
											<hr>
											<p>과정 선택</p>
											<span class="help-block">설문을 등록하기 전 과정을 선택해주세요.</span>
											<select class="course_seq" id ="course_seq" name="COURSE_SEQ"style="height: 25;">
												<c:forEach items="${resultList[1]}" var="resultData"
													varStatus="loop0">
													<option value="${resultData.COURSE_SEQ}">${resultData.ORGANIZATION_NAME} ) ${resultData.COURSE_NAME}</option>
												</c:forEach>
											</select>
											<hr>
										</div>
										<div>
											<button type="button" class="btn btn-default" id="btnquesAdds">질문추가</button>
											<span class="help-block">질문을 완성한 후 눌러주세요</span>
											<hr>
										</div>
										<button type="submit" class="btn btn-default">${paramMap.action == 'update' ? '수정' : '등록' }</button>
										<span class="help-block">질문 추가버튼으로 질문을 추가한 후, 마지막으로 등록 버튼을 눌러주세요.</span>
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
	var ve_idx = 0; 
	var ques_idx = 0; 
	$(document).on("change", ".question_flag", function() {
		var select = $('#question_flag option:selected').val();
		if (select == "UUID_8000") {
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
			$.fn.changedescription();
		} else if (select == "UUID_8004") {
			alert(select);
			$.fn.changesatisfaction();
		}
	});
	$.fn.changeoriginal = function() {
		ve_idx = 0;
		var object_html_view = '<input class="viewAdd" type="button" value="보기추가"><hr>';
		$('#view').html(object_html_view);
		$('#views').html('');
		$('[name = "question"]').val("");
		$('[name = "question_keyword"]').val("");
	}
	$.fn.changeobjectsingular = function() {
		ve_idx = 1;
		var object_html = '<label>보기</label>' + '<input ve="' + (ve_idx)
				+ '"type="text" id="view" name="view' + (ve_idx) + '"/>'
				+ '<input ve="' + (ve_idx)
				+ '"type="button" class="btnviewremove" value="Remove"><hr>'
				+ '<input type = "hidden" name ="flag" value="singular">';
		$('#views').html(object_html);
		var object_html_view = '<input class="viewAdd" type="button" value="보기추가"><hr>';
		$('#view').html(object_html_view);
		$('[name = "question"]').val("");
		$('[name = "question_keyword"]').val("");
	}
	$.fn.changeobjectplural = function() {
		ve_idx = 1;
		var object_html = '<label>보기</label>' + '<input ve="' + (ve_idx)
				+ '"type="text" id="view" name="view' + (ve_idx) + '"/>'
				+ '<input ve="' + (ve_idx)
				+ '"type="button" class="btnviewremove" value="Remove"><hr>'
				+ '<input type = "hidden" name ="flag" value="plural">';
		$('#views').html(object_html);
		var object_html_view = '<input class="viewAdd" type="button" value="보기추가"><hr>';
		$('#view').html(object_html_view);
		$('[name = "question"]').val("");
		$('[name = "question_keyword"]').val("");
	}
	
	$.fn.changesubject = function() {//
		ve_idx = 98765;
		var subject_html = "<input type='hidden' name='flag' value='subject' ve='" + (ve_idx) + "'>";
		$('#views').html(subject_html);
		var subject_html_view = "<hr>";
		$('#view').html(subject_html_view);
		$('[name = "question"]').val("");
		$('[name = "question_keyword"]').val("");
	}
	$.fn.changesatisfaction = function() {//
		ve_idx = 98765;
		var satisfaction_html = "<input type='hidden' name='flag' value='satisfaction' ve='" + (ve_idx) + "'>";
		$('#views').html(satisfaction_html);
		var satisfaction_html_view = "<hr>";
		$('#view').html(satisfaction_html_view);
		$('[name = "question"]').val("");
		$('[name = "question_keyword"]').val("");
	}
	$.fn.changedescription = function() {//
		ve_idx = 98765;
		var description_html = "<input type='hidden' name='flag' value='description' ve='" + (ve_idx) + "'>";
		$('#views').html(description_html);
		var description_html_view = "<hr>";
		$('#view').html(description_html_view);
		$('[name = "question"]').val("");
		$('[name = "question_keyword"]').val("");
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
					var question_keyword =	$('[name = "question_keyword"]').val();

					var alldata = {
						"QUESTION_NUM" : ques_idx,
						"QUESTION_NAME" : question,
						"views" : views,
						"views_num" : views_num,
						"SURVEY_NAME" : survey_name,
						"SURVEY_SEQ" : survey_seq,
						"QUESTION_FLAG" : question_flag,
						"QUESTION_KEYWORD" : question_keyword
					};
					$.ajax({
						type : "POST",
						url : "<c:url value='/ws/survey_insert'/>",
						data : alldata,
						traditional : true,
						success : function(data) {
							var test = "";
							for (var i = 0; i < data.inputdata.length; i++) {
								test += '<p>보기' + (++i) + ') '
										+ data.inputdata[--i].VIEW_NAME
										+ '</p>'
							}
							$('#insert_check').append(
									'<div class = "form-group">' + '<p>질문 :'+ques_idx+')'
											+ data.QUESTION_NAME + ' </p>'
											+ test);
							$.fn.changeoriginal();
							$.fn.confirm(data);
						},

						error : function(xhr, status, exception) {
						}
					});
				});
	});
</script>
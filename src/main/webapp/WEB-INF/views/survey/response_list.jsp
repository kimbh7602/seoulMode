<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- page content -->
<div class="right_coll" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>
					Response List <small>질문에 대항 응답을 확인할 수 있고, 통계를 위한 객관식 응답을 입력할 수 있습니다.</small>
				</h3>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<form role="form" method="POST" action="<c:url value='/survey/response_enrollment' />">
				<input type="hidden" name="forwardView" value="/survey/response_list">
				<div class="x_panel">
					<div class="x_title">
						<h2>
							Response Board <small>설문, 질문을 선택한 후 객관식 응답을 입력해주세요.</small>
						</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<p class="text-muted font-13 m-b-30">객관식 응답을 입력 혹은 수정한 후, 저장버튼을 눌러주세요.</p>
						<hr>
						<label>설문을 선택해주세요.</label>
						<select class="form-control col-md-7 col-xs-12" id="survey_flag" name="SURVEY_SEQ">
							<option value="">Survey_Select</option>
							<c:forEach items="${resultList}" var="resultData" varStatus="loop">
								<option value="${resultData.SURVEY_SEQ}">${resultData.SURVEY_NAME}</option>
							</c:forEach>
						</select>
						<hr><hr>
						<label>질문을 선택해주세요.</label>
						<select class="form-control col-md-7 col-xs-12" id="question_flag" name="QUESTION_SEQ">
							<option value="">Question_Select</option>
						</select>
						<hr><hr>
						<button type="submit" class="btn btn-default">저장</button>
					</div>
				</div>
				<!-- 위에서 선택하고 밑은 데이터 -->
				<div class="x_panel" id ="response_Table">
					<table id="datatable" class="table table-striped table-bordered">
						<thead>
							<tr>
								<th>회원 이름</th>
								<th>회원 이메일</th>
								<th>주관식 응답</th>
								<th>객관식 응답</th>
							</tr>
						</thead>
						<tbody>
							<tr>
							</tr>
						</tbody>
					</table>
				</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- /page content -->
<script>
// 설문조사 고를때
$(document).on("change", "#survey_flag", function() {
	var survey_seq = $('#survey_flag option:selected').val();
	$.ajax({
		type:"POST",
		url:"<c:url value='/ws/check_response'/>",
		data: {"SURVEY_SEQ":survey_seq},
		traditional : true,
		success : function(data){
			if(data.CHECK == "same"){
				alert("해당 설문은 모든 수강생이 응답을 마쳤습니다.");
			}else{
				alert("해당 설문은 아직 응답하지 못한 수강생이 있습니다.");
			}
		},
		error:function(xhr,status,exception){
			
		}
	});
	
	
	$.ajax({
		type : "POST",
		url : "<c:url value='/ws/question_list'/>",
		data : {"SURVEY_SEQ" : survey_seq},
		traditional : true,
		success : function(data) {
		 	$("#question_flag").find("option").remove().end().append("<option value=''>Quetion_Select</option>");
			for(var i =0;i<data.length;i++){
				$("#question_flag").append("<option value='"+data[i].QUESTION_SEQ+"'>"+data[i].QUESTION_NAME+"</option>");
			}
		},

		error : function(xhr, status, exception) {
		}
	});
});

// 질문 고를때 
$(document).on("change", "#question_flag", function() {
	var question_seq = $('#question_flag option:selected').val();
	var survey_seq = $('#survey_flag option:selected').val();
	$.ajax({
		type : "POST",
		url : "<c:url value='/ws/response_list'/>",
		data : {"QUESTION_SEQ" : question_seq,"SURVEY_SEQ" : survey_seq},
		traditional : true,
		success : function(data) {
			console.log(data);
			var inputdata = "";
			for(var i=0;i<data.length;i++){
				inputdata += '<input type ="hidden" name ="MEMBER_SEQ" value="'+data[i].MEMBER_SEQ +'">';
			}
			$("#response_Table").html(inputdata);
			var table_data = '<table id="datatable" class="table table-striped table-bordered"> <thead> <tr>  <th>회원 이름</th>'
			+'<th>회원 이메일</th> <th>주관식 응답</th> <th>객관식 응답</th>'
			+'</tr> </thead> <tbody>';
			for(var i =0;i<data.length;i++){
				table_data += '<tr> <td>' + data[i].MEMBER_NAME + '</td>'
								+'<td>' + data[i].MEMBER_EMAIL + '</td>'
								+'<td>' + data[i].SUBJECTIVE_RESPONSE + '</td>'
								+'<td><input name="OBJECTIVE_RESPONSE" value="'+data[i].OBJECTIVE_RESPONSE+'"></td></tr>';
			}
			table_data +=	'</tr> </tbody> </table>';
			$("#response_Table").append(table_data);
		},

		error : function(xhr, status, exception) {
			console.log("xhr :" + xhr + "status : " + status + "exception :" + exception );
		}
	});
});

// 얼추 된거같은데 추가 기능으로는 무엇이 필요할까나 노트정리한거 보고 추가하도록 하자 f// 면접 준비해야하는거 알지?
</script>
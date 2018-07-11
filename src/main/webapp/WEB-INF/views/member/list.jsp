<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
var fn_setFormTagSelect = function(url, id, params){
	$.ajax({
		type : "POST", url : url, data : params, cache : false,
		success : function(data){
			var formTag = "";
			formTag += "<select class = 'form-control' name = 'ORGANIZATION_SEQ'>";
			$.each(data, function(i, item){
				formTag += '<option value = "'+item.ORGANIZATION_SEQ+'">' + item.NAME;
			});
			formTag +='</select>';
			$('#'+id).html(formTag);
			console.log(data);
		},
		error : function(xhr, status, exception){
			alert("Failure \n("+status+") \n("+exception+") \n("+xhr+")");
			return false;
		}
	});
}

$(function(){
	fn_setFormTagSelect("<c:url value = '/ws/organizationList'/>", "organizationDIV");
});


</script>


<!-- page content -->
        <div class="right_coll" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Users <small>Some examples to get you started</small></h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Notice Board <small>Users</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    
                    <select id="" name="COURSE_SEQ" required="required" class="form-control col-md-7 col-xs-12">
                          	<c:forEach items="${resultList}" var="resultData" varStatus="loop">
                          	
                          	
                          	</c:forEach>
                    </select>
                    
                    <table id="datatable" class="table table-striped table-bordered">
                      <thead>
                        <tr>
                        	<th></th>
                        	<th>NAME</th>
                        	<th>EMAIL</th>
                        	<th>COURSE NAME</th>
                        	<th>AUTHORITY NAME</th>
                        	<th colspan="2">UPDATE/DELETE</th>
                        </tr>
                      </thead>


                      	<tbody>
							<c:forEach items="${resultList}" var="resultData" varStatus="loop">
									<tr
										class="${(loop.index+1)%2 == 2 ? 'odd gradeX' : 'even gradeC'}">
										<td><input type="checkbox" class="checkbox"
											name="MEMBER_SEQ" value="${resultData.MEMBER_SEQ}" /></td>
										<td><a
											href="<c:url value="/member/read?MEMBER_SEQ=${resultData.MEMBER_SEQ}" />">
												${resultData.MEMBER_NAME}</a></td>
										<td>${resultData.MEMBER_EMAIL}</td>
										<td>${resultData.COURSE_NAME}</td>
										<td>${resultData.AUTHORITY_NAME}</td>
										<td><a
											href="<c:url value="/member/modify?MEMBER_SEQ=${resultData.MEMBER_SEQ}&forwardView=/member/modify" />">
												Update</a></td>
										<td><a
											href="<c:url value="/member/delete?MEMBER_SEQ=${resultData.MEMBER_SEQ}&forwardView=/member/list" />">
												Delete</a></td>
									</tr>
							</c:forEach>
						</tbody>
                    </table>
                  </div>
                </div>
              </div>
          </div>
        </div>
        <!-- /page content -->
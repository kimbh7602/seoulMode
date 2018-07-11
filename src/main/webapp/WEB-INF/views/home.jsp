<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


        <!-- page content -->
        <div class="right_coll" role="main" >
        <c:choose>
        	<c:when test="${resultMap.auth=='ROLE_ANONYMOUS'}">
	            <div class="col-sm-12 col-xs-12">
                  <div class="x_panel">
                    <div class="x_title">
                      <h2>설문조사 페이지입니다. </h2>
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                    </div>
                    </div>
	            </div>
        	</c:when>
        	<c:otherwise>
	          <!-- top tiles -->
	          <div class="row tile_count">
	            <div class="col-md-4 col-sm-4 col-xs-12 tile_stats_count">
	              <span class="count_top"></span><br>
	              <div class="count">Survey Name</div>
	              <span class="count_bottom"><i class="green"> </i> </span>
	            </div>
	            <div class="col-md-4 col-sm-4 col-xs-6 tile_stats_count">
	              <span class="count_top"><i class="fa fa-user"></i> í ë</span>
	              <div class="count">3</div>
	              <span class="count_bottom"><i class="green">4% </i> Survey Name</span>
	            </div>
	            <div class="col-md-4 col-sm-4 col-xs-6 tile_stats_count">
	              <span class="count_top"><i class="fa fa-user"></i> ì í ë</span>
	              <div class="count">12</div>
	              <span class="count_bottom"><i class="green">34% </i> Survey Name</span>
	            </div>
	          </div>
	          <!-- /top tiles -->
	            <div class="col-md-12 col-sm-12 col-xs-12">
	                <!-- Start to do list -->
	                  <div class="x_panel">
	                    <div class="x_title">
	                      <h2>진행중인 설문조사 </h2>
	                      <div class="clearfix"></div>
	                    </div>
	                    <div class="x_content">
	                      <div class="">
	                        <ul class="to_do">
	                        <c:forEach items="${resultList}" var="resultData" varStatus="loop">
	                        	<li>
			                        	<a href="<c:url value='/survey/read?SURVEY_NAME=${resultData.SURVEY_NAME}'/>">${resultData.SURVEY_NAME}</a>
	                        	</li>
	                        </c:forEach>
	                        </ul>
	                      </div>
	                    </div>
	                </div>
	              </div>
        	</c:otherwise>
        </c:choose>
          </div>
          </div>
        <!-- /page content -->
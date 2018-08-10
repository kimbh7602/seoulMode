<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="principalName" value="${pageContext.request.userPrincipal.name}"/>
		<div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="<c:url value='/home'/>" class="site_title"><i class="fa fa-paw"></i> <span>Seoul Mode</span></a>
            </div>
            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
              </div>
              <div class="profile_info">
				<c:choose>
		      		<c:when test="${principalName eq null}">
		      		</c:when>
		      		<c:otherwise>
		      		       <span>Welcome,</span>
						<h2><a href="<c:url value='#'/>">${principalName}</a></h2>
					</c:otherwise>
		      	</c:choose>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
                  <li><a  href="<c:url value ='/home'/>"><i class="fa fa-home"></i> Home <span class="fa"></span></a>
                    <ul class="nav child_menu">
                    </ul>
                  </li>
					<c:choose>
		      		<c:when test="${principalName eq null}">
		      			
		      		</c:when>
			      		<c:otherwise>
		                  <li><a href="<c:url value='/survey/list'/>"><i class="fa fa-table"></i> Survey </a></li>
						</c:otherwise>
		      		</c:choose>
                </ul>
              </div>
             <c:choose>
		      		<c:when test="${resultMap.auth eq 'ROLE_ADMIN'}">
			              <div class="menu_section">
                            <h3>관리자 화면</h3>
			                <ul class="nav side-menu">
			                  <li><a><i class="fa fa-desktop"></i> 설문조사 <span class="fa fa-chevron-down"></span></a>
			                    <ul class="nav child_menu">
			                      <li><a href="<c:url value ='/survey/list'/>">List</a></li>
			                      <li><a href="<c:url value ='/survey/insert'/>">Insert</a></li>
			                      <li><a href="<c:url value ='/survey/response_list'/>">Response</a></li>
			                    </ul>
			                  </li>
			                  <li><a><i class="fa fa-desktop"></i> 회원관리 <span class="fa fa-chevron-down"></span></a>
			                    <ul class="nav child_menu">
			                      <li><a href="<c:url value ='/member/list'/>">List</a></li>
			                    </ul>
			                  </li>
			                  <li><a><i class="fa fa-bar-chart-o"></i> 통계관리 <span class="fa fa-chevron-down"></span></a>
			                    <ul class="nav child_menu">
			                      <li><a href="<c:url value ='/analystics/read'/>">Analystics</a></li>
			                    </ul>
			                  </li>
			                </ul>
			              </div>
		      		</c:when>
		      		<c:otherwise>
					</c:otherwise>
		      	</c:choose>

            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
					<i class="fa fa-envelope-o"></i>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
					<i class="fa fa-envelope-o"></i>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
					<i class="fa fa-envelope-o"></i>
              
              </a>
				<c:choose>
		        	<c:when test="${principalName eq null}">
				      <a data-toggle="tooltip" data-placement="top" title="Login" href="<c:url value='/login/LoginForm'/>">
						<i class="fa fa-envelope-o"></i>
				      </a>
		        	</c:when>
		        	<c:otherwise>
						<a data-toggle="tooltip" data-placement="top" title="Logout" href="<c:url value='/j_spring_security_logout'/>">
						<i class="fa fa-envelope-o"></i>
						</a>
					</c:otherwise>
				</c:choose>

            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>
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
                            <!-- 권한에 따라서 띄워주게끔, Admin 이면 뜨게 -->
              <c:choose>
		      		<c:when test="${resultMap.auth eq ROLE_ADMIN}">
			              <div class="menu_section">
			                <h3>관리자 화면</h3>
			                <ul class="nav side-menu">
			                  <li><a><i class="fa fa-desktop"></i> 설문조사 <span class="fa fa-chevron-down"></span></a>
			                    <ul class="nav child_menu">
			                      <li><a href="<c:url value ='/survey/list'/>">List</a></li>
			                      <li><a href="<c:url value ='/survey/insert'/>">Insert</a></li>
			                    </ul>
			                  </li>
			                  <li><a><i class="fa fa-bar-chart-o"></i> Statistic <span class="fa fa-chevron-down"></span></a>
			                    <ul class="nav child_menu">
			                      <li><a href="page_403.html">403 Error</a></li>
			                      <li><a href="page_404.html">404 Error</a></li>
			                      <li><a href="page_500.html">500 Error</a></li>
			                      <li><a href="plain_page.html">Plain Page</a></li>
			                      <li><a href="login.html">Login Page</a></li>
			                      <li><a href="pricing_tables.html">Pricing Tables</a></li>
			                    </ul>
			                  </li>
			<!--                   <li><a><i class="fa fa-sitemap"></i> Multilevel Menu <span class="fa fa-chevron-down"></span></a>
			                    <ul class="nav child_menu">
			                        <li><a href="#level1_1">Level One</a>
			                        <li><a>Level One<span class="fa fa-chevron-down"></span></a>
			                          <ul class="nav child_menu">
			                            <li class="sub_menu"><a href="level2.html">Level Two</a>
			                            </li>
			                            <li><a href="#level2_1">Level Two</a>
			                            </li>
			                            <li><a href="#level2_2">Level Two</a>
			                            </li>
			                          </ul>
			                        </li>
			                        <li><a href="#level1_2">Level One</a>
			                        </li>
			                    </ul>
			                  </li>                  
			                  <li><a href="javascript:void(0)"><i class="fa fa-laptop"></i> Landing Page <span class="label label-success pull-right">Coming Soon</span></a>
			                  </li> -->
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="principalName" value="${pageContext.request.userPrincipal.name}"/>
<!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>
              <ul class="nav navbar-nav navbar-right">
                <li class="">
				<c:choose>
		        	<c:when test="${principalName eq null}">
		        <li>
				<a href="<c:url value='/login/loginform#signup'/>">
					Sign Up
				</a>
				</li>
				<li>
				<a href="<c:url value='/login/loginform#signin'/>" >
					Login
				</a>
				</li>
		        	</c:when>
		        	<c:otherwise>
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                   <!--  <img src="images/img.jpg" alt=""> -->${principalName}
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a href="<c:url value='/j_spring_security_logout'/>"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
					</c:otherwise>
				</c:choose>
                </li>
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->


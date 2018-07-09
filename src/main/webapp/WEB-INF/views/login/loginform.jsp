<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
			<form class="form-horizontal" role="form" action="<c:url value ='/j_spring_security_check'/>" method="POST">
              <h1>Login Form</h1>
				<c:if test="${paramMap.fail eq true}">
					<span style="color:red">아이디와 비밀번호를 확인하세요.</span>
				</c:if>
              <div>
                <input type="text" class="form-control" placeholder="Email" name="Email" required="" />
              </div>
              <div>
                <input type="password" class="form-control" placeholder="Password" name="Password" required="" />
              </div>
              <div>
				<button class="btn btn-default submit" type="submit">로그인</button>
                <a class="reset_pass" href="#">Lost your password?</a>
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">New to site?
                  <a href="#signup" class="to_register"> Create Account </a>
                </p>
                <p class="change_lick">
                	<a href="<c:url value='/home'/>">홈으로</a>
                </p>
                <div class="clearfix"></div>
                <br />
              </div>
            </form>
          </section>
        </div>

        <div id="register" class="animate form registration_form">
          <section class="login_content">
      <form class="form-horizontal" role="form" action = "<c:url value ='/signUp/insert'/>" method="POST">
              <h1>Create Account</h1>
              <div>
                <input type="text" class="form-control" placeholder="Username" required="" />
              </div>
              <div>
                <input type="email" class="form-control" placeholder="Email" required="" />
              </div>
              <div>
                <input type="password" class="form-control" placeholder="Password" required="" />
              </div>
              <div>
                <a class="btn btn-default submit" href="index.html">Submit</a>
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">Already a member ?
                  <a href="#signin" class="to_register"> Log in </a>
                </p>
                <p class="change_lick">
                	<a href="<c:url value='/home'/>">홈으로</a>
                </p>
                <div class="clearfix"></div>
                <br />
              </div>
            </form>
          </section>
        </div>
      </div>
    </div>

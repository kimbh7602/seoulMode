<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div>
	<a class="hiddenanchor" id="signup"></a> <a class="hiddenanchor"
		id="signin"></a>

	<div class="login_wrapper">
		<div class="animate form login_form">
			<section class="login_content">
				<form class="form-horizontal" role="form"
					action="<c:url value ='/j_spring_security_check'/>" method="POST">
					<h1>Login Form</h1>
					<c:if test="${paramMap.fail eq true}">
						<span style="color: red">ìì´ëì ë¹ë°ë²í¸ë¥¼
							íì¸íì¸ì.</span>
					</c:if>
					<div>
						<input type="text" class="form-control" placeholder="Email"
							name="MEMBER_EMAIL" required="" />
					</div>
					<div>
						<input type="password" class="form-control" placeholder="Password"
							name="MEMBER_PASSWORD" required="" />
					</div>
					<div>
						<button class="btn btn-default submit" type="submit">SUBMIT</button>
						<a class="reset_pass" href="#">Lost your password?</a>
					</div>

					<div class="clearfix"></div>

					<div class="separator">
						<p class="change_link">
							New to site? <a href="#signup" class="to_register"> Create
								Account </a>
						</p>
						<p class="change_lick">
							<a href="<c:url value='/home'/>">홈으로</a>
						</p>
						<div class="clearfix">
						<p>ROLE_ADMIN : ID = a123@naver.com , PW = 12345</p>
						<p>ROLE_USER : ID = f123@naver.com , PW = 12345</p>
						</div>
						<br />
					</div>
				</form>
			</section>
		</div>

		<div id="register" class="animate form registration_form">
			<section class="login_content">
				<form class="form-horizontal" role="form"
					action="<c:url value ='/member/insert'/>" method="POST">
					<h1>Create Account</h1>
					<div>
						<input type="hidden" name="forwardView"
							value="/login/loginform#signin" /> <input type="text"
							class="form-control" placeholder="Username" name="MEMBER_NAME"
							required="" />
					</div>
					<div>
						<input type="email" class="form-control" placeholder="Email"
							name="MEMBER_EMAIL" required="" />
					</div>
					<div>
						<input type="password" class="form-control" placeholder="Password"
							name="MEMBER_PASSWORD" required="" />
					</div>
					<div class="form-group">
						<label class="control-label col-md-3 col-sm-3 col-xs-12"
							for="last-name">COURSE <span class="required"></span>
						</label>
						<div class="col-md-9 col-sm-9 col-xs-12">
							<select id="" name="COURSE_SEQ" required="required"
								class="form-control col-md-7 col-xs-12">
								<c:forEach items="${resultList}" var="resultData"
									varStatus="loop">
									<option value="${resultData.COURSE_SEQ }">${resultData.COURSE_NAME }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div>
						<button class="btn btn-default submit">Submit</button>
					</div>

					<div class="clearfix"></div>

					<div class="separator">
						<p class="change_link">
							Already a member ? <a href="#signin" class="to_register"> Log
								in </a>
						</p>
						<p class="change_lick">
							<a href="<c:url value='/home'/>">íì¼ë¡</a>
						</p>
						<div class="clearfix"></div>
						<br />
					</div>
				</form>
			</section>
		</div>
	</div>
</div>

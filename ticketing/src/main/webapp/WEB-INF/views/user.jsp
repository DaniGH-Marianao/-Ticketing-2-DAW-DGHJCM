<%@ page
	contentType="text/html"
	pageEncoding="UTF-8"
%>

<%@ taglib
	prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"
%>
<%@ taglib
	prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib
	prefix="fn"
	uri="http://java.sun.com/jsp/jstl/functions"
%>

<%@ taglib
	prefix="spring"
	uri="http://www.springframework.org/tags"
%>
<%@ taglib
	prefix="form"
	uri="http://www.springframework.org/tags/form"
%>
<%@ taglib
	prefix="sec"
	uri="http://www.springframework.org/security/tags"
%>
<!DOCTYPE html>
<html lang="EN">
<head>
<jsp:include page="sections/head.jsp" />
<c:url
	value="/resources/js/user.js"
	var="userJs"
/>
<script
	type="text/javascript"
	src="${userJs}"
>
	
</script>
</head>
<body onload="roleFields()">
	<section class="container">
		<jsp:include page="sections/header.jsp" />
		<h3>
			<spring:message code="user.data" />
		</h3>
		<hr />
		<div class="panel-body">
			<div class="col-md-12">

				<form:form
					modelAttribute="userForm"
					cssClass="form-horizontal"
					var="MAX_EXTENSION"
				>
					<div class="form-group">
						<div class="row">
							<div class="col-sm-6">
								<form:label
									for="role"
									path="role"
									cssClass="col-sm-1 control-label"
								>
									<spring:message code="user.role" />
								</form:label>
								<div class="col-sm-11">
									<form:select
										id="role"
										path="role"
										cssClass="form-control"
										cssErrorClass="form-control form-control-error"
									>
										<c:forEach
											var="role"
											items="${roles}"
										>
											<option
												value="${role}"
												${usersFilter.role==role?'selected="selected"':''}
											><spring:message code="user.role.${role}" /></option>
										</c:forEach>
									</form:select>
								</div>
							</div>
							<div class="col-sm-6">
								<form:label
									for="extension"
									path="extension"
									cssClass="col-sm-2 control-label py-2"
								>
									<spring:message code="user.extension" />
								</form:label>
								<div class="col-sm-10">
									<spring:message
										code="user.extension.placeholder"
										var="extensionPlaceholder"
									/>
									<form:input
										type="number"
										cssClass="form-control text-right"
										path="extension"
										placeholder="${extensionPlaceholder }"
										min="1"
										max="${MAX_EXTENSION}"
									/>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-sm-12">
								<form:label
									for="username"
									path="username"
									cssClass="col-sm-1 control-label"
								>
									<spring:message code="user.username" />
								</form:label>
								<div class="col-sm-11">
									<form:input
										type="text"
										cssClass="form-control"
										path="username"
										maxlength="20"
									/>
								</div>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="row">
							<div class="col-sm-6">
								<form:label
									for="password"
									path="password"
									cssClass="col-sm-2 control-label"
								>
									<spring:message code="user.password" />
								</form:label>
								<div class="col-sm-10">
									<form:input
										type="password"
										cssClass="form-control"
										path="password"
									/>
								</div>
							</div>
							<div class="col-sm-6">
								<form:label
									for="verify"
									path="verify"
									cssClass="col-sm-2 control-label py-2"
								>
									<spring:message code="user.verify" />
								</form:label>
								<div class="col-sm-10">
									<form:input
										type="password"
										cssClass="form-control"
										path="verify"
									/>
								</div>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="row">
							<div class="col-sm-12">
								<form:label
									for="fullName"
									path="fullName"
									cssClass="col-sm-1 control-label"
								>
									<spring:message code="user.fullName" />
								</form:label>
								<div class="col-sm-11">
									<form:input
										type="text"
										cssClass="form-control"
										path="fullName"
									/>
								</div>
							</div>
						</div>
					</div>


				</form:form>
			</div>
		</div>

	</section>
</body>
</html>
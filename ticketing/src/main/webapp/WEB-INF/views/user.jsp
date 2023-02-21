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
		<div class="col-md-12">
			<form:form
				method="POST"
				modelAttribute="userForm"
				var="MAX_EXTENSION"
			>
				<fieldset>
					<c:if test="${formErrors.hasErrors()}">
						<div class="alert alert-danger alert-dismissible">
							<button
								type="button"
								class="close"
								data-dismiss="alert"
								aria-label="Close"
							>
								<span aria-hidden="true">&times;</span>
							</button>
							<form:errors
								path="*"
								cssClass="text-center"
								htmlEscape="false"
							/>
						</div>
					</c:if>
					<div class="form-group">
						<div class="row">
							<div class="col-md-6">
								<form:label
									for="role"
									path="role"
									cssClass="control-label"
									cssErrorClass="control-label control-label-error"
								>
									<spring:message code="user.role" />
								</form:label>
								<c:choose>
									<c:when test="${edit}">
										<form:input
											path="role"
											cssClass="form-control"
											cssErrorClass="form-control form-control-error "
											readonly="true"
										/>
									</c:when>
									<c:otherwise>
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
													${userForm.role==role?'selected="selected"':''}
												><spring:message code="user.role.${role}" /></option>
											</c:forEach>
										</form:select>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="col-md-6">
								<spring:message
									code="user.extension.placeholder"
									var="extPh"
								/>
								<form:label
									for="extension"
									path="extension"
									cssClass="control-label"
									cssErrorClass="control-label control-label-error"
								>
									<spring:message code="user.extension" />
								</form:label>
								<form:input
									type="number"
									path="extension"
									cssClass="form-control text-right"
									cssErrorClass="form-control form-control-error text-right"
									min="1"
									max="${MAX_EXTENSION }"
									placeholder="${extPh }"
								/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<spring:message
							code="user.username.placeholder"
							var="usernamePh"
						/>
						<form:label
							for="username"
							path="username"
							cssClass="control-label"
							cssErrorClass="control-label control-label-error"
						>
							<spring:message code="user.username" />
						</form:label>
						<form:input
							path="username"
							cssClass="form-control"
							cssErrorClass="form-control form-control-error "
							placeholder="${usernamePh }"
							readonly="${edit ?  true : false }"
						/>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-6">
								<spring:message
									code="user.password.placeholder"
									var="passPh"
								/>
								<form:label
									for="password"
									path="password"
									cssClass="control-label"
									cssErrorClass="control-label control-label-error"
								>
									<spring:message code="user.password" />
								</form:label>
								<form:password
									path="password"
									cssClass="form-control"
									cssErrorClass="form-control form-control-error "
									placeholder="${passPh }"
								/>
							</div>
							<div class="col-md-6">
								<spring:message
									code="user.verify.placeholder"
									var="passVerifyPh"
								/>
								<form:label
									for="verify"
									path="verify"
									cssClass="control-label"
									cssErrorClass="control-label control-label-error"
								>
									<spring:message code="user.verify" />
								</form:label>
								<form:password
									path="verify"
									cssClass="form-control"
									cssErrorClass="form-control form-control-error "
									placeholder="${passVerifyPh }"
								/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<spring:message
							code="user.fullName.placeholder"
							var="fullNamePh"
						/>
						<form:label
							for="fullName"
							path="fullName"
							cssClass="control-label"
							cssErrorClass="control-label control-label-error"
						>
							<spring:message code="user.fullName" />
						</form:label>
						<form:input
							path="fullName"
							cssClass="form-control"
							cssErrorClass="form-control form-control-error "
							placeholder="${fullNamePh }"
						/>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-6">
								<form:label
									for="roomId"
									path="roomId"
									cssClass="control-label"
									cssErrorClass="control-label control-label-error"
								>
									<spring:message code="user.room" />
								</form:label>
								<form:select
									id="roomId"
									path="roomId"
									cssClass="form-control"
									cssErrorClass="form-control form-control-error"
								>
									<c:forEach
										var="room"
										items="${rooms}"
									>
										<option value="${room.id}">${room.name}</option>
									</c:forEach>
								</form:select>
							</div>
							<div class="col-md-6">
								<spring:message
									code="user.place.placeholder"
									var="placePh"
								/>
								<form:label
									for="place"
									path="place"
									cssClass="control-label"
									cssErrorClass="control-label control-label-error"
								>
									<spring:message code="user.place" />
								</form:label>
								<form:input
									id="place"
									path="place"
									cssClass="form-control"
									cssErrorClass="form-control form-control-error "
									placeholder="${placePh }"
								/>
							</div>
						</div>
					</div>
					<button
						type="submit"
						class="btn btn-primary"
					>
						<spring:message code="user.${edit ?  'update' : 'add.new' }" />
					</button>
				</fieldset>
			</form:form>
		</div>
	</section>
</body>
</html>
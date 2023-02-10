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
</head>
<body>
	<section class="container">
		<jsp:include page="sections/header.jsp" />

		<div class="panel-body">
			<div class="col-md-6">
				<form:form
					modelAttribute="ticket"
					cssClass="form-horizontal"
				>
					<fieldset>

						<div class="form-group">
							<form:label
								for="performer"
								path="performer"
								cssClass="col-sm-3 control-label py-2"
							>
								<spring:message code="ticket.employee" />
							</form:label>
							<div class="col-sm-8">
								<form:input
									path="performer"
									cssClass="form-control"
									cssErrorClass="form-control form-control-error"
									readonly="true"
								/>
							</div>
						</div>
						<div class="form-group">
							<form:label
								for="category"
								path="category"
								cssClass="col-sm-3 control-label"
							>
								<spring:message code="ticket.category" />
							</form:label>
							<div class="col-sm-8">
								<form:select
									path="category"
									items="${sessionScope.categories}"
									cssClass="form-control"
									cssErrorClass="form-control form-control-error"
								/>
							</div>
						</div>

						<div class="form-group">
							<form:label
								for="description"
								path="description"
								cssClass="col-sm-3 control-label"
							>
								<spring:message code="ticket.description" />
							</form:label>
							<div class="col-sm-8">
								<form:textarea
									path="description"
									cssClass="form-control"
									cssErrorClass="form-control form-control-error"
									rows="5"
								/>
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-8 text-right">
								<button class="btn btn-info">
									<span class="glyphicon glyphicon-ok">   </span>
									<spring:message code="ticket.add.new" />

								</button>
							</div>
						</div>
					</fieldset>
				</form:form>

			</div>
		</div>

	</section>
</body>
</html>
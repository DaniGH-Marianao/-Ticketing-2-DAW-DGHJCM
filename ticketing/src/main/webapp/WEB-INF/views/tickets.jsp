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
<script>
	var csrfParameterName = "${_csrf.parameterName}";
	var csrfToken = "${_csrf.token}";

	var hardwareMsg = "<spring:message code="ticket.category.HARDWARE" />";
	var softwareMsg = "<spring:message code="ticket.category.SOFTWARE" />";
	var printerMsg = "<spring:message code="ticket.category.PRINTER" />";
	var networkMsg = "<spring:message code="ticket.category.NETWORK" />";
	var supportMsg = "<spring:message code="ticket.category.SUPPORT" />";
	var othersMsg = "<spring:message code="ticket.category.OTHERS" />";

	var filterStatus = "${ticketsFilter.status}";
	var ajaxUrl = "<c:url value="/tickets/ajax/list"/>";
</script>
<c:url
	value="/resources/js/ticketsFilter.js"
	var="ticketsFilter"
/>
<script
	type="text/javascript"
	src="${ticketsFilter}"
>
	
</script>
<c:url
	value="/resources/js/tickets.js"
	var="ticketsJs"
/>
<script
	type="text/javascript"
	src="${ticketsJs}"
>
</script>
</head>
<body>
	<section class="container">
		<jsp:include page="sections/header.jsp" />

		<jsp:include page="sections/tickets-filter.jsp" />


		<table
			id="ticketTable"
			class="table table-striped table-bordered table-condensed table-responsive"
		>
			<thead>
				<tr>
					<th><spring:message code="tickets.table.head.num" /></th>
					<th><spring:message code="tickets.table.head.opening" /></th>
					<th><spring:message code="tickets.table.head.employee" /></th>
					<th><spring:message code="tickets.table.head.category" /></th>
					<th><spring:message code="tickets.table.head.description" /></th>
					<th />
					<th />
				</tr>
			</thead>
			<tbody>
				<c:forEach
					var="ticket"
					items="${ticketsList}"
					varStatus="status"
				>
					<tr>
						<td>${status.index+1}</td>
						<td><fmt:formatDate
								pattern="dd-MM-yyyy hh:mm:ss"
								value="${ticket.openingDate }"
							/></td>
						<td>${ticket.performer}</td>
						<td><spring:message code="ticket.category.${ticket.category}" /></td>
						<td>${ticket.description}</td>

						<td class="text-center">
							<button
								type="button"
								class="btn btn-info btn-sm"
								data-toggle="modal"
								data-target="#confirm"
								data-backdrop="true"
								onclick="prepareAssignTicketDialog('${ticket.id}')"
							>
								<span class="glyphicon glyphicon-hand-right"> </span>
							</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	</section>


	<!-- Assign Modal -->
	<div
		id="confirm"
		class="modal fade"
		role="dialog"
	>
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div
					class="modal-header"
					style="padding: 35px 50px;"
				>
					<button
						type="button"
						class="close"
						data-dismiss="modal"
					>&times;</button>
					<h4 class="modal-title">
						<spring:message code="tickets.assign.title" />
					</h4>
				</div>
				<div
					class="modal-body"
					style="padding: 40px 50px;"
				>
					<form:form
						modelAttribute="assign"
						cssClass="form-horizontal"
					>
						<fieldset>

							<div class="form-group">
								<form:label
									for="technician"
									path="technician"
									cssClass="col-sm-3 control-label py-2"
								>
									<spring:message code="tickets.assign.technician" />
								</form:label>
								<div class="col-sm-8">
									<form:select
										path="technician"
										items="${technicianList}"
										cssClass="form-control"
										cssErrorClass="form-control form-control-error"
									/>
								</div>
							</div>

							<div class="form-group">
								<form:label
									for="priority"
									path="priority"
									cssClass="col-sm-3 control-label py-2"
								>
									<spring:message code="tickets.assign.priority" />
								</form:label>
								<div class="col-sm-8">
									<input
										type="number"
										class="form-control"
										value="1"
										min="1"
										max="9"
									/>
								</div>
							</div>


						</fieldset>
					</form:form>
				</div>
				<div class="modal-footer">
					<a
						id="assignHref"
						class="btn btn-success"
						href="/ticketing/tickets/assign"
					> <span class="glyphicon glyphicon-ok"> </span> <spring:message
							code="tickets.assign.button"
						/>
					</a>
					<button
						type="button"
						class="btn btn-default"
						data-dismiss="modal"
					>
						<spring:message code="tickets.assign.cancel.button" />
					</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
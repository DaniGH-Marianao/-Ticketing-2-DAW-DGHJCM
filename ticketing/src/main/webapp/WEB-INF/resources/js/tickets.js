function changeTicketId(ticketId) {
	document.getElementById("ticketId").value = ticketId;
	
}

function prepareAssignTicketDialog(ticketId) {
	changeTicketId(ticketId);
}

function prepareInterventionTicketDialog(ticketId) {
	changeTicketId(ticketId);
}

function prepareCloseTicketDialog(ticketId, openingDate, performer, category, description, ticketStatus) {
    const closeDialogMsg = document.getElementById("closeDialogMsg").innerHTML;
	document.getElementById("closeDialogMessage").innerHTML = closeDialogMsg.replace('{0}', openingDate)
		.replace('{1}', performer).replace('{2}', category).replace('{3}', description);
	document.getElementById("ticketStatus").value = ticketStatus;
	document.getElementById("ticketIdClose").value = ticketId;
	
}
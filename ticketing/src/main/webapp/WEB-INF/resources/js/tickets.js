function changeTicketId(ticketId) {
	document.getElementById("ticketId").value = ticketId;	
}

function getTicketId() {
	return document.getElementById("ticketId").value;	
}


function prepareAssignTicketDialog(ticketId, technicianList) {
	changeTicketId(ticketId);
}

function prepareInterventionTicketDialog(ticketId) {
	changeTicketId(ticketId);
}

function prepareCloseTicketDialog(ticketId, openingDate, performer, category, description, ticketStatus) {
    const closeDialogMsg = document.getElementById("closeDialogMsg").innerHTML;
    console.log(closeDialogMsg)
	document.getElementById("closeDialogMessage").innerHTML = closeDialogMsg.replace('{0}', openingDate)
		.replace('{1}', performer).replace('{2}', category).replace('{3}', description);
	document.getElementById("ticketStatus").value = ticketStatus;
	document.getElementById("ticketIdClose").value = ticketId;
}
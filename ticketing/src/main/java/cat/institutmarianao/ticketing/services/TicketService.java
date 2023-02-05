package cat.institutmarianao.ticketing.services;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;

import cat.institutmarianao.ticketing.model.dto.ActionDto;
import cat.institutmarianao.ticketing.model.dto.AssignmentDto;
import cat.institutmarianao.ticketing.model.dto.EmployeeDto;
import cat.institutmarianao.ticketing.model.dto.InterventionDto;
import cat.institutmarianao.ticketing.model.dto.TechnicianDto;
import cat.institutmarianao.ticketing.model.dto.TicketDto;
import cat.institutmarianao.ticketing.model.dto.UserDto;
import cat.institutmarianao.ticketing.model.forms.TicketsFilter;
import cat.institutmarianao.ticketing.model.forms.UsersFilter;

public interface TicketService {

	List<TicketDto> getAllTickets();

	List<TicketDto> filterTickets(TicketsFilter filter);

	TicketDto add(TicketDto ticketDto);

	void update(TicketDto ticketDto);

	void remove(Long ticketId);

	TicketDto getTicketById(Long ticketId);

	void assign(Long ticketId, AssignmentDto assignmentDto);

	void intervention(Long ticketId, InterventionDto interventionDto);

	void close(Long ticketId);
}

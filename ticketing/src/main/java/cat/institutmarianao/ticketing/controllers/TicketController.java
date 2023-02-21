package cat.institutmarianao.ticketing.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import cat.institutmarianao.ticketing.model.dto.AssignmentDto;
import cat.institutmarianao.ticketing.model.dto.CloseDto;
import cat.institutmarianao.ticketing.model.dto.InterventionDto;
import cat.institutmarianao.ticketing.model.dto.TicketDto;
import cat.institutmarianao.ticketing.model.dto.TicketDto.Category;
import cat.institutmarianao.ticketing.model.dto.TicketDto.Status;
import cat.institutmarianao.ticketing.model.dto.UserDto.Role;
import cat.institutmarianao.ticketing.model.dto.UserDto;
import cat.institutmarianao.ticketing.model.forms.TicketsFilter;
import cat.institutmarianao.ticketing.model.forms.UsersFilter;
import cat.institutmarianao.ticketing.services.TicketService;
import cat.institutmarianao.ticketing.services.UserService;

@Controller
@SessionAttributes({ "user", "categories" })
@RequestMapping(value = "/tickets")
public class TicketController {

	@Autowired
	private UserService userService;
	@Autowired
	private TicketService ticketService;

	@ModelAttribute("user")
	public UserDto setupUser() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		return (UserDto) userService.loadUserByUsername(username);
	}

	@ModelAttribute("categories")
	public Category[] setupCategories() {
		return TicketDto.Category.values();
	}

	@InitBinder
	public void dataBinding(WebDataBinder binder) {
		DateFormatter dateFormatter = new DateFormatter();
		dateFormatter.setPattern("yyyy-MM-dd'T'HH:mm");
		binder.addCustomFormatter(dateFormatter, "date");
		binder.setDisallowedFields("ticket");
	}

	@GetMapping("/new")
	public ModelAndView newTicket(@ModelAttribute("user") UserDto userDto) {
		ModelAndView newTicketsView = new ModelAndView("ticket");
		TicketDto ticketDto = new TicketDto();
		ticketDto.setPerformer(userDto.getUsername());
		newTicketsView.getModelMap().addAttribute("pageTitle", "ticket.new.title");
		newTicketsView.getModelMap().addAttribute("ticket", ticketDto);
		return newTicketsView;
	}

	@PostMapping("/new")
	public String submitNewTicket(@Validated @ModelAttribute("ticket") TicketDto ticketDto, BindingResult result,
			ModelMap modelMap) {

		if (result.hasErrors()) {
			modelMap.addAttribute("pageTitle", "ticket.new.title");
			modelMap.addAttribute("ticket", ticketDto);
			return "ticket";
		}

		ticketService.add(ticketDto);
		return "redirect:/tickets/list/PENDING";
	}

	@GetMapping("/list/{ticket-status}")
	public ModelAndView allTicketsList(@ModelAttribute("user") UserDto userDto,
			@PathVariable("ticket-status") Status ticketStatus) {
		ModelAndView ticketsView = new ModelAndView("tickets");
		TicketsFilter ticketFilter = new TicketsFilter();
		AssignmentDto assignmentDto = new AssignmentDto();
		ticketFilter.setStatus(ticketStatus);

		if (userDto.getRole() == Role.EMPLOYEE)
			ticketFilter.setPerformer(userDto.getUsername());

		assignmentDto.setPriority(1);
		assignmentDto.setPerformer(userDto.getUsername());
		ticketsView.getModelMap().addAttribute("pageTitle", "tickets.list." + ticketStatus.name() + ".title");
		ticketsView.getModelMap().addAttribute("ticketsFilter", ticketFilter);
		ticketsView.getModelMap().addAttribute("ticketsList", ticketService.filterTickets(ticketFilter));
		ticketsView.getModelMap().addAttribute("employeeList", userService.getAllEmployees());
		ticketsView.getModelMap().addAttribute("technicianList", userService.getAllTechnicians());
		ticketsView.getModelMap().addAttribute("assignment", assignmentDto);
		return ticketsView;
	}

	@PostMapping("/ajax/list")
	@ResponseBody
	public List<TicketDto> filterTicketList(@RequestBody TicketsFilter filter) {
		return ticketService.filterTickets(filter);
	}

	@PostMapping("/assign")
	public String assignTicket(@ModelAttribute("assignment") AssignmentDto assignmentDto) {
		ticketService.assign(assignmentDto);
		return "redirect:/tickets/list/PENDING";
	}

	@PostMapping("/intervention")
	public String interventionTicket(@ModelAttribute("intervention") InterventionDto interventionDto) {
		ticketService.intervention(interventionDto);
		return "redirect:/tickets/list/IN_PROCESS";
	}

	@GetMapping("/close")
	public String closeTicket(@RequestParam("ticketId") Long ticketId,
			@RequestParam("ticketStatus") Status ticketStatus) {
		ticketService.close(ticketId, ticketStatus);
		return "redirect:/tickets/list/CLOSED";
	}
}

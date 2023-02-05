package cat.institutmarianao.ticketing.services.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import cat.institutmarianao.ticketing.model.dto.AssignmentDto;
import cat.institutmarianao.ticketing.model.dto.InterventionDto;
import cat.institutmarianao.ticketing.model.dto.TicketDto;
import cat.institutmarianao.ticketing.model.forms.TicketsFilter;
import cat.institutmarianao.ticketing.services.TicketService;

@Service
public class TicketServiceImpl implements TicketService {
	private static final String HOST = "https://localhost";
	private static final String PORT = "8443";

	@Autowired
	private RestTemplate restTemplate;

	@Override
	public TicketDto getTicketById(Long id) {
		final String baseUri = HOST + ":" + PORT + "/tickets/find/by/id/{id}";

		UriComponentsBuilder uriTemplate = UriComponentsBuilder.fromHttpUrl(baseUri);

		Map<String, Long> uriVariables = new HashMap<String, Long>();
		uriVariables.put("id", id);

		return restTemplate.getForObject(uriTemplate.buildAndExpand(uriVariables).toUriString(), TicketDto.class);
	}

	@Override
	public List<TicketDto> getAllTickets() {
		final String uri = HOST + ":" + PORT + "/tickets/find/all";

		ResponseEntity<TicketDto[]> response = restTemplate.getForEntity(uri, TicketDto[].class);
		return Arrays.asList(response.getBody());
	}

	@Override
	public List<TicketDto> filterTickets(TicketsFilter filter) {
		final String baseUri = HOST + ":" + PORT + "/tickets/find/all";

		UriComponentsBuilder uriTemplate = UriComponentsBuilder.fromHttpUrl(baseUri);

		if (filter.getStatus() != null) {
			uriTemplate.queryParam("status", filter.getStatus().name());
		}

		if (filter.getCategory() != null) {
			uriTemplate.queryParam("category", filter.getCategory());
		}

		ResponseEntity<TicketDto[]> response = restTemplate.getForEntity(uriTemplate.encode().toUriString(),
				TicketDto[].class);
		return Arrays.asList(response.getBody());
	}

	@Override
	public TicketDto add(TicketDto ticketDto) {
		final String uri = HOST + ":" + PORT + "/tickets/save";

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<TicketDto> request = new HttpEntity<TicketDto>(ticketDto);

		return restTemplate.postForObject(uri, request, TicketDto.class);
	}

	@Override
	public void update(TicketDto ticketDto) {
		final String uri = HOST + ":" + PORT + "/tickets/update";

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);


		HttpEntity<TicketDto> request = new HttpEntity<>(ticketDto);
		restTemplate.exchange(uri, HttpMethod.PUT, request, TicketDto.class);
	}

	@Override
	public void remove(Long ticketId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void assign(Long ticketId, AssignmentDto assignmentDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void intervention(Long ticketId, InterventionDto interventionDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void close(Long ticketId) {
		// TODO Auto-generated method stub
		
	}

}

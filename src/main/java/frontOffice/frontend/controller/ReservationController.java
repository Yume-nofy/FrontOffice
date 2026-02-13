package frontOffice.frontend.controller;

import frontOffice.frontend.model.Reservation;
import frontOffice.frontend.dto.ReservationDTO;
import frontOffice.frontend.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/reservations")
    public String listReservations(
            @RequestParam(name = "dateFilter", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateFilter,
            Model model) {

        // Récupérer les réservations depuis l'API
        List<Reservation> reservations = reservationService.getAllReservations();

        List<Reservation> filteredReservations = reservations;

        // Appliquer le filtre par date si fourni
        if (dateFilter != null) {
            filteredReservations = reservations.stream()
                    .filter(r -> r.getDateArrivee() != null && r.getDateArrivee().equals(dateFilter))
                    .collect(Collectors.toList());
        }

        // Formateurs pour date et heure
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

        // Convertir en DTO pour l'affichage
        List<ReservationDTO> reservationDTOs = new ArrayList<>();
        for (Reservation res : filteredReservations) {
            String dateStr = res.getDateArrivee() != null ? res.getDateArrivee().format(dateFormatter) : "-";
            String timeStr = res.getHeureArrivee() != null ? res.getHeureArrivee().format(timeFormatter) : "-";
            
            reservationDTOs.add(new ReservationDTO(
                    res.getId(),
                    res.getIdclient(),
                    res.getNomHotel(),
                    res.getNbPassager(),
                    dateStr,
                    timeStr
            ));
        }

        model.addAttribute("reservations", reservationDTOs);
        model.addAttribute("dateFilter", dateFilter);

        return "reservations";
    }

    @PostMapping("/reservations/filter")
    public String filterReservations(
            @RequestParam(name = "dateFilter", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateFilter,
            Model model) {

        return listReservations(dateFilter, model);
    }

    @GetMapping("/reservations/filter")
    public String filterReservationsGet(
            @RequestParam(name = "dateFilter", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateFilter,
            Model model) {

        return listReservations(dateFilter, model);
    }
}

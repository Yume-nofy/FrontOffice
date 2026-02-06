package frontOffice.frontend.controller;

import frontOffice.frontend.model.Reservation;
import frontOffice.frontend.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    // Classe wrapper pour stocker les réservations avec dates en java.util.Date
    public static class ReservationDTO {
        private int id;
        private String idclient;
        private int idhotel;
        private int nbPassager;
        private Date dateArrivee;

        public ReservationDTO(int id, String idclient, int idhotel, int nbPassager, Date dateArrivee) {
            this.id = id;
            this.idclient = idclient;
            this.idhotel = idhotel;
            this.nbPassager = nbPassager;
            this.dateArrivee = dateArrivee;
        }

        public int getId() { return id; }
        public String getIdclient() { return idclient; }
        public int getIdhotel() { return idhotel; }
        public int getNbPassager() { return nbPassager; }
        public Date getDateArrivee() { return dateArrivee; }
    }

    // Convertir LocalDateTime en java.util.Date
    private Date convertToDate(LocalDateTime localDateTime) {
        return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
    }

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
                    .filter(r -> r.getDateArrivee().toLocalDate().equals(dateFilter))
                    .collect(Collectors.toList());
        }

        // Convertir en DTO avec java.util.Date pour JSTL
        List<ReservationDTO> reservationDTOs = new ArrayList<>();
        for (Reservation res : filteredReservations) {
            reservationDTOs.add(new ReservationDTO(
                    res.getId(),
                    res.getIdclient(),
                    res.getIdhotel(),
                    res.getNbPassager(),
                    convertToDate(res.getDateArrivee())
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

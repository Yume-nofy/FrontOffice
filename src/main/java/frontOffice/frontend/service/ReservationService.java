package frontOffice.frontend.service;

import com.fasterxml.jackson.annotation.JsonProperty;
import frontOffice.frontend.model.Hotel;
import frontOffice.frontend.model.Reservation;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReservationService {

    private final RestTemplate restTemplate;
    private final String API_URL = "http://localhost:8080/api/reservations";

    // Map statique des hôtels (à remplacer par un appel API si disponible)

    public ReservationService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // Classe pour mapper la réponse JSON de l'API des réservations
    public static class ApiResponse {
        public int code;
        public List<ReservationAPI> data;
        public int count;
        public String message;
        public String status;
    }

    // Classe pour mapper les données de réservation de l'API
    public static class ReservationAPI {
        public int id;
        @JsonProperty("idClient")
        public String idClient;
        @JsonProperty("idHotel")
        public int idHotel;
        @JsonProperty("nbPassager")
        public int nbPassager;
        @JsonProperty("dateArrivee")
        public String dateArrivee;
        @JsonProperty("nomHotel") // Format ISO: "2026-02-05T16:22"
        public String nomHotel;

        public ReservationAPI() {}

        public Reservation toReservation() {
            Reservation res = new Reservation();
            res.setId(id);
            res.setIdclient(idClient);
            res.setIdhotel(idHotel);
            res.setNomHotel(nomHotel);
            res.setNbPassager(nbPassager);
            
            // Parser la date ISO string "2026-02-05T16:22"
            if (dateArrivee != null && !dateArrivee.isEmpty()) {
                try {
                    // Parser le format ISO datetime
                    LocalDateTime dateTime = LocalDateTime.parse(dateArrivee, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                    res.setDateArrivee(dateTime.toLocalDate());
                    res.setHeureArrivee(dateTime.toLocalTime());
                } catch (Exception e) {
                    System.err.println("Erreur parsing date '" + dateArrivee + "': " + e.getMessage());
                    res.setDateArrivee(LocalDate.now());
                    res.setHeureArrivee(LocalTime.now());
                }
            } else {
                res.setDateArrivee(LocalDate.now());
                res.setHeureArrivee(LocalTime.now());
            }
            
            return res;
        }
    }

    public List<Reservation> getAllReservations() {
        try {
            ApiResponse response = restTemplate.getForObject(API_URL, ApiResponse.class);
            
            if (response != null && response.data != null) {
                List<Reservation> reservations = new ArrayList<>();
                for (ReservationAPI apiRes : response.data) {
                    reservations.add(apiRes.toReservation());
                }
                return reservations;
            }
            return List.of();
        } catch (Exception e) {
            System.err.println("Erreur lors de l'appel à l'API: " + e.getMessage());
            e.printStackTrace();
            return List.of();
        }
    }
}

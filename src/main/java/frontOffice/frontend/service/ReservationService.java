package frontOffice.frontend.service;

import com.fasterxml.jackson.annotation.JsonProperty;
import frontOffice.frontend.model.Reservation;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ReservationService {

    private final RestTemplate restTemplate;
    private final String API_URL = "http://localhost:8080/api/reservations";

    public ReservationService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // Classe pour mapper la réponse JSON de l'API
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
        public Object dateArrivee; // Peut être null ou un objet

        public ReservationAPI() {}

        public Reservation toReservation() {
            // Convertir l'objet API en objet métier Reservation
            Reservation res = new Reservation();
            res.setId(id);
            res.setIdclient(idClient);
            res.setIdhotel(idHotel);
            res.setNbPassager(nbPassager);
            
            // Gérer la date (pour l'instant, mettre une date par défaut)
            res.setDateArrivee(LocalDateTime.now());
            
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

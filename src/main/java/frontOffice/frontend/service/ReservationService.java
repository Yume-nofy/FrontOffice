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
    import org.springframework.beans.factory.annotation.Autowired;

    @Service
    public class ReservationService {

        private final RestTemplate restTemplate;
        private final String API_URL = "http://localhost:8080/api/reservations";
        
        @Autowired
        private ConfigStorageService configStorageService;

    public ReservationService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
        // Classe pour mapper la réponse JSON de l'API des réservations
// 1. La réponse globale
   public static class ApiResponse {
    public int code;
    public DataWrapper data; // L'objet "data" extérieur
    public int count;
    public String message;
    public String status;
}

public static class DataWrapper {
    // Dans ton JSON, la liste est dans un champ qui s'appelle aussi "data"
    @JsonProperty("data") 
    public List<ReservationAPI> reservationsList; 
}     // Classe pour mapper les données de réservation de l'API
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
        String token = configStorageService.getTokenFromFile();
        String urlWithToken = API_URL + "?token=" + token;

        ApiResponse response = restTemplate.getForObject(urlWithToken, ApiResponse.class);
        
        // On vérifie : response -> data -> reservationsList
        if (response != null && response.data != null && response.data.reservationsList != null) {
            List<Reservation> reservations = new ArrayList<>();
            
            for (ReservationAPI apiRes : response.data.reservationsList) {
                reservations.add(apiRes.toReservation());
            }
            
            System.out.println("✅ Succès ! " + reservations.size() + " réservations récupérées.");
            return reservations;
        } else {
            System.err.println("⚠️ Structure non reconnue. Vérification du JSON brut...");
        }
    } catch (Exception e) {
        System.err.println("❌ Erreur : " + e.getMessage());
    }
    return List.of();
}
      }

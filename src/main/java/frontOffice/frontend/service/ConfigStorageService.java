package frontOffice.frontend.service;

import javax.annotation.PostConstruct;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

@Service
public class ConfigStorageService {

    // Le chemin est correct par rapport à la racine montrée dans tree
    private final String FILE_PATH = "base.conf"; 
    private final String TOKEN_KEY = "token=";
    private final String API_URL = "http://localhost:8080/api/token?id=2";

    public void fetchAndSaveToken() {
    try {
        Thread.sleep(5000); 
        System.out.println("🔄 Tentative de récupération...");
        RestTemplate restTemplate = new RestTemplate();
        
        // 1. Récupérer la réponse globale
        Map<String, Object> response = restTemplate.getForObject(API_URL, Map.class);

        if (response != null) {
            // 2. Extraire le bloc "data" (qui est lui-même une Map)
            Map<String, Object> data = (Map<String, Object>) response.get("data");

            if (data != null && data.get("token") != null) {
                // 3. Extraire le token depuis le bloc data
                String token = data.get("token").toString();
                
                updateConfigFile(token);
                System.out.println("✅ TOKEN TROUVÉ DANS 'DATA' : " + token);
            } else {
                System.err.println("❌ Champ 'token' introuvable dans le bloc 'data' !");
                System.out.println("Contenu de response : " + response);
            }
        }
    } catch (Exception e) {
        System.err.println("❌ Erreur : " + e.getMessage());
    }
}

    private synchronized void updateConfigFile(String tokenValue) throws IOException {
        Path path = Paths.get(FILE_PATH).toAbsolutePath();
        List<String> lines = Files.exists(path) ? Files.readAllLines(path) : new ArrayList<>();
        boolean updated = false;

        for (int i = 0; i < lines.size(); i++) {
            if (lines.get(i).startsWith(TOKEN_KEY)) {
                lines.set(i, TOKEN_KEY + tokenValue);
                updated = true;
                break;
            }
        }

        if (!updated) {
            lines.add(TOKEN_KEY + tokenValue);
        }

        Files.write(path, lines);
    }
    public String getTokenFromFile() {
    try {
        Path path = Paths.get("base.conf"); // Le fichier à la racine
        if (Files.exists(path)) {
            List<String> lines = Files.readAllLines(path);
            for (String line : lines) {
                if (line.startsWith("token=")) {
                    return line.replace("token=", "").trim();
                }
            }
        }
    } catch (IOException e) {
        System.err.println("❌ Erreur lors de la lecture de base.conf : " + e.getMessage());
    }
    return null;
}
    @PostConstruct
    public void init() {
        new Thread(this::fetchAndSaveToken).start();
    }
}
package frontOffice.frontend.dto;

public class ReservationDTO {
    private int id;
    private String idclient;
    private String nomHotel;
    private int nbPassager;
    private String dateArrivee;
    private String heureArrivee;

    public ReservationDTO(int id, String idclient, String nomHotel, int nbPassager, String dateArrivee, String heureArrivee) {
        this.id = id;
        this.idclient = idclient;
        this.nomHotel = nomHotel;
        this.nbPassager = nbPassager;
        this.dateArrivee = dateArrivee;
        this.heureArrivee = heureArrivee;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIdclient() {
        return idclient;
    }

    public void setIdclient(String idclient) {
        this.idclient = idclient;
    }

    public String getNomHotel() {
        return nomHotel;
    }

    public void setNomHotel(String nomHotel) {
        this.nomHotel = nomHotel;
    }

    public int getNbPassager() {
        return nbPassager;
    }

    public void setNbPassager(int nbPassager) {
        this.nbPassager = nbPassager;
    }

    public String getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(String dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    public String getHeureArrivee() {
        return heureArrivee;
    }

    public void setHeureArrivee(String heureArrivee) {
        this.heureArrivee = heureArrivee;
    }

    @Override
    public String toString() {
        return "ReservationDTO{" +
                "id=" + id +
                ", idclient='" + idclient + '\'' +
                ", nomHotel='" + nomHotel + '\'' +
                ", nbPassager=" + nbPassager +
                ", dateArrivee='" + dateArrivee + '\'' +
                ", heureArrivee='" + heureArrivee + '\'' +
                '}';
    }
}

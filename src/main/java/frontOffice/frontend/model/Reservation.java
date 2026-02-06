package frontOffice.frontend.model;

import java.time.LocalDateTime;

public class Reservation {
    private int id;
    private String idclient;
    private int idhotel;
    private int nbPassager;
    private LocalDateTime dateArrivee;

    public Reservation() {
    }

    public Reservation(int id, String idclient, int idhotel, int nbPassager, LocalDateTime dateArrivee) {
        this.id = id;
        this.idclient = idclient;
        this.idhotel = idhotel;
        this.nbPassager = nbPassager;
        this.dateArrivee = dateArrivee;
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

    public int getIdhotel() {
        return idhotel;
    }

    public void setIdhotel(int idhotel) {
        this.idhotel = idhotel;
    }

    public int getNbPassager() {
        return nbPassager;
    }

    public void setNbPassager(int nbPassager) {
        this.nbPassager = nbPassager;
    }

    public LocalDateTime getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(LocalDateTime dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    @Override
    public String toString() {
        return "Reservation{" +
                "id=" + id +
                ", idclient='" + idclient + '\'' +
                ", idhotel=" + idhotel +
                ", nbPassager=" + nbPassager +
                ", dateArrivee=" + dateArrivee +
                '}';
    }
}

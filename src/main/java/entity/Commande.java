package entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "commande")
public class Commande {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcommande")
    private int id;
    @ManyToOne
    @JoinColumn(name = "IdClient")  // Nom de la colonne pour l'ID du client
    private Client client;  // L'ID du client associé à la commande

    @Column(name = "DateDeCommande")
    private Date dateDeCommande;

    @Column(name = "StatutDeCommande")
    private String statutDeCommande;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client idClient) {
        this.client = idClient;
    }

    public Date getDateDeCommande() {
        return dateDeCommande;
    }

    public void setDateDeCommande(Date dateDeCommande) {
        this.dateDeCommande = dateDeCommande;
    }

    public String getStatutDeCommande() {
        return statutDeCommande;
    }

    public void setStatutDeCommande(String statutDeCommande) {
        this.statutDeCommande = statutDeCommande;
    }
}


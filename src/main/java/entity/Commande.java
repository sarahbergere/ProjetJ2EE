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
    @JoinColumn(name = "IdClient")
    private Client client;

    @Column(name = "DateDeCommande")
    private Date dateDeCommande;

    @Column(name = "StatutDeCommande")
    private String statutDeCommande;

    @Column(name = "montant")
    private double montant;

    public Commande() {
    }

    public Commande(Date date, double montant, String statut, Client client) {
        this.dateDeCommande = date;
        this.statutDeCommande = statut;
        this.montant = montant;
        this.client = client;

        client.ajouterCommande(this);
    }
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

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
}


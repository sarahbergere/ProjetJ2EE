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

    @Column(name = "Nom")
    private String nom;

    @Column(name = "Adresse")
    private String adresse;

    @Column(name = "CodePostal")
    private String codePostal;

    @Column(name = "Ville")
    private String ville;

    @Column(name = "Pays")
    private String pays;

    public Commande() {
    }

    public Commande(Client client, Date dateDeCommande, String statutDeCommande, double montant, String nom, String adresse, String codePostal, String ville, String pays) {
        this.client = client;
        this.dateDeCommande = dateDeCommande;
        this.statutDeCommande = statutDeCommande;
        this.montant = montant;
        this.nom = nom;
        this.adresse = adresse;
        this.codePostal = codePostal;
        this.ville = ville;
        this.pays = pays;
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

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getCodePostal() {
        return codePostal;
    }

    public void setCodePostal(String codePostal) {
        this.codePostal = codePostal;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }
}


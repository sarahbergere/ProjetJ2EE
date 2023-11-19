package entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "paiement")
public class Paiement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPaiement")
    private int id;

    @ManyToOne
    @JoinColumn(name = "CommandeID")
    private Commande commande;

    @ManyToOne
    @JoinColumn(name = "CompteBancaireID")
    private CompteBancaire compteBancaire;

    @Column(name = "Montant")
    private double montantDuPaiement;

    public Paiement(){

    }

    public Paiement(Commande commande, CompteBancaire compteBancaire, double montantDuPaiement, Date dateDuPaiement) {
        this.commande = commande;
        this.compteBancaire = compteBancaire;
        this.montantDuPaiement = montantDuPaiement;
        this.dateDuPaiement = dateDuPaiement;
    }

    @Column(name = "Date")
    private Date dateDuPaiement;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Commande getCommande() {
        return commande;
    }

    public void setCommande(Commande commande) {
        this.commande = commande;
    }

    public CompteBancaire getCompteBancaire() {
        return compteBancaire;
    }

    public void setCompteBancaire(CompteBancaire compteBancaire) {
        this.compteBancaire = compteBancaire;
    }

    public double getMontantDuPaiement() {
        return montantDuPaiement;
    }

    public void setMontantDuPaiement(double montantDuPaiement) {
        this.montantDuPaiement = montantDuPaiement;
    }

    public Date getDateDuPaiement() {
        return dateDuPaiement;
    }

    public void setDateDuPaiement(Date dateDuPaiement) {
        this.dateDuPaiement = dateDuPaiement;
    }
}

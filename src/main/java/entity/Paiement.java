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

    @JoinColumn(name = "CommandeID")
    private int commandeID;

    @JoinColumn(name = "CompteBancaireID")
    private int compteBancaireID;

    @Column(name = "Montant")
    private double montantDuPaiement;

    public Paiement(){

    }

    public Paiement(int commandeID, int compteBancaireID, double montantDuPaiement, Date dateDuPaiement) {
        this.commandeID = commandeID;
        this.compteBancaireID = compteBancaireID;
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

    public int getCommande() {
        return commandeID;
    }

    public void setCommande(int commande) {
        this.commandeID = commande;
    }

    public int getCompteBancaire() {
        return compteBancaireID;
    }

    public void setCompteBancaire(int compteBancaire) {
        this.compteBancaireID = compteBancaire;
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

package entity;

import javax.persistence.*;

@Entity
@Table(name = "detailcommande")
public class DetailCommande {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idDetailCommande")
    private int id;

    @ManyToOne
    @JoinColumn(name = "CommandeId")
    private Commande commande;

    @ManyToOne
    @JoinColumn(name = "ProduitId")
    private Produit produit;

    @Column(name = "Quantite")
    private int quantite;

    public DetailCommande() {

    }

    public DetailCommande(Commande commande, Produit produit, int quantite) {
        this.commande = commande;
        this.produit = produit;
        this.quantite = quantite;
    }

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

    public Produit getProduit() {
        return produit;
    }

    public void setProduit(Produit produit) {
        this.produit = produit;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }
}


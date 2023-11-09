package entity;
import javax.persistence.*;

@Entity
@Table(name = "produit")
public class Produit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idproduit")
    private int id;

    @Column(name = "Nom")
    private String nomDuProduit;

    @Column(name = "Description")
    private String description;

    @Column(name = "Prix")
    private double prix;

    @Column(name = "Stock")
    private int stock;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomDuProduit() {
        return nomDuProduit;
    }

    public void setNomDuProduit(String nomDuProduit) {
        this.nomDuProduit = nomDuProduit;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
}

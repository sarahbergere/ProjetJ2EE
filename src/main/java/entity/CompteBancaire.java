package entity;
import javax.persistence.*;

@Entity
@Table(name = "comptebancaire")
public class CompteBancaire {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcompteBancaire")
    private int id;

    @Column(name = "TitulaireDuCompte")
    private String titulaireDuCompte;

    @Column(name = "NumeroDeCompte")
    private String numeroDeCompte;

    @Column(name = "Solde")
    private double solde;

    @ManyToOne
    @JoinColumn(name = "ClientID")
    private Client client;

    public CompteBancaire(){

    }
    public CompteBancaire(String titulaire, String numeroCompte, double v, Client client) {
        this.titulaireDuCompte = titulaire;
        this.numeroDeCompte = numeroCompte;
        this.solde = v;
        this.client = client;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulaireDuCompte() {
        return titulaireDuCompte;
    }

    public void setTitulaireDuCompte(String titulaireDuCompte) {
        this.titulaireDuCompte = titulaireDuCompte;
    }

    public String getNumeroDeCompte() {
        return numeroDeCompte;
    }

    public void setNumeroDeCompte(String numeroDeCompte) {
        this.numeroDeCompte = numeroDeCompte;
    }

    public double getSolde() {
        return solde;
    }

    public void setSolde(double solde) {
        this.solde = solde;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }
}

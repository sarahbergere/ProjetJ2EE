package entity;

import dao.CommandeDAO;
import dao.CompteBancaireDAO;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "client")
public class Client {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idclient")
    private int id;

    @Column(name = "Nom")
    private String nom;

    @Column(name = "Prenom")
    private String prenom;

    @Column(name = "Adresse")
    private String adresse;

    @Column(name = "Email")
    private String adresseEmail;

    @Column(name = "Telephone")
    private String numeroTelephone;

    @Column(name = "Droit")
    private String droit;

    @Column(name = "idUtilisateur")
    private int idUtilisateur;

    @OneToMany(mappedBy = "client")
    private List<CompteBancaire> comptes;

    @OneToMany(mappedBy = "client")
    private List<Commande> commandes;

    public Client(){    }

    public Client(String nom, String prenom, String adresse,String email, String numeroTelephone, String droit) {
        this.nom = nom;
        this.prenom = prenom;
        this.adresse = adresse;
        this.adresseEmail = email;
        this.numeroTelephone = numeroTelephone;
        this.commandes = new ArrayList<>();
        this.droit = droit;

        this.chargerCommande();
        this.chargerCompteBancaire();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getEmail() {
        return adresseEmail;
    }

    public void setEmail(String adresseEmail) {
        this.adresseEmail = adresseEmail;
    }

    public String getNumeroTelephone() {
        return numeroTelephone;
    }

    public void setNumeroTelephone(String numeroTelephone) {
        this.numeroTelephone = numeroTelephone;
    }

    public int getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(int idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public List<CompteBancaire> getComptes() {
        return comptes;
    }

    public void chargerCompteBancaire(){
        CompteBancaireDAO compteBancaireDAO = new CompteBancaireDAO();
        this.comptes = compteBancaireDAO.findAllByIdClient(this.getId());
    }

    public void ajouterCompteBancaire(CompteBancaire compteBancaire){this.comptes.add(compteBancaire);}

    public void setComptes(List<CompteBancaire> comptesBancaires) {
        this.comptes = comptesBancaires;
    }

    public void ajouterCommande(Commande commande) {
        this.commandes.add(commande);
    }

    public void chargerCommande(){
        CommandeDAO commandeDAO = new CommandeDAO();
        this.commandes = commandeDAO.findAllById(this.getId());
    }

    public List<Commande> getCommandes() {
        return this.commandes;
    }

    public String getDroit() {
        return droit;
    }

    public void setDroit(String droit) {
        this.droit = droit;
    }

}

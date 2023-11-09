package entity;
import javax.persistence.*;

@Entity
@Table(name = "utilisateur")
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idUtilisateur")
    private int idUtilisateur;

    @Column(name = "pseudo")
    private String pseudo;

    @Column(name = "Role")
    @Enumerated(EnumType.STRING)
    private Role role;

    @Column(name = "motDePasse")
    private String motDePasse;


    public int getId() {
        return idUtilisateur;
    }

    public void setId(int id) {
        this.idUtilisateur = id;
    }

    public String getPseudo() {
        return pseudo;
    }

    public void setPseudo(String nomUtilisateur) {
        this.pseudo = nomUtilisateur;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }
}


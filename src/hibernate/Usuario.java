package hibernate;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "Usuario")
public class Usuario implements Serializable {
	private int usuarioid;
	private String dniusuario;
	private String nombreusuario;
	private String apellidosusuario;
	private String nickusuario;
	private String passwordusuario;
	private String emailusuario;
	private String tlfusuario;
	private Set<CuentaBancaria> cuentas = new HashSet<CuentaBancaria>();
	
	
	public Usuario() {
		super();
	}

	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "increment")
	public int getUsuarioId() {
		return usuarioid;
	}

	public void setUsuarioId(int usuarioId) {
		usuarioid = usuarioId;
	}

	public String getDniUsuario() {
		return dniusuario;
	}

	public void setDniUsuario(String dniUsuario) {
		this.dniusuario = dniUsuario;
	}

	public String getNombreUsuario() {
		return nombreusuario;
	}

	public void setNombreUsuario(String nombreUsuario) {
		this.nombreusuario = nombreUsuario;
	}

	public String getApellidosUsuario() {
		return apellidosusuario;
	}

	public void setApellidosUsuario(String apellidosUsuario) {
		this.apellidosusuario = apellidosUsuario;
	}

	public String getNickUsuario() {
		return nickusuario;
	}

	public void setNickUsuario(String nickUsuario) {
		this.nickusuario = nickUsuario;
	}

	public String getPasswordUsuario() {
		return passwordusuario;
	}

	public String getEmailusuario() {
		return emailusuario;
	}

	public void setEmailusuario(String emailusuario) {
		this.emailusuario = emailusuario;
	}

	public void setPasswordUsuario(String passwordUsuario) {
		this.passwordusuario = passwordUsuario;
	}

	public String getTlfUsuario() {
		return tlfusuario;
	}

	public void setTlfUsuario(String tlfUsuario) {
		this.tlfusuario = tlfUsuario;
	}

	public Set<CuentaBancaria> getCuentas() {
		return cuentas;
	}

	public void setCuentas(Set<CuentaBancaria> cuentas) {
		this.cuentas = cuentas;
	}

}

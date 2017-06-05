package hibernate;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

public class CuentaBancaria implements Serializable {
	private int cuentabancariaid;
	private String numerocuenta;
	private String titularcuenta;
	private String entidadcuenta;
	private String tipocuenta;
	private String paisdomiciliacion;
	private String bic;
	private BigDecimal saldo;
	private Set<Operacion> opereaciones = new HashSet<Operacion>();
	
	public CuentaBancaria() {
		super();
	}

	public int getCuentaBancariaId() {
		return cuentabancariaid;
	}
	public void setCuentaBancariaId(int cuentaBancariaId) {
		this.cuentabancariaid = cuentaBancariaId;
	}
	public String getNumeroCuenta() {
		return numerocuenta;
	}
	public void setNumeroCuenta(String numeroCuenta) {
		this.numerocuenta = numeroCuenta;
	}

	public String getTitularCuenta() {
		return this.titularcuenta;
	}

	public void setTitularCuenta(String titularCuenta) {
		this.titularcuenta = titularCuenta;
	}
	public String getEntidadCuenta() {
		return entidadcuenta;
	}
	public void setEntidadCuenta(String entidadCuenta) {
		this.entidadcuenta = entidadCuenta;
	}
	public String getTipoCuenta() {
		return tipocuenta;
	}
	public void setTipoCuenta(String tipoCuenta) {
		this.tipocuenta = tipoCuenta;
	}
	public String getPaisDomiciliacion() {
		return paisdomiciliacion;
	}
	public void setPaisDomiciliacion(String paisDomiciliacion) {
		this.paisdomiciliacion = paisDomiciliacion;
	}
	public String getBIC() {
		return bic;
	}

	public void setBIC(String bic) {
		bic = bic;
	}

	public BigDecimal getSaldo() {
		return saldo;
	}

	public void setSaldo(BigDecimal saldo) {
		this.saldo = saldo;
	}
	public Set<Operacion> getOpereaciones() {
		return opereaciones;
	}
	public void setOpereaciones(Set<Operacion> opereaciones) {
		this.opereaciones = opereaciones;
	}
	
	
}

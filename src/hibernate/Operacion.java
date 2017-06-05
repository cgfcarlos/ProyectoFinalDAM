package hibernate;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class Operacion implements Serializable {
	private int operacionid;
	private String nombreoperacion;
	private String tipooperacion;
	private BigDecimal cuantia;
	private Date fechaoperacion;
	private Date fechavalor;

	public Operacion() {
		super();
	}

	public int getOperacionId() {
		return operacionid;
	}

	public void setOperacionId(int operacionId) {
		this.operacionid = operacionId;
	}

	public String getNombreOperacion() {
		return nombreoperacion;
	}

	public void setNombreOperacion(String nombreOperacion) {
		this.nombreoperacion = nombreOperacion;
	}

	public String getTipoOperacion() {
		return tipooperacion;
	}

	public void setTipoOperacion(String tipoOperacion) {
		this.tipooperacion = tipoOperacion;
	}

	public BigDecimal getCuantia() {
		return cuantia;
	}

	public void setCuantia(BigDecimal cuantia) {
		this.cuantia = cuantia;
	}

	public Date getFechaOperacion() {
		return fechaoperacion;
	}

	public void setFechaOperacion(Date fechaOperacion) {
		this.fechaoperacion = fechaOperacion;
	}

	public Date getFechaValor() {
		return fechavalor;
	}

	public void setFechaValor(Date fechaValor) {
		this.fechavalor = fechaValor;
	}

}

package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hibernate.CuentaBancaria;
import hibernate.Operacion;

/**
 * Servlet implementation class servletTransaccion
 */
@WebServlet("/servletTransaccion")
public class servletTransaccion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletTransaccion() {
        super();

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession sesion = request.getSession();
			CuentaBancaria cuentaP = (CuentaBancaria) sesion.getAttribute("cuenta");
			if (request.getParameter("numcuenta") != null) {

				BigDecimal cuantia = BigDecimal.valueOf(Double.valueOf(request.getParameter("importe")));

				Class.forName("com.mysql.jdbc.Driver");

				Connection con = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/contabilidad?autoReconnect=true&useSSL=false", "admin", "admin");

				Statement st = con.createStatement();

				String query = "SELECT cuentabancariaid, numerocuenta, titularcuenta, entidadcuenta, tipocuenta, paisdomiciliacion, bic, saldo FROM cuentabancaria JOIN usuario ON usuario.usuarioid=cuentabancaria.usuarioid WHERE numerocuenta LIKE '"
						+ request.getParameter("numcuenta") + "'";
				ResultSet resultSet = st.executeQuery(query);
				CuentaBancaria cuenta = new CuentaBancaria();
				while (resultSet.next()) {
					cuenta.setCuentaBancariaId(resultSet.getInt(1));
					cuenta.setNumeroCuenta(resultSet.getString(2));
					cuenta.setTitularCuenta(resultSet.getString(3));
					cuenta.setEntidadCuenta(resultSet.getString(4));
					cuenta.setTipoCuenta(resultSet.getString(5));
					cuenta.setPaisDomiciliacion(resultSet.getString(6));
					cuenta.setBIC(resultSet.getString(7));
					cuenta.setSaldo(resultSet.getBigDecimal(8));

				}
				resultSet.close();
				
				String queryInsert = "INSERT INTO operacion (nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor, cuentabancariaid) VALUES ('Transaccion','Gasto',"
						+ cuantia.multiply(BigDecimal.valueOf(-1)) + ",'"
						+ Calendar.getInstance().get(Calendar.YEAR) + "-"
						+ (Calendar.getInstance().get(Calendar.MONTH) + 1) + "-"
						+ Calendar.getInstance().get(Calendar.DATE) + "','" + Calendar.getInstance().get(Calendar.YEAR)
						+ "-" + (Calendar.getInstance().get(Calendar.MONTH) + 1) + "-"
						+ Calendar.getInstance().get(Calendar.DATE) + "'," + cuentaP.getCuentaBancariaId() + ")";

				int rowSum = st.executeUpdate(queryInsert);

				String queryInsert2 = "INSERT INTO operacion (nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor, cuentabancariaid) VALUES ('Transaccion','Ingreso',"
						+ cuantia + ",'"
						+ Calendar.getInstance().get(Calendar.YEAR) + "-"
						+ (Calendar.getInstance().get(Calendar.MONTH) + 1) + "-"
						+ Calendar.getInstance().get(Calendar.DATE) + "','" + Calendar.getInstance().get(Calendar.YEAR)
						+ "-" + (Calendar.getInstance().get(Calendar.MONTH) + 1) + "-"
						+ Calendar.getInstance().get(Calendar.DATE) + "'," + cuenta.getCuentaBancariaId() + ")";

				int rowSub = st.executeUpdate(queryInsert2);

				String updateCuentaP = "UPDATE cuentabancaria SET saldo=" + (cuentaP.getSaldo().subtract(cuantia))
						+ " WHERE cuentabancariaid=" + cuentaP.getCuentaBancariaId();

				int rowUpdate = st.executeUpdate(updateCuentaP);

				String updateCuenta = "UPDATE cuentabancaria SET saldo =" + (cuenta.getSaldo().add(cuantia))
						+ " WHERE cuentabancariaid=" + cuenta.getCuentaBancariaId();

				int rowUpdate2 = st.executeUpdate(updateCuenta);

				cuentaP.setSaldo((cuentaP.getSaldo().subtract(cuantia)));

				List<Operacion> operaciones = new ArrayList<>();
				String queryOp = "SELECT nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor FROM operacion WHERE cuentabancariaid LIKE "
						+ cuentaP.getCuentaBancariaId();

				ResultSet rs = st.executeQuery(queryOp);
				while (rs.next()) {
					Operacion operacion = new Operacion();
					operacion.setNombreOperacion(rs.getString(1));
					operacion.setTipoOperacion(rs.getString(2));
					operacion.setCuantia(rs.getBigDecimal(3));
					operacion.setFechaOperacion(rs.getDate(4));
					operacion.setFechaValor(rs.getDate(5));

					operaciones.add(operacion);
				}
				rs.close();

				if (rowSub == 1 && rowSum == 1 && rowUpdate == 1 && rowUpdate2 == 1) {
					sesion.setAttribute("cuenta", cuentaP);
					sesion.setAttribute("operaciones", operaciones);
					request.getRequestDispatcher("main.jsp").forward(request, response);

				}

			}
		} catch (Exception ex) {
			System.out.println(ex);
		}
	}

}

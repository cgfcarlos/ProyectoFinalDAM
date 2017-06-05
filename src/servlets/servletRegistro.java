package servlets;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
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
 * Servlet implementation class servletRegistro
 */
@WebServlet("/servletRegistro")
public class servletRegistro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletRegistro() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("nombre") != null && request.getParameter("apellidos") != null
				&& request.getParameter("nick") != null && request.getParameter("pass") != null
				&& request.getParameter("email") != null && request.getParameter("dni") != null
				&& request.getParameter("numCuenta") != null && request.getParameter("titularCuenta") != null
				&& request.getParameter("tipoCuenta") != null && request.getParameter("pais") != null
				&& request.getParameter("bic") != null && request.getParameter("saldo") != null && request.getParameter("entidad")!=null) {
			try {

				HttpSession sesion = request.getSession();

				String nombre = request.getParameter("nombre");
				String apellidos = request.getParameter("apellidos");
				String nick = request.getParameter("nick");
				String pass = request.getParameter("pass");
				String email = request.getParameter("email");
				String dni = request.getParameter("dni");
				String tlf = request.getParameter("tlf");
				String numCuenta = request.getParameter("numCuenta");
				String titularCuenta = request.getParameter("titularCuenta");
				String tipoCuenta = request.getParameter("tipoCuenta");
				String pais = request.getParameter("pais");
				String bic = request.getParameter("bic");
				String entidad = request.getParameter("entidad");
				

				DecimalFormatSymbols symbols = new DecimalFormatSymbols();
				symbols.setGroupingSeparator(',');
				symbols.setDecimalSeparator('.');
				String pattern = "#,##0.0#";
				DecimalFormat decimalFormat = new DecimalFormat(pattern, symbols);
				decimalFormat.setParseBigDecimal(true);

				BigDecimal saldo =  (BigDecimal) decimalFormat.parse(request.getParameter("saldo").toString());
				
				Class.forName("com.mysql.jdbc.Driver");

				Connection con = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/contabilidad?autoReconnect=true&useSSL=false", "admin",
						"admin");

				Statement st = con.createStatement();
				

				String queryComprob = "SELECT usuarioid FROM usuario WHERE nickusuario LIKE '" + nick
						+ "' OR emailusuario LIKE '" + email + "'";

				ResultSet filasComprob = st.executeQuery(queryComprob);

				if (!filasComprob.first()) {
					filasComprob.close();
					String query = "INSERT INTO usuario (dniusuario, nombreusuario, apellidosusuario, nickusuario, passwordusuario, emailusuario, tlfusuario) VALUES ('"
							+ dni + "','" + nombre + "','" + apellidos + "','" + nick + "','" + pass + "','" + email
							+ "','" + tlf + "')";

					int filas = st.executeUpdate(query);

					if (filas >= 1) {
						File theDir = new File("WebContent\\usuarios\\" + nick);

						// if the directory does not exist, create it
						if (!theDir.exists()) {

							boolean result = false;

							try {
								theDir.mkdir();
								result = true;
							} catch (SecurityException se) {
								// handle it
							}
							if (result) {
								System.out.println("DIR created");
							}
						}
						String queryU = "SELECT usuarioid FROM usuario WHERE nickusuario LIKE '" + nick + "'";
						ResultSet rs = st.executeQuery(queryU);
						int usuarioid = 0;
						while (rs.next()) {
							usuarioid = rs.getInt(1);
						}
						rs.close();
						String queryComprobCuenta = "SELECT cuentabancariaid FROM cuentabancaria WHERE numerocuenta LIKE '"
								+ numCuenta + "'";
						ResultSet filasComprobCuenta = st.executeQuery(queryComprobCuenta);
						if (!filasComprobCuenta.first()) {
							filasComprobCuenta.close();
							query = "INSERT INTO cuentabancaria (numerocuenta, titularcuenta, entidadcuenta, tipocuenta, paisdomiciliacion, bic, saldo, usuarioid) VALUES ('"
									+ numCuenta + "','" + titularCuenta + "','" + entidad + "', '" + tipoCuenta + "','"
									+ pais + "','" + bic + "'," + saldo + "," + usuarioid + ")";
							int filasCuenta = st.executeUpdate(query);
							if (filasCuenta >= 1) {
								String queryC = "SELECT titularcuenta, numerocuenta, entidadcuenta, saldo, tipocuenta FROM cuentabancaria JOIN usuario ON cuentabancaria.usuarioid LIKE usuario.usuarioid WHERE nickusuario LIKE '"
										+ nick + "' AND passwordusuario LIKE '" + pass + "'";

								ResultSet resultSet = st.executeQuery(queryC);
								CuentaBancaria cuentaBancaria = new CuentaBancaria();
								List<Operacion> operaciones = new ArrayList<>();
								while (resultSet.next()) {
									cuentaBancaria.setTitularCuenta(resultSet.getString(1));
									cuentaBancaria.setNumeroCuenta(resultSet.getString(2));
									cuentaBancaria.setEntidadCuenta(resultSet.getString(3));
									cuentaBancaria.setSaldo(resultSet.getBigDecimal(4));
									cuentaBancaria.setTipoCuenta(resultSet.getString(5));
								}
								resultSet.close();

								String queryOp = "SELECT nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor FROM operacion AS o JOIN cuentabancaria AS c ON o.cuentabancariaid LIKE c.cuentabancariaid JOIN usuario AS u on u.usuarioid LIKE c.usuarioid WHERE u.nickusuario LIKE '"
										+ nick + "' AND passwordusuario LIKE '" + pass + "'";

								ResultSet result = st.executeQuery(queryOp);
								while (result.next()) {
									Operacion operacion = new Operacion();
									operacion.setNombreOperacion(result.getString(1));
									operacion.setTipoOperacion(result.getString(2));
									operacion.setCuantia(result.getBigDecimal(3));
									operacion.setFechaOperacion(result.getDate(4));
									operacion.setFechaValor(result.getDate(5));

									operaciones.add(operacion);
								}
								rs.close();

								sesion.setAttribute("operaciones", operaciones);
								sesion.setAttribute("cuenta", cuentaBancaria);
								request.setAttribute("operaciones", operaciones);
								request.setAttribute("cuenta", cuentaBancaria);
								sesion.setAttribute("error", "");
								request.getRequestDispatcher("main.jsp").forward(request, response);

							} else {
								sesion.setAttribute("error", "Ha ocurrido un error al registrar la cuenta bancaria");
								request.getRequestDispatcher("registro.jsp").forward(request, response);
							}
						} else {
							filasComprobCuenta.close();
							sesion.setAttribute("error", "La cuenta bancaria ya existe");
							request.getRequestDispatcher("registro.jsp").forward(request, response);
						}
					} else {
						sesion.setAttribute("error", "Ha ocurrido un error al registrar el usuario");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					}
				}
				else {
					filasComprob.close();
					sesion.setAttribute("error", "Email o usuario ya estan en la base de datos");
					request.getRequestDispatcher("registro.jsp").forward(request, response);
				}

			} catch (Exception ex) {
				System.out.println(ex.toString());
			}
		}
	}

}

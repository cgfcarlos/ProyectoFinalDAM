package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
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
 * Servlet implementation class servletOperaciones
 */
@WebServlet("/servletOperaciones")
public class servletOperaciones extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletOperaciones() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("operaciones.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			if (request.getParameter("submit") != null && request.getParameter("nombreOperacion") != null
					&& request.getParameter("tipoOperacion") != null
					&& request.getParameter("cuantia") != null && request.getParameter("fechaValor") != null
					&& request.getParameter("fechaOperacion") != null) {

				String nombreOperacion = request.getParameter("nombreOperacion");
				String tipoOperacion = request.getParameter("tipoOperacion");
				BigDecimal cuantia = BigDecimal.valueOf(Double.valueOf(request.getParameter("cuantia")));
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Calendar fechaO = new GregorianCalendar();
				fechaO.setTime(formatter.parse(request.getParameter("fechaOperacion")));
				Calendar fechaV = new GregorianCalendar();
				fechaV.setTime(formatter.parse(request.getParameter("fechaValor")));

				if (tipoOperacion == "Gasto") {
					cuantia = cuantia.multiply(new BigDecimal(-1));
				}

				HttpSession sesion = request.getSession();

				CuentaBancaria cuenta = (CuentaBancaria) sesion.getAttribute("cuenta");
				String user = sesion.getAttribute("user").toString();
				String pass = sesion.getAttribute("pass").toString();

				Class.forName("com.mysql.jdbc.Driver");

				Connection con = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/contabilidad?autoReconnect=true&useSSL=false", "admin", "admin");

				Statement st = con.createStatement();

				String query = "INSERT INTO operacion (nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor, cuentabancariaid) VALUES ('"
						+ nombreOperacion + "','" + tipoOperacion + "'," + cuantia + ",'"
						+ fechaO.get(Calendar.YEAR) + "-" + (fechaO.get(Calendar.MONTH) + 1) + "-"
						+ fechaO.get(Calendar.DATE) + "','" + fechaV.get(Calendar.YEAR) + "-"
						+ (fechaV.get(Calendar.MONTH) + 1) + "-" + fechaV.get(Calendar.DATE) + "',"
						+ cuenta.getCuentaBancariaId() + ")";

				int row = st.executeUpdate(query);
				if (row == 1) {
					List<Operacion> operaciones = new ArrayList<Operacion>();
					String query2 = "SELECT nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor FROM operacion AS o JOIN cuentabancaria AS c ON o.cuentabancariaid LIKE c.cuentabancariaid JOIN usuario AS u on u.usuarioid LIKE c.usuarioid WHERE u.nickusuario LIKE '"
							+ user + "' AND passwordusuario LIKE '" + pass + "'";

					ResultSet rs = st.executeQuery(query2);
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
					sesion.removeAttribute("operaciones");
					sesion.setAttribute("operaciones", operaciones);
					sesion.setAttribute("error", "");
					request.getRequestDispatcher("main.jsp").forward(request, response);
				} else {
					sesion.setAttribute("error", "Se ha producido un error al realizar la operación");
					request.getRequestDispatcher("operaciones.jsp").forward(request, response);
				}
			}


		} catch (Exception ex) {
			ex.toString();
		}
	}

}

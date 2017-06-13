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
 * Servlet implementation class servletPrestamo
 */
@WebServlet("/servletPrestamo")
public class servletPrestamo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletPrestamo() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession sesion = request.getSession();
			System.out.println(request.getParameterNames());
			String comprobacion = request.getParameter("anualidad0");
			// Comprobar que al menos tiene un campo del prestamo para poder realizarlo
			if (comprobacion != null && !comprobacion.isEmpty()) {
				Class.forName("com.mysql.jdbc.Driver");

				Connection con = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/contabilidad?autoReconnect=true&useSSL=false", "admin", "admin");

				Statement st = con.createStatement();
				
				CuentaBancaria cuenta = (CuentaBancaria) sesion.getAttribute("cuenta");

				List<Operacion> operaciones = new ArrayList<>();
				Operacion prestamo = new Operacion();
				prestamo.setNombreOperacion("Prestamo Bancario");
				prestamo.setTipoOperacion("Ingreso");
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Calendar fechaO = new GregorianCalendar();
				fechaO.setTime(formatter.parse(request.getParameter("fechaconcesion")));
				Calendar fechaV = new GregorianCalendar();
				fechaV.setTime(formatter.parse(request.getParameter("fechaconcesion")));
				prestamo.setFechaOperacion(fechaO.getTime());
				prestamo.setFechaValor(fechaV.getTime());
				BigDecimal cuantia = BigDecimal.valueOf(Double.valueOf(request.getParameter("capital")));
				prestamo.setCuantia(cuantia);

				operaciones.add(prestamo);

				Calendar currentDate = new GregorianCalendar();
				currentDate.setTime(formatter.parse(request.getParameter("fechaconcesion")));

				for (int i = 0; i < 12; i++) {
					Operacion op = new Operacion();
					op.setNombreOperacion("Pago Prestamo");
					op.setTipoOperacion("Gasto");
					BigDecimal cantidad = BigDecimal.valueOf(Double.valueOf(request.getParameter("anualidad" + i)));
					op.setCuantia(cantidad.multiply(BigDecimal.valueOf(-1)));
					op.setFechaOperacion(currentDate.getTime());
					op.setFechaValor(currentDate.getTime());

					currentDate.add(Calendar.MONTH, 1);

					operaciones.add(op);
				}
				String query = "INSERT INTO operacion (nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor, cuentabancariaid) VALUES ";
				for(Operacion o: operaciones){
					Calendar fechaOp = new GregorianCalendar();
					Calendar fechaVa = new GregorianCalendar();
					fechaOp.setTime(o.getFechaOperacion());
					fechaVa.setTime(o.getFechaValor());
					query += "('"
							+ o.getNombreOperacion() + "','" + o.getTipoOperacion() + "'," + o.getCuantia() + ",'"
							+ fechaOp.get(Calendar.YEAR) + "-" + (fechaOp.get(Calendar.MONTH) + 1) + "-"
							+ fechaOp.get(Calendar.DATE) + "','" + fechaVa.get(Calendar.YEAR) + "-"
							+ (fechaVa.get(Calendar.MONTH) + 1) + "-" + fechaVa.get(Calendar.DATE) + "',"
							+ cuenta.getCuentaBancariaId() + "),";
				}
				query = query.substring(0, (query.length() - 1));
				query += ";";
				int rows = st.executeUpdate(query);
				if (rows == 13) {
					String queryOp = "SELECT nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor FROM operacion WHERE cuentabancariaid = "
							+ cuenta.getCuentaBancariaId();

					ResultSet rs = st.executeQuery(queryOp);
					List<Operacion> operacionesUpdt = new ArrayList<>();
					while (rs.next()) {
						Operacion operacion = new Operacion();
						operacion.setNombreOperacion(rs.getString(1));
						operacion.setTipoOperacion(rs.getString(2));
						operacion.setCuantia(rs.getBigDecimal(3));
						operacion.setFechaOperacion(rs.getDate(4));
						operacion.setFechaValor(rs.getDate(5));
						operacionesUpdt.add(operacion);
					}
					rs.close();

					sesion.setAttribute("operaciones", operacionesUpdt);

					request.getRequestDispatcher("main.jsp").forward(request, response);

				} else {
					sesion.setAttribute("error", "Ha ocurrido un error al realizar el prestamo");
					request.getRequestDispatcher("prestamo.jsp").forward(request, response);
				}
			} else {
				sesion.setAttribute("error", "Ha ocurrido un error al realizar el prestamo");
			}

		} catch (Exception ex) {
			System.out.println(ex);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}

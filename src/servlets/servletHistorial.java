package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
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
 * Servlet implementation class servletHistorial
 */
@WebServlet("/servletHistorial")
public class servletHistorial extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletHistorial() {
        super();

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession sesion = request.getSession();
			CuentaBancaria cuenta = (CuentaBancaria)sesion.getAttribute("cuenta");
			String fechaInicio="";
			String fechaFin="";
			String query="";
			if(request.getParameter("fechaInicio")!=null){
				fechaInicio=request.getParameter("fechaInicio");
			}
			if(request.getParameter("fechaFin")!=null){
				fechaFin=request.getParameter("fechaFin");
			}
			if(!fechaInicio.isEmpty() && !fechaFin.isEmpty()){
				query = "SELECT nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor FROM operacion WHERE cuentabancariaid="
						+ cuenta.getCuentaBancariaId() + " AND (fechaoperacion BETWEEN '" + fechaInicio + "' AND '"
						+ fechaFin + "')";
			} else if (!fechaInicio.isEmpty() && fechaFin.isEmpty()) {
				query = "SELECT nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor FROM operacion WHERE cuentabancariaid="
						+ cuenta.getCuentaBancariaId() + " AND fechaoperacion>='" + fechaInicio + "'";
			} else if (fechaInicio.isEmpty() && !fechaFin.isEmpty()) {
				query = "SELECT nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor FROM operacion WHERE cuentabancariaid="
						+ cuenta.getCuentaBancariaId() + " AND fechaoperacion<='" + fechaFin + "'";
			} else {
				query = "SELECT nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor FROM operacion WHERE cuentabancariaid="
						+ cuenta.getCuentaBancariaId();
			}
			
			if (!query.isEmpty()) {
				Class.forName("com.mysql.jdbc.Driver");

				Connection con = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/contabilidad?autoReconnect=true&useSSL=false", "admin", "admin");

				Statement st = con.createStatement();

				ResultSet result = st.executeQuery(query);
				List<Operacion> operacionesBusqueda = new ArrayList<>();
				while (result.next()) {
					Operacion o = new Operacion();
					o.setNombreOperacion(result.getString(1));
					o.setTipoOperacion(result.getString(2));
					o.setCuantia(result.getBigDecimal(3));
					o.setFechaOperacion(result.getDate(4));
					o.setFechaValor(result.getDate(5));

					operacionesBusqueda.add(o);
				}
				result.close();

				StringBuilder builder = new StringBuilder();
				double mediaIngresos = 0;
				int contI = 0;
				double mediaGastos = 0;
				int contG = 0;
				for (Operacion o : operacionesBusqueda) {
					builder.append("<tr>");
					builder.append("<td>" + o.getNombreOperacion() + "</td>");
					builder.append("<td>" + o.getTipoOperacion() + "</td>");
					builder.append("<td>" + o.getCuantia() + "</td>");
					builder.append("<td>" + o.getFechaOperacion() + "</td>");
					builder.append("<td>" + o.getFechaValor() + "</td>");
					builder.append("</tr>");
					if (o.getTipoOperacion().equals("Ingreso")) {
						mediaIngresos += o.getCuantia().doubleValue();
						contI++;
					} else {
						mediaGastos += o.getCuantia().doubleValue();
						contG++;
					}
				}
				mediaIngresos = mediaIngresos / contI;
				mediaGastos = mediaGastos / contG;

				sesion.setAttribute("mediaI", mediaIngresos);
				sesion.setAttribute("mediaG", mediaGastos);
				sesion.setAttribute("busqueda", builder);

				request.getRequestDispatcher("historial.jsp").forward(request, response);

			} else {
				System.out.println("Error");
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

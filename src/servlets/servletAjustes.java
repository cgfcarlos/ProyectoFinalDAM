package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hibernate.CuentaBancaria;
import hibernate.Usuario;

/**
 * Servlet implementation class servletAjustes
 */
@WebServlet("/servletAjustes")
public class servletAjustes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletAjustes() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.getRequestDispatcher("ajustes.jsp").forward(request, response);
		} catch (Exception ex) {
			System.out.println(ex.toString());
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession sesion = request.getSession();
			Usuario usuario= (Usuario) sesion.getAttribute("usuario");
			CuentaBancaria cuenta = (CuentaBancaria) sesion.getAttribute("cuenta");
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/contabilidad?autoReconnect=true&useSSL=false", "admin", "admin");

			Statement st = con.createStatement();

			String query = "UPDATE usuario SET dniusuario='" + request.getParameter("dni") + "',nombreusuario='"
					+ request.getParameter("nombre") + "',apellidosusuario='" + request.getParameter("apellidos")
					+ "',nickusuario='" + request.getParameter("nick")
					+ "',passwordusuario='" + request.getParameter("pass") + "',emailusuario='"
					+ request.getParameter("email") + "',tlfusuario='" + request.getParameter("tlf")
					+ "' WHERE nickusuario LIKE '" + usuario.getNickUsuario() + "'";
			
			String queryC = "UPDATE cuentabancaria AS c JOIN usuario as u ON c.usuarioid LIKE u.usuarioid SET titularcuenta='"
					+ request.getParameter("titularCuenta") + "', numerocuenta='" + request.getParameter("numCuenta")
					+ "', entidadcuenta='" + request.getParameter("entidad") + "', tipocuenta='"
					+ request.getParameter("tipoCuenta") + "', bic='" + request.getParameter("bic")
					+ "', paisdomiciliacion='" + request.getParameter("pais") + "' WHERE nickusuario LIKE '"
					+ usuario.getNickUsuario()
					+ "'";

			int rows = st.executeUpdate(query);
			if (rows >= 1) {
				usuario.setDniUsuario(request.getParameter("dni"));
				usuario.setNombreUsuario(request.getParameter("nombre"));
				usuario.setApellidosUsuario(request.getParameter("apellidos"));
				usuario.setNickUsuario(request.getParameter("nick"));
				usuario.setPasswordUsuario(request.getParameter("pass"));
				usuario.setEmailusuario(request.getParameter("email"));
				usuario.setTlfUsuario(request.getParameter("tlf"));
				sesion.setAttribute("usuario", usuario);

				rows = st.executeUpdate(queryC);
				if (rows >= 1) {
					cuenta.setNumeroCuenta(request.getParameter("numCuenta"));
					cuenta.setTitularCuenta(request.getParameter("titularCuenta"));
					cuenta.setEntidadCuenta(request.getParameter("entidad"));
					cuenta.setTipoCuenta(request.getParameter("tipoCuenta"));
					cuenta.setPaisDomiciliacion(request.getParameter("pais"));
					cuenta.setBIC(request.getParameter("bic"));
					sesion.setAttribute("cuenta", cuenta);
					sesion.setAttribute("error", "");
					request.getRequestDispatcher("main.jsp").forward(request, response);
				} else {
					sesion.setAttribute("error", "Error al modificar cuenta");
					request.getRequestDispatcher("ajustes.jsp").forward(request, response);
				}

			} else {
				sesion.setAttribute("error", "Error al modificar usuario");
				request.getRequestDispatcher("ajustes.jsp").forward(request, response);
			}
		} catch (Exception ex) {
			System.out.println(ex.toString());
		}
	}

}

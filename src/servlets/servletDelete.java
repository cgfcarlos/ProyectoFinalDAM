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
 * Servlet implementation class servletDelete
 */
@WebServlet("/servletDelete")
public class servletDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession sesion = request.getSession();
			Usuario usuario = (Usuario) sesion.getAttribute("usuario");
			CuentaBancaria cuenta = (CuentaBancaria) sesion.getAttribute("cuenta");
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/contabilidad?autoReconnect=true&useSSL=false", "admin", "admin");

			Statement st = con.createStatement();

			String query = "DELETE FROM usuario WHERE usuario.nickusuario LIKE '" + usuario.getNickUsuario()
					+ "' OR usuario.emailusuario LIKE '" + usuario.getEmailusuario() + "'";

			int rows = st.executeUpdate(query);

			if (rows == 1) {
				request.getRequestDispatcher("index.jsp").forward(request, response);
			} else {
				sesion.setAttribute("error", "Ha ocurrido un error al borrar el usuario");
				request.getRequestDispatcher("ajustes.jsp").forward(request, response);
			}

		} catch (Exception ex) {
			System.out.println(ex);
		}
	}

}

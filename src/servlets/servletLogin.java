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
import hibernate.Usuario;

//import hibernate.Usuario;
//import utils.HibernateUtils;

/**
 * Servlet implementation class servletInicio
 */
@WebServlet("/servletLogin")
public class servletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		if (request.getParameter("user") != null || request.getParameter("pwd") != null) {
			String user = request.getParameter("user");
			String pass = request.getParameter("pwd");

			List<Operacion> operaciones = new ArrayList<Operacion>();

			/*
			 * int userId = 0; String dni = ""; String nombreUser = ""; String apellidosUser = ""; String nick = "";
			 * String password = ""; String emailUser = ""; String tlfUser = "";
			 */
			// nombreoperacion, tipooperacion, cuantia, fechaoperacion,
		// id dni nom ap nick pass email tlf
		// 1 53195877M Carlos González Fuentes cgfcarlos cgfcarlos carloscrg@hotmail.es 639540920

			try {
				HttpSession sesion = request.getSession();
				Class.forName("com.mysql.jdbc.Driver");

				Connection con = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/contabilidad?autoReconnect=true&useSSL=false", "admin",
						"admin");

				Statement st = con.createStatement();

				String queryU = "SELECT * from usuario WHERE nickusuario LIKE '" + user + "' AND passwordusuario LIKE '"
						+ pass + "'";
				ResultSet resultSet = st.executeQuery(queryU);
				Usuario us = new Usuario();
				String usuario = "";
				while (resultSet.next()) {
					usuario = resultSet.getString(5);
					us.setDniUsuario(resultSet.getString(2));
					us.setNombreUsuario(resultSet.getString(3));
					us.setApellidosUsuario(resultSet.getString(4));
					us.setNickUsuario(resultSet.getString(5));
					us.setPasswordUsuario(resultSet.getString(6));
					us.setEmailusuario(resultSet.getString(7));
					us.setTlfUsuario(resultSet.getString(8));
				}
				resultSet.close();
				if (!usuario.isEmpty()) {
					String queryC = "SELECT cuentabancariaid, titularcuenta, numerocuenta, entidadcuenta, saldo, tipocuenta FROM cuentabancaria JOIN usuario ON cuentabancaria.usuarioid LIKE usuario.usuarioid WHERE nickusuario LIKE '"
							+ user + "' AND passwordusuario LIKE '" + pass + "'";

					resultSet = st.executeQuery(queryC);
					CuentaBancaria cuentaBancaria = new CuentaBancaria();
					while (resultSet.next()) {
						cuentaBancaria.setCuentaBancariaId(resultSet.getInt(1));
						cuentaBancaria.setTitularCuenta(resultSet.getString(2));
						cuentaBancaria.setNumeroCuenta(resultSet.getString(3));
						cuentaBancaria.setEntidadCuenta(resultSet.getString(4));
						cuentaBancaria.setSaldo(resultSet.getBigDecimal(5));
						cuentaBancaria.setTipoCuenta(resultSet.getString(6));
					}
					resultSet.close();

					String query = "SELECT nombreoperacion, tipooperacion, cuantia, fechaoperacion, fechavalor FROM operacion AS o JOIN cuentabancaria AS c ON o.cuentabancariaid LIKE c.cuentabancariaid JOIN usuario AS u on u.usuarioid LIKE c.usuarioid WHERE u.nickusuario LIKE '"
							+ user + "' AND passwordusuario LIKE '" + pass + "'";

					ResultSet rs = st.executeQuery(query);
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

					sesion.setAttribute("operaciones", operaciones);
					sesion.setAttribute("cuenta", cuentaBancaria);
					sesion.setAttribute("usuario", us);
					sesion.setAttribute("user", usuario);
					sesion.setAttribute("pass", pass);
					// request.setAttribute("operaciones", operaciones);
					// request.setAttribute("usuario", us);
					// request.setAttribute("cuenta", cuentaBancaria);
					sesion.setAttribute("error", "");
					request.getRequestDispatcher("main.jsp").forward(request, response);
				}
				else {
					sesion.setAttribute("error", "El usuario o la contraseña son incorrectos");
					request.getRequestDispatcher("index.jsp").forward(request, response);
				}
			} catch (Exception ex) {
				System.out.println(ex);
			}
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="hibernate.Usuario"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="servlets.servletTransaccion" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="ProyectoFinal DAM">
    <meta name="author" content="Carlos Glez Fuentes">
    <title>Página Oficial Carlos González Fuentes</title>
	<!-- core CSS -->
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/owl.carousel.css" rel="stylesheet">
    <link href="css/owl.transitions.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
  
</head><!--/head-->
<body id="home" class="homepage">
	<%
	HttpSession sesion = request.getSession();
	Usuario user = (Usuario) sesion.getAttribute("usuario");
	List<Usuario> usuarios = new ArrayList();
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/contabilidad?autoReconnect=true&useSSL=false", "admin",
			"admin");

	Statement st = con.createStatement();

	String query = "SELECT * FROM usuario";
	
	ResultSet resultSet = st.executeQuery(query);
	
	while (resultSet.next()) {
		Usuario u = new Usuario();
		u.setUsuarioId(resultSet.getInt(1));
		u.setDniUsuario(resultSet.getString(2));
		u.setNombreUsuario(resultSet.getString(3));
		u.setApellidosUsuario(resultSet.getString(4));
		u.setNickUsuario(resultSet.getString(5));
		u.setPasswordUsuario(resultSet.getString(6));
		u.setEmailusuario(resultSet.getString(7));
		u.setTlfUsuario(resultSet.getString(8));
		usuarios.add(u);
	}
	resultSet.close();
	%>
	<header id="header">
	    <nav id="main-menu" class="navbar navbar-default navbar-fixed-top top-nav-collapse" role="banner">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.jsp"><img src="images/logo.png" alt="logo"></a>
                </div>
				
                <div class="collapse navbar-collapse navbar-right">
                    <ul class="nav navbar-nav">
                        <li class="scroll"><a href="main.jsp">Inicio </a></li>
                        <!-- <li class="scroll"><a href="servletGenerarExtracto">Generar Extracto</a></li> -->
                        <!-- <li class="scroll"><a href="#portfolio">Plantilla</a></li>-->
                        <li class="scroll" role="button">
                        	<div class="dropdown-op">
							    <a class="dropdown-toggle color-gray" data-toggle="dropdown">Operaciones
							    <span class="caret"></span></a>
							    <ul class="dropdown-menu dropdown-menu-aux">
							      <li class="dropdown-menu-aux-li"><a class="dropdown-menu-aux-li-a" href="operaciones.jsp">Ingreso/Gasto</a></li>
							      <li class="dropdown-menu-aux-li"><a class="dropdown-menu-aux-li-a" href="prestamo.jsp">Préstamo</a></li>
							      <li class="dropdown-menu-aux-li"><a class="dropdown-menu-aux-li-a" href="transaccion.jsp">Transacción</a></li>
							    </ul>
					  		</div>
                       	</li>
                        <!--<li class="scroll"><a href="#pricing">Conocimientos</a></li>
                        <li class="scroll"><a href="#blog">  Blog </a></li
                        <li class="scroll"><a href="#testimonial"> Testimonial </a></li>-->
                       <li class="scroll active"><a href="ajustes.jsp">Ajustes</a></li>
                       <li class="scroll"><a href="servletLogout">Cerrar sesión</a></li>
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
    </header><!--/header-->
    
    <section id="get-in-touch">

    <h2 class="text-center">Transacción</h2>

    <div class="container">
    	<div class="col-md-6">
    		<div class="row">
    			<h4>Seleccione un cliente:</h4>
    			<hr>
    		</div>
    		<div class="wrap-clientes">
				<article class="ancho100">
					<div class="list-group">
						<%
						for(Usuario us: usuarios){
							if(us.getUsuarioId()!=user.getUsuarioId()){
								String queryC = "SELECT numerocuenta, entidadcuenta FROM cuentabancaria where usuarioid = "+us.getUsuarioId();
								
								ResultSet resultSet2 = st.executeQuery(queryC);
								String numerocuenta="";
								String entidad="";
								while (resultSet2.next()) {
									numerocuenta=resultSet2.getString(1);
									entidad=resultSet2.getString(2);
								}
								resultSet2.close();
								
						%>
								<button type="submit" name="beneficiario" class="list-group-item list-group-item-aux" onclick="selectBeneficiary(this)" value="<%=us.getNombreUsuario()+" "+us.getApellidosUsuario()+";"+numerocuenta+";"+entidad%>"><%=us.getNombreUsuario()+" "+us.getApellidosUsuario()%></button>
						<%	
							}
						}
						%>
					</div>
				</article>
			</div>
    	</div>
    	<div class="col-md-6">
    		<div class="row">
    			<h4>Datos:</h4>
    			<hr>
    		</div>
    		<form action="servletTransaccion" method="post" onsubmit="return validateTransaccion();">
    			<div class="row">
    				<label for="beneficiario">Beneficiario</label>
    				<input type="text" name="beneficiario" id="beneficiario" class="form-control" placeholder="Nombre del beneficiario" disabled="disabled">
    			</div>
    			<div class="row">
    				<label for="banco">Banco</label>
    				<input type="text" name="banco" id="banco" class="form-control" placeholder="Nombre entidad Bancaria" disabled="disabled">
    			</div>
    			<div class="row">
    				<label for="numcuenta">Número de cuenta</label>
    				<input type="text" class="form-control" name="numcuenta" id="numcuenta" placeholder="Cuenta Bancaria" disabled="disabled">
    			</div>
    			<div class="row">
    				<label for="concepto">Concepto</label>
    				<input type="text" name="concepto" id="concepto" class="form-control" placeholder="Descripción">
    			</div>
    			<div class="row">
    				<label for="importe">Importe</label>
    				<input type="number" name="importe" id="importe" class="form-control" placeholder="Cuantía" onkeypress="return validateNumber(this,event);">
    			</div>
    			<div class="row text-center" style="padding-top: 1em;">
    				<input type="submit" name="transaccion" class="btn btn-primary" value="Realizar Transacción">
    			</div>
    		</form>
    	</div>
    </div>

    </section>

    <div><br></div>

     <footer id="footer">
        <div class="container text-center">
          Todos los derechos reservados © 2017 | <a href="#">Carlos González Fuentes</a>
        </div>
    </footer><!--/#footer-->

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/mousescroll.js"></script>
    <script src="js/smoothscroll.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/jquery.isotope.min.js"></script>
    <script src="js/jquery.inview.min.js"></script>
    <script src="js/wow.min.js"></script>
    <script src="js/main.js"></script>
    <script src="js/second.js"></script>
    <script src="js/scrolling-nav.js"></script>
</body>
</html>
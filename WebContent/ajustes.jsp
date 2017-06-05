<%@page import="hibernate.Usuario"%>
<%@page import="hibernate.CuentaBancaria"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="servlets.servletAjustes" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="ProyectoFinal DAM">
    <meta name="author" content="Carlos Glez Fuentes">
    <title>Página Oficial Carlos González Fuentes</title>
	<!-- core CSS -->
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
	%>
	
	<%if(sesion.getAttribute("error")!=null && sesion.getAttribute("error")!=""){ %>
		<div class="modal" id="errorajustesModal" tabindex="-1" style="display: block;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal" onclick="dismiss()">&times;</button>
                    <h4 class="modal-title">Iniciar sesión</h4>

                </div>
                <form method="get">
                	<div class="modal-body">
                        <div class="alert alert-danger text-center"><%=sesion.getAttribute("error").toString()%></div>
                	</div>
	                <div class="modal-footer">
	                    <input type="submit" class="btn btn-primary" value=">Aceptar"/>
	                </div>
               	</form>
                	<script type="text/javascript">
                	function dismiss()
                	{
                		<%sesion.removeAttribute("error");%>
                	    document.getElementById('errorajustesModal').setAttribute("style", "dysplay:none;");
                	}
                	</script>
            </div>
        </div>
    </div>
	<%} %>
	<div class="modal" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Advertencia!</h4>

                </div>
                <div class="modal-body">
                    <form method="post" action="servletDelete">
                    	<div class="form-group">
                    		<label class="form-control text-center" for="delete">¿Desea borrar el usuario?</label>
                    	</div>
		                <div class="modal-footer">
		                    <input name="delete" type="submit" class="btn btn-primary" value="Borrar"/>
		                    <button class="btn btn-primary" data-dismiss="modal">Cerrar</button>
		                </div>
                	</form>
            	</div>
        	</div>
    	</div>
    </div>
	
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
                        <li class="scroll"><a href="#portfolio">Plantilla</a></li>
                        <li class="scroll"><a href="#meet-team">Operaciones</a></li>
                        <!--<li class="scroll"><a href="#pricing">Conocimientos</a></li>
                        <li class="scroll"><a href="#blog">  Blog </a></li
                        <li class="scroll"><a href="#testimonial"> Testimonial </a></li>-->
                       <li class="scroll active"><a href="#get-in-touch">Ajustes</a></li>
                       <li class="scroll"><a href="servletLogout">Cerrar sesión</a></li>
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
    </header><!--/header-->
    
    <section id="get-in-touch">
    	<div class="container">
    		<h2 class="text-center">Ajustes de la cuenta</h2>
    		<form action="servletAjustes" method="post">
    			<%
    				Usuario usuario = (Usuario) sesion.getAttribute("usuario");
    				CuentaBancaria cuentaBancaria = (CuentaBancaria) sesion.getAttribute("cuenta");
    			%>
    			<%if(request.getAttribute("error")!=null){ %>
				<div class="row text-center">
					<span class="alert alert-danger"><%=request.getAttribute("error") %></span>
				</div>
				<%} %>
    			<div class="col-md-6">
					<fieldset>
						<legend>Datos Personales</legend>
						<div class="form-group">
							<input class="form-control" required type="text" name="nombre" placeholder="Nombre" value="<%=usuario.getNombreUsuario()%>">
							<input class="form-control" required type="text" name="apellidos" placeholder="Apellidos" value="<%=usuario.getApellidosUsuario()%>">
						</div>
						<div class="form-group">
							<input class="form-control" required type="text" name="dni" placeholder="DNI" value="<%=usuario.getDniUsuario()%>">
							<input class="form-control" required type="tel" name="tlf" placeholder="Teléfono" value="<%=usuario.getTlfUsuario()%>">
						</div>
						<div class="form-group">
							<input class="form-control" required type="email" name="email" placeholder="Email" value="<%=usuario.getEmailusuario()%>">
						</div>
						<div class="form-group">
							<input class="form-control" required type="text" name="nick" placeholder="Usuario" value="<%=usuario.getNickUsuario()%>">
							<input class="form-control" required type="password" name="pass" data-toggle="password" placeholder="Contraseña" value="<%=usuario.getPasswordUsuario()%>">
						</div>
					</fieldset>
    			</div>
    			<div class="col-md-6">
    				<fieldset>
						<legend>Datos Bancarios</legend>
						<div class="form-group">
							<input class="form-control" required type="text" name="numCuenta" placeholder="Numero de cuenta" value="<%=cuentaBancaria.getNumeroCuenta()%>">
						</div>
						<div class="form-group">
							<input class="form-control" required type="text" name="titularCuenta" placeholder="Titular" value="<%=cuentaBancaria.getTitularCuenta()%>">
							<input class="form-control" required type="text" name="entidad" placeholder="Entidad Bancaria" value="<%=cuentaBancaria.getEntidadCuenta()%>">
						</div>
						<div class="form-group">
							<select class="form-control" name="tipoCuenta" name="tipoCuenta">
								<option>Corriente</option>
								<option>Ahorros</option>
							</select>
						</div>
						<div class="form-group">
							<input class="form-control" required type="text" name="pais" placeholder="Pais Domiciliación" value="<%=cuentaBancaria.getPaisDomiciliacion()%>">
						</div>
						<div class="form-group">
							<input class="form-control" required type="text" name="bic" placeholder="BIC" value="<%=cuentaBancaria.getBIC()%>">
						</div>
						<div class="form-group">
							<input class="form-control" disabled required type="number" name="saldo" placeholder="Saldo" value="<%=cuentaBancaria.getSaldo()%>">
						</div>
					</fieldset>
    			</div>
    			<div class="form-group text-center">
						<input class="btn btn-primary" type="submit" name="crear" value="Guardar Cambios">
						<button data-target="#deleteModal" data-toggle="modal">Borrar Usuario</button>
				</div>
   			</form>
    	</div>
    </section>

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
		<script src="js/scrolling-nav.js"></script>
	<script>
	
	    $(document).ready(function($) {
	      $("#owl-example").owlCarousel();
	    });
	
	    $("body").data("page", "frontpage");
	
		$("#owl-example").owlCarousel({ 
		        items:3,   
		/*        itemsDesktop : [1199,3],
		        itemsDesktopSmall : [980,9],
		        itemsTablet: [768,5],
		        itemsTabletSmall: false,
		        itemsMobile : [479,4]*/
		});

    </script>

</body>
</html>
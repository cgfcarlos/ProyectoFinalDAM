<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="servlets.servletRegistro" %>
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
                        <li class="scroll active"><a href="index.jsp">Inicio </a></li>
                        <!--<li class="scroll"><a href="#services">Generar Extracto</a></li>
                        <li class="scroll"><a href="#portfolio">Plantilla</a></li>
                        <li class="scroll"><a href="#meet-team">Operaciones</a></li>
                        <li class="scroll"><a href="#pricing">Conocimientos</a></li>
                        <li class="scroll"><a href="#blog">  Blog </a></li
                        <li class="scroll"><a href="#testimonial"> Testimonial </a></li>
                       <li class="scroll"><a href="#get-in-touch">Ajustes</a></li>-->
                       
                       <!-- TODO: Cambiar los href de los enlaces del menu! -->
                       
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
    </header><!--/header-->
	
	<section id="get-in-touch">
		<div class="container">
			<div class="row">
				<h2 class="text-center">Crear una cuenta</h2>
			</div>
			<%if(request.getAttribute("error")!=null && request.getAttribute("error")!=""){ %>
			<div class="row text-center">
				<span class="alert alert-danger"><%=request.getAttribute("error") %></span>
			</div>
			<%} %>
			<!-- nombre, apellidos, dni, cuentaBancaria, nick, contraseña, email, tlf -->
			<form action="servletRegistro" method="post">
				<fieldset>
					<legend>Datos Personales</legend>
					<div class="form-group">
						<input class="form-control" required type="text" name="nombre" placeholder="Nombre">
						<input class="form-control" required type="text" name="apellidos" placeholder="Apellidos">
					</div>
					<div class="form-group">
						<input class="form-control" required type="text" name="dni" placeholder="DNI">
						<input class="form-control" required type="tel" name="tlf" placeholder="Teléfono">
					</div>
					<div class="form-group">
						<input class="form-control" required type="email" name="email" placeholder="Email">
					</div>
					<div class="form-group">
						<input class="form-control" required type="text" name="nick" placeholder="Usuario">
						<input class="form-control" required type="password" name="pass" placeholder="Contraseña">
					</div>
				</fieldset>
				<fieldset>
					<legend>Datos Bancarios</legend>
					<div class="form-group">
						<input class="form-control" required type="text" name="numCuenta" placeholder="Numero de cuenta">
					</div>
					<div class="form-group">
						<input class="form-control" required type="text" name="titularCuenta" placeholder="Titular">
						<input class="form-control" required type="text" name="entidad" placeholder="Entidad Bancaria">
					</div>
					<div class="form-group">
						<select class="form-control" name="tipoCuenta" name="tipoCuenta">
							<option>Corriente</option>
							<option>Ahorros</option>
						</select>
					</div>
					<div class="form-group">
						<input class="form-control" required type="text" name="pais" placeholder="Pais Domiciliación">
					</div>
					<div class="form-group">
						<input class="form-control" required type="text" name="bic" placeholder="BIC">
					</div>
					<div class="form-group">
						<input class="form-control" required type="number" name="saldo" placeholder="Saldo" onkeypress="validateNumber(this, evt)">
					</div>
					<div class="form-group text-center">
						<input class="btn btn-primary" type="submit" name="crear" value="Crear cuenta">
					</div>
				</fieldset>
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
	    <script src="js/second.js"></script>
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
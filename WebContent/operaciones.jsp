<%@page import="hibernate.Usuario"%>
<%@page import="hibernate.CuentaBancaria"%>
<%@page import="hibernate.Operacion" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    		<h2 class="text-center">Realizar Operación</h2>
    		<%if(sesion.getAttribute("error")!=null && sesion.getAttribute("error")!=""){ %>
    		<div class="alert alert-danger text-center"><%=sesion.getAttribute("error").toString()%></div>
    		<%sesion.removeAttribute("error");%>
    		<%} %>
    		<form action="servletOperaciones" method="post">
    			<%
    				
    				Usuario usuario = (Usuario) sesion.getAttribute("usuario");
    				CuentaBancaria cuentaBancaria = (CuentaBancaria) sesion.getAttribute("cuenta");
    				Operacion operacion = new Operacion();
    			%>
    			<%if(request.getAttribute("error")!=null){ %>
				<div class="row text-center">
					<span class="alert alert-danger"><%=request.getAttribute("error") %></span>
				</div>
				<%} %>
				<div class="form-group">
					<input class="form-control" name="nombreOperacion" type="text" placeholder="Nombre Operación" maxlength="20">
				</div>
				<div class="form-group">
					<select class="form-control" name="tipoOperacion">
						<option>Ingreso</option>
						<option>Gasto</option>
					</select>
				</div>
				<div class="form-group">
					<input class="form-control" name="cuantia" type="number" placeholder="Cuantía" maxlength="9"> 
				</div>
				<div class="form-group">
					<input class="form-control" name="fechaOperacion" type="date" placeholder="Fecha Operación">
				</div>
				<div class="form-group">
					<input class="form-control" name="fechaValor" type="date" placeholder="Fecha Valor">
				</div>
				<div class="form-group text-center">
					<input class="btn btn-primary" name="submit" type="submit" value="Aceptar">
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
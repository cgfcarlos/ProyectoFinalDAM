<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="servlets.servletPrestamo" %>
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
                        <li class="scroll"><a href="main.jsp">Inicio </a></li>
                        <li class="scroll"><a href="#portfolio">Plantilla</a></li>
                        <li class="scroll"><a href="operaciones.jsp">Operaciones</a></li>
                       <li class="scroll active"><a href="ajustes.jsp">Ajustes</a></li>
                       <li class="scroll"><a href="servletLogout">Cerrar sesión</a></li>
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
    </header><!--/header-->
    
    <section id="get-in-touch">
        <h2 class="text-center">Préstamos</h2>
        <div class="container">
            <a data-toggle="popover" data-placement="top" data-content="Un préstamo bancario es el crédito que concede un banco. La ganancia del banco estará en que, al devolver el dinero, la persona tendrá que entregar un adicional en concepto de intereses." onclick="displayPopover()"><span class="glyphicon glyphicon-info-sign"></span></a>
            <div class="row">
                <div class="col-md-6">
                    <span>Capital (Montante)</span>
                    <input class="form-control" type="number" name="capital" id="capital" >
                </div>
                <div class="col-md-6">
                    <span>Interés</span>
                    <select class="form-control" id="interes" name="interes">
                        <option>3%</option>
                        <option>4%</option>
                        <option>5%</option>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <span>Número de cuotas</span>
                    <input class="form-control disabled" id="numcuotas" disabled="disabled" type="number" name="numcuotas" value="12">
                </div>
                <div class="col-md-6">
                    <span>Forma de pago</span>
                    <input class="form-control disabled" id="pago" disabled="disabled" type="text" name="pago" value="Mensual">
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <span>Fecha de Concesión</span>
                    <input class="form-control" id="fechaconcesion" type="date" name="fechaconcesion" >
                </div>
                <div class="col-md-6">
                    <span>Fecha de Finalización</span>
                    <input class="form-control" id="fechafinalizacion" type="date" name="fechafinalizacion">
                </div>
            </div>
            <div class="row"><br></div>
            <div class="row">
                <small>*Nota: Calcular muestra una tabla con la amortización del préstamo. Realizar Prestamo realiza la operacion de ingresos y gastos en la cuenta (sin calcular el saldo restante)</small>
            </div>
            <div class="row"><br></div>
            <div class="row text-center">
                <button class="btn btn-primary" onclick="amortizacion()">Calcular</button>
            </div>
            <div class="row"><br></div>
            <div class="row">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Num Pagos</th>
                            <th>Amortización</th>
                            <th>Anualidad</th>
                            <th>Capital Amortizado</th>
                            <th>Capital Pendiente</th>
                            <th>Intereses</th>
                        </tr>
                    </thead>
                    <tbody id="table">
                        
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <div class="row text-center">
                <form action="servletPrestamo" method="get" onsubmit="return validatePrestamo();">
                    <input type="submit" class="btn btn-primary"  value="Realizar Préstamo" id="realizarPrestamo" disabled="disabled">
                </form>
            </div>
            <div class="row">
                <small>*Nota: En el cálculo de la amortización el capital pendiente de la última fila siempre queda aproximado a 0</small>
            </div>
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
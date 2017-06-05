<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="servlets.servletLogin" %>
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
	if(sesion.getAttribute("error")!=null && sesion.getAttribute("error")!=""){
	%>
	<div class="modal" id="errorloginModal" tabindex="-1" style="display: block;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal" onclick="dismiss()">&times;</button>
                    <h4 class="modal-title">Iniciar sesión</h4>

                </div>
                <form method="get" action="servletLogin">
                <div class="modal-body">
                    
                        <div class="form-group">
                            <label for="user">Usuario</label>
                            <input type="text" name="user" class="form-control" placeholder="Usuario" id="user">
                        </div>
                        <div class="form-group">
                            <label for="pwd">Contraseña</label>
                            <input type="password" name="pwd" class="form-control" id="pwd" placeholder="Contraseña" data-toggle="password">
                        </div>
                        <div class="form-group text-center">
                        	<a href="registro.jsp">Crear una cuenta</a>
                        </div>
                        <div class="alert alert-danger text-center"><%=sesion.getAttribute("error").toString()%></div>
		                </div>
		                <div class="modal-footer">
		                    <input type="submit" class="btn btn-primary" value="Entrar"/>
		                </div>
                	</form>
                	<%sesion.setAttribute("error","");%>
                	<script type="text/javascript">
                	function dismiss()
                	{
                		
                	    document.getElementById('errorloginModal').setAttribute("style", "dysplay:none;");
                	}
                	</script>
            </div>
        </div>
    </div>
	<%} %>

    <div class="modal" id="loginModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Iniciar sesión</h4>

                </div>
                <form method="get" action="servletLogin">
                <div class="modal-body">
                    
                        <div class="form-group">
                            <label for="user">Usuario</label>
                            <input type="text" name="user" class="form-control" placeholder="Usuario" id="user">
                        </div>
                        <div class="form-group">
                            <label for="pwd">Contraseña</label>
                            <input type="password" name="pwd" class="form-control" id="pwd" placeholder="Contraseña" data-toggle="password">
                        </div>
                        <div class="form-group text-center">
                        	<a href="registro.jsp">Crear una cuenta</a>
                        </div>
		                </div>
		                <div class="modal-footer">
		                    <input type="submit" class="btn btn-primary" value="Entrar"/>
		                    <button class="btn btn-primary" data-dismiss="modal">Cerrar</button>
		                </div>
                	</form>
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
                        <li class="scroll active"><a href="index.jsp">Inicio </a></li>
                        <li class="scroll"><a href="#services">Servicios </a></li>
                        <li class="scroll"><a href="#portfolio">Trabajos</a></li>
                        <li class="scroll"><a href="#meet-team">Equipo </a></li>
                        <!--<li class="scroll"><a href="#pricing">Conocimientos</a></li>
                        <li class="scroll"><a href="#blog">  Blog </a></li
                        <li class="scroll"><a href="#testimonial"> Testimonial </a></li>-->
                       <li class="scroll"><a href="#get-in-touch">Contacta</a></li>
                       <li class="login">
                       	<form method="get" action="servletLogin">
                       		<input type="text" name="user" placeholder="Usuario" class="form-control-menu form-control">
                       		<input type="password" name="pwd" id="pwd" placeholder="Contraseña" class="form-control-menu form-control">
                       		<input type="submit" name="submit" class="btn btn-primary" value="Entrar">
                       		<div class="row">
                       			<a href="registro.jsp">Crear una cuenta</a>
                       		</div>
                        </form>
                       </li>                        
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
    </header><!--/header-->

    <section id="main-slider">
        <div class="owl-carousel">
            <div class="item" style="background-image: url(images/bg1.jpg);">
                <div class="slider-inner">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-12 text-center">
                                <div class="carousel-content">
                                    <h2>Inicia Sesión en nuestra Web</h2>
                                    <p>Inicia sesión en nuestra página y comienza a explorar nuestras funcionalidades <br> para ello simplemente necesitas introducir tu email y contraseña de usuario</p>
                                    <button class="btn btn-primary btn-lg" data-target="#loginModal" data-toggle="modal">Iniciar Sesión</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/.item-->
             <div class="item" style="background-image: url(images/bg2.png);">
                <div class="slider-inner">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-12 text-center">
                                <div class="carousel-content">
                                    <h2>Descárgate nuestra aplicación de escritorio</h2>
                                    <p>Si prefieres siempre puedes descargar nuestra aplicación<br>

en la cual puedes disfrutar de las mismas funcionalidades que en la web :D</p>
                                    <a class="btn btn-primary btn-lg" href="#">Descargar App</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/.item-->
        </div><!--/.owl-carousel-->
    </section><!--/#main-slider-->

    

	<section id="services" >
        <div class="container">

            <div class="section-header">
                <h2 class="section-title text-center wow fadeInDown">Nuestros Servicios</h2>
                <p class="text-center wow fadeInDown">La web esta dispuesta para simular la contabilidad de cuentas bancarias de una persona de a pie, <br> además ofrecemos mas funcionalidades para su disfrute</p>
            </div>

            <div class="row">
                <div class="features">
                    <div class="col-md-4 col-sm-6 wow fadeInUp" data-wow-duration="300ms" data-wow-delay="0ms">
                        <div class="media service-box">
                            <div class="pull-left">
                                <img src="images/icon1.png" alt="img">
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">Extractos bancarios</h4>
                                <p>Una de las principales funciones de nuestra web es simular los extractos bancarios de una cuenta bancaria
                                al seleccionar esta opción se generará un archivo PDF simulando la documentación que una persona recibe cuando le llega un extracto del banco .</p>
                            </div>
                        </div>
                    </div><!--/.col-md-4-->

                    <div class="col-md-4 col-sm-6 wow fadeInUp" data-wow-duration="300ms" data-wow-delay="100ms">
                        <div class="media service-box">
                            <div class="pull-left">
                                <img src="images/icon2.png" alt="img">
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">Plantilla de gastos</h4>
                                <p>A mayores permitimos al usuario crear una plantilla de gastos para calcular
                                los ingresos y gastos de un mes mediante una lista de ingresos y gastos
                                predefinidos por la propia web .</p>
                            </div>
                        </div>
                    </div><!--/.col-md-4-->

                    <div class="col-md-4 col-sm-6 wow fadeInUp" data-wow-duration="300ms" data-wow-delay="200ms">
                        <div class="media service-box">
                            <div class="pull-left">
                                <img src="images/icon3.png" alt="img">
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">Cálculo de préstamos</h4>
                                <p>Disponemos de una sección para calcular la amortización de un prestamo
                                bancario, además si acepta la operación se almacenarán en la base de datos los correspondientes
                                gastos (hasta que no se realice el extracto no se calcula el balance de la cuenta) .</p>
                            </div>
                        </div>
                    </div><!--/.col-md-4-->
                
                    <div class="col-md-4 col-sm-6 wow fadeInUp" data-wow-duration="300ms" data-wow-delay="300ms">
                        <div class="media service-box">
                            <div class="pull-left">
                               <img src="images/icon4.png" alt="img">
                            </div>
                            <div class="media-body">
                               <h4 class="media-heading">Mostrar estadísticas mensuales</h4>
                                <p>En el apartado de información del usuario se mostrarán gráficos para mostrar las estadísticas
                                de ingresos y gastos del usuario .</p>
                            </div>
                        </div>
                    </div><!--/.col-md-4-->

                    <div class="col-md-4 col-sm-6 wow fadeInUp" data-wow-duration="300ms" data-wow-delay="400ms">
                        <div class="media service-box">
                            <div class="pull-left">
                               <img src="images/icon5.png" alt="img">
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">Historial de extractos</h4>
                                <p>Mostramos información de todos los ingresos y gastos realizados por el usuario, en esta sección el usuario
                                puede filtrar la busqueda y descargar un PDF con el resultado de ingresos y gastos en función del filtrado .</p>
                            </div>
                        </div>
                    </div><!--/.col-md-4-->

                    <div class="col-md-4 col-sm-6 wow fadeInUp" data-wow-duration="300ms" data-wow-delay="500ms">
                        <div class="media service-box">
                            <div class="pull-left">
                                <img src="images/icon6.png" alt="img">
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">Gestión de cuentas</h4>
                                <p>Si el usuario desea dejar de simular la gestión de alguna de sus cuentas en el apartado de ajustes puede 
                                desvincular las cuentas u añadir nuevas etc.</p>
                            </div>
                        </div>
                    </div><!--/.col-md-4-->
                </div>
            </div><!--/.row-->    
        </div><!--/.container-->
    </section><!--/#services-->
    
    <!--<section id="animated-number">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title text-center wow fadeInDown">Detalles</h2>
                <p class="text-center wow fadeInDown">Este trabajo fue originado debido  <br> et dolore magna aliqua. Ut enim ad minim veniam</p>
            </div>

            <div class="row text-center">
                <div class="col-sm-3 col-xs-6">
                    <div class="wow fadeInUp" data-wow-duration="400ms" data-wow-delay="0ms">
                        <div class="animated-number" data-digit="136800" data-duration="1000"></div>
                        <strong>Lorem Ipsum</strong>
                    </div>
                </div>
                <div class="col-sm-3 col-xs-6">
                    <div class="wow fadeInUp" data-wow-duration="400ms" data-wow-delay="100ms">
                        <div class="animated-number" data-digit="1231+" data-duration="1000"></div>
                        <strong>Lorem Ipsum</strong>
                    </div>
                </div>
                <div class="col-sm-3 col-xs-6">
                    <div class="wow fadeInUp" data-wow-duration="400ms" data-wow-delay="200ms">
                        <div class="animated-number" data-digit="6000" data-duration="1000"></div>
                        <strong>Lorem Ipsum</strong>
                    </div>
                </div>
                <div class="col-sm-3 col-xs-6">
                    <div class="wow fadeInUp" data-wow-duration="400ms" data-wow-delay="300ms">
                        <div class="animated-number" data-digit="2000" data-duration="1000"></div>
                        <strong>Lorem Ipsum</strong>
                    </div>
                </div>
            </div>
        </div>
    </section>--><!--/#animated-number-->
    
        <section id="portfolio">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title text-center wow fadeInDown">Últimos trabajos</h2>
                <p class="text-center wow fadeInDown">A continuación le mostramos los últimos trabajos realizados por Carlos González Fuentes todos ellos realizados  <br> en el ámbito de la infórmatica</p>
            </div>

            <div class="text-center">
                <ul class="portfolio-filter">
                    <li><a class="active" href="#" data-filter="*">Todo</a></li>
                    <li><a href="#" data-filter=".creative">Aplicaciones</a></li>
                    <li><a href="#" data-filter=".portfolio">Juegos </a></li>
                </ul><!--/#portfolio-filter-->
            </div>

            <div class="portfolio-items">
                <!--<div class="portfolio-item creative">
                    <div class="portfolio-item-inner">
                        <img class="img-responsive" src="images/work_1.jpg" alt="">
                        <div class="portfolio-info">
                            <h3>Contabilidad CGF</h3>
                            Aplicación de escritorio en Visual Studio (C#) <br>
                            Simula la gestión de cuentas bancarias
                            
                        </div>
                    </div>
                </div>--><!--/.portfolio-item-->

                <div class="portfolio-item corporate portfolio">
                    <div class="portfolio-item-inner">
                        <img class="img-responsive" src="images/work_2.jpg" alt="">
                        <div class="portfolio-info">
                            <h3>The Outlaw - Vigilante</h3>
                            Juego en Unity (C#) <br>
                            Genero: Plataformas
                            
                        </div>
                    </div>
                </div><!--/.portfolio-item-->

                <div class="portfolio-item creative">
                    <div class="portfolio-item-inner">
                        <img class="img-responsive" src="images/work_3.jpg" alt="">
                        <div class="portfolio-info">
                            <h3>Centro Médico App</h3>
                            Aplicación en Android Studio (Java) <br>
                            Gestor de citas
                            
                        </div>
                    </div>
                </div><!--/.portfolio-item-->

                <!--<div class="portfolio-item corporate">
                    <div class="portfolio-item-inner">
                        <img class="img-responsive" src="images/work_4.jpg" alt="">
                        <div class="portfolio-info">
                            <h3>TPV Minus</h3>
                            Aplicación en Visual Studio (C#)<br>
                            Punto de venta de una tienda genérica                             
                        </div>
                    </div>
                </div>--><!--/.portfolio-item-->

                <div class="portfolio-item creative portfolio">
                    <div class="portfolio-item-inner">
                        <img class="img-responsive" src="images/work_5.jpg" alt="">
                        <div class="portfolio-info">
                            <h3>Hundir la Flota (C#)</h3>
                            Juego en interfaz gráfica de Visual Studio<br>
                            Arquitectura Cliente - Servidor (TCP)
                            
                        </div>
                    </div>
                </div><!--/.portfolio-item-->

                <!--<div class="portfolio-item corporate">
                    <div class="portfolio-item-inner">
                        <img class="img-responsive" src="images/work_6.jpg" alt="">
                        <div class="portfolio-info">
                            <h3>Trabajo 6</h3>
                            Lorem Ipsum Dolor Sit
                           
                        </div>
                    </div>
                </div>--><!--/.portfolio-item-->

                <div class="portfolio-item creative portfolio">
                    <div class="portfolio-item-inner">
                        <img class="img-responsive" src="images/work_7.jpg" alt="">
                        <div class="portfolio-info">
                            <h3>Tower Defense</h3>
                            Juego Unity (C#)<br>
                            Género: Defender

                            
                        </div>
                    </div>
                </div><!--/.portfolio-item-->

                <div class="portfolio-item corporate">
                    <div class="portfolio-item-inner">
                        <img class="img-responsive" src="images/work_8.jpg" alt="">
                        <div class="portfolio-info">
                            <h3>Calendario Deportivo</h3>
                            Aplicación en Visual Studio (C#)<br>
                            Cálcula los partidos y la clasificación de una liga
                           
                        </div>
                    </div>
                </div><!--/.portfolio-item-->
            </div>
        </div><!--/.container-->
    </section><!--/#portfolio-->
    
    <section id="meet-team">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title text-center wow fadeInDown">Equipo</h2>
                <p class="text-center wow fadeInDown">A continuación se describirá brevemente los conocimietos del equipo creador de la página</p>
            </div>

            <div class="row">
                <div class="col-sm-6 col-md-3">
                    <div class="team-member wow fadeInUp" data-wow-duration="400ms" data-wow-delay="0ms">
                        <div class="team-img">
                            <img src="images/team_1.jpg" alt="">
                        </div>
                        <div class="team-info">
                            <h3>Carlos González Fuentes</h3>
                            <span>Fundador</span>
                        </div>
                        
                        
                    </div>
                </div>
                <div class="col-sm-9 col-md-8">
                    <h3>Conocimientos</h3>
                    <ul>
                        <li>Lenguajes de Programación: Java y C#.</li>
                        <li>Lenguajes Programación Web: HTML5, CSS3, JavaScript.</li>
                        <li>Lenguajes de Bases de Datos: SQL Server, MySQL, SQLite.</li>
                        <li>IDE's empleados: Visual Studio 2015, NetBeans, Eclipse, Android Studio, Unity, Xamarín.</li>
                    </ul>
                </div>
            </div>
        </div>
	</section>
    
    <section id="get-in-touch">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title text-center wow fadeInDown">CONTACTO</h2>
                <p class="text-center wow fadeInDown">Información de como contactar con <br> el fundador de la página web</p>
            </div>
            
            <div class="row">
            <div class="col-sm-6">
            <div class="address">
            <h4>Dirección</h4>
            <p>C/ Camino Caneiro nº21, 1ºA - Galicia, Ourense</p>
            </div>
            
            <div class="address">
            <h4>Teléfono </h4>
            <p>639540920</p>
            </div>
            
            <div class="address">
            <h4>Email</h4>
            <p><a href="#">carloscrg@hotmail.es </a></p>
            </div>
            
            <div class="address">
            <h4>Sígueme en</h4>
            <p><a href="https://www.facebook.com/carlos.gonzalezfuentes1" target="_blank"><i class="fa fa-facebook"></i></a>  &nbsp; <a href="https://twitter.com/CGF_Carlos" target="_blank"><i class="fa fa-twitter"></i></a> &nbsp; <a href="https://plus.google.com/u/0/106282230883310858469" target="_blank"><i class="fa fa-google-plus"></i></a></p>
            </div>
            </div>
            
            <div class="col-sm-6">
            
            	<form action="mailto:carloscrg@hotmail.es" method="post" name="contact-form" id="main-contact-form">
	                <div class="form-group">
	                    <input type="text" required placeholder="Nombre" class="form-control" name="name">
                    </div>
                    <div class="form-group">
	                    <input type="email" required placeholder="Email" class="form-control" name="email">
                    </div>
                    <div class="form-group">
	                    <input type="text" required placeholder="Titulo" class="form-control" name="subject">
                    </div>
                    <div class="form-group">
	                    <textarea required placeholder="Mensaje" rows="8" class="form-control" name="message"></textarea>
                    </div>
                    <input class="btn btn-primary" type="submit" value="Enviar"/>
             	</form>
           	 </div>
            
            
            </div>
            
            
        </div>
    </section><!--/#get-in-touch-->




    <footer id="footer">
        <div class="container text-center">
          Todos los derechos reservados © 2017 | <a href="#">Carlos González Fuentes</a>
        </div>
    </footer><!--/#footer-->

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-show-password/1.0.3/bootstrap-show-password.min.js"></script>
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
	<script type="text/javascript">
       	$("#pwd").password('toggle');
   	</script>
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
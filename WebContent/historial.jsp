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
	double mediaGastos=0;
	double mediaIngresos=0;
	if(sesion.getAttribute("mediaG")!=null && sesion.getAttribute("mediaI")!=null){
		mediaGastos=Double.valueOf(sesion.getAttribute("mediaG").toString());
		mediaIngresos=Double.valueOf(sesion.getAttribute("mediaI").toString());
	}
	
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
                        <li class="scroll"><a href="index.jsp">Inicio </a></li>
                        <li class="scroll"><a href="#services">Generar Extracto</a></li>
                        <li class="scroll active" role="button">
                            <div class="dropdown-op">
                                <a class="dropdown-toggle color-gray" data-toggle="dropdown">Operaciones
                                <span class="caret"></span></a>
                                <ul class="dropdown-menu dropdown-menu-aux">
                                  <li class="dropdown-menu-aux-li"><a class="dropdown-menu-aux-li-a" href="operaciones.jsp">Ingreso/Gasto</a></li>
                                  <li class="dropdown-menu-aux-li"><a class="dropdown-menu-aux-li-a" href="prestamo.jsp">Préstamo</a></li>
                                  <li class="dropdown-menu-aux-li"><a class="dropdown-menu-aux-li-a" href="transaccion.jsp">Transacción</a></li>
                                  <li class="dropdown-menu-aux-li"><a class="dropdown-menu-aux-li-a" href="historial.jsp">Historial</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="scroll"><a href="ajustes.jsp">Ajustes</a></li>
                        <li class="scroll"><a href="servletLogout">Cerrar sesión</a></li>
                       
                       
                       
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
    </header><!--/header-->

    <section id="get-in-touch">
        <div class="container">
            <h2 class="text-center">Historial de Operaciones</h2>
            <form action="servletHistorial" method="get">
	            <div class="col-sm-6">
	                <div class="row">
	                    <input type="date" id="fechaInicio" name="fechaInicio" class="form-control inpt-hist" placeholder="Fecha Inicio">
	                    <input type="date" id="fechaFin" name="fechaFin" class="form-control inpt-hist" placeholder="Fecha Fin">
	                    <button class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
	                </div>
	                <div class="row"><br></div>
	                <div class="row">
	                    <table class="table table-bordered">
	                        <thead>
	                            <tr>
	                                <th>Nombre</th>
	                                <th>Tipo</th>
	                                <th>Cantidad</th>
	                                <th>Fecha Operación</th>
	                                <th>Fecha Valor</th>
	                            </tr>
	                        </thead>
	                        <tfoot></tfoot>
	                        <tbody id="tableH">
	                            <%
	                            if(sesion.getAttribute("busqueda")!=null && !sesion.getAttribute("busqueda").toString().isEmpty()){%>
	                            	<%=sesion.getAttribute("busqueda")%>
	                            <%}%>
	                        </tbody>
	                    </table>
	                </div>
	            </div>
	            <div class="col-sm-6">
	                <div class="row">
	                    <h4 class="text-center">Estadísticas Filtrado</h4>
	                </div>
	                <div class="row">
	                    <div id="myCarouselH" class="carousel slide" data-ride="carousel">
	                            <ol class="carousel-indicators">
	                                <li data-target="#myCarouselH" data-slide-to="0" class="active"></li>
	                                <li data-target="#myCarouselH" data-slide-to="1"></li>
	                                <li data-target="#myCarouselH" data-slide-to="2"></li>
	                                <li data-target="#myCarouselH" data-slide-to="3"></li>
	                            </ol>
	                            <div class="carousel-inner">
	                                <div class="item active">
	                                    <canvas id="myChartH" width="600" height="600"></canvas>
	                                </div>
	                                <div class="item">
	                                    <canvas id="myChartH2" width="600" height="600"></canvas>
	                                </div>
	                                <div class="item">
	                                    <canvas id="myChartH3" width="600" height="600"></canvas>
	                                </div>
	                                <div class="item">
	                                    <canvas id="myChartH4" width="600" height="600"></canvas>
	                                </div>
	                            </div>
	                        </div>
	                </div>
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
        <script src="js/second.js"></script>
        <script src="js/scrolling-nav.js"></script>
    <script>
    
        var myctx = document.getElementById("myChartH");
            var myChart = new Chart(myctx, {
                type: 'bar',
                data: {
                    labels: ["Ingresos", "Gastos"],
                    datasets: [{
                        label: '# Media',
                        data: [<%=mediaIngresos%>, <%=mediaGastos%>],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255,99,132,1)',
                            'rgba(54, 162, 235, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    title: {
                          display: true,
                          text: 'Media I/G'
                    },
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero:true
                            }
                        }]
                    }
                }
            });
            
            //chart 2
            
            var myctx2 = document.getElementById("myChartH2");
            var myChart2 = new Chart(myctx2, {
                type: 'pie',
                data: {
                    labels: ["Ingresos", "Gastos"],
                    datasets: [{
                        label: '# Media',
                        data: [<%=mediaIngresos%>, <%=mediaGastos%>],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255,99,132,1)',
                            'rgba(54, 162, 235, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    title: {
                      display: true,
                      text: 'Media I/G'
                    }
                  }
            });
            
            // chart 3
            
            var myctx3 = document.getElementById("myChartH3");
            var myChart3 = new Chart(myctx3, {
                type: 'horizontalBar',
                data: {
                    labels: ["Ingresos", "Gastos"],
                    datasets: [{
                        label: '# Media',
                        data: [<%=mediaIngresos%>, <%=mediaGastos%>],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255,99,132,1)',
                            'rgba(54, 162, 235, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    legend: { display: false },
                    title: {
                      display: true,
                      text: 'Media I/G'
                    },
                    scales: {
                        xAxes: [{
                            ticks: {
                                beginAtZero:true
                            }
                        }]
                    }
                }
            });
            
            // chart 4
            
            var myctx4 = document.getElementById("myChartH4");
            var myChart4 = new Chart(myctx4, {
                type: 'doughnut',
                data: {
                    labels: ["Ingresos", "Gastos"],
                    datasets: [{
                        label: '# Media',
                        data: [<%=mediaIngresos%>, <%=mediaGastos%>],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255,99,132,1)',
                            'rgba(54, 162, 235, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    title: {
                      display: true,
                      text: 'Media I/G'
                    }
                  }
            });

    </script>
</body>
</html>
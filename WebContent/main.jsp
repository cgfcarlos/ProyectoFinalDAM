<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="servlets.servletLogin" %>
<%@ page import="servlets.servletPDF" %>
<%@ page import="servlets.servletOperaciones" %>
<%@ page import="java.util.*" %>
<%@ page import="hibernate.*" %>
<%@ page import="java.math.*" %>
<%@ page import="servlets.servletGenerarExtracto" %>
<%@ page import="servlets.servletAjustes" %>
<%@ page import="java.io.File" %>
<%@ page import="servlets.servletExcel" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
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
		List<Operacion> operaciones = new ArrayList<Operacion>();
		operaciones = (ArrayList<Operacion>) sesion.getAttribute("operaciones");
		int sumatorio=0;
		Pattern pattern;
		Matcher matcher;
		final String PDF_PATTERN =
                "([^\\s]+(\\.(?i)(pdf))$)";
        pattern = Pattern.compile(PDF_PATTERN);
		for(Operacion o: operaciones){
			if(Calendar.getInstance().get(Calendar.MONTH)==o.getFechaOperacion().getMonth()){
				sumatorio+=o.getCuantia().doubleValue();
			}
		}
		CuentaBancaria cuenta = (CuentaBancaria) sesion.getAttribute("cuenta");
		double mediaIngresos=0;
		double mediaGastos=0;
		double contIngresos=0;
		double contGastos=0;
		String ruta = "WebContent\\usuarios\\"+sesion.getAttribute("user")+"\\";
		
	%>
	
	<div class="modal" id="extractoModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Advertencia</h4>

                </div>
                <form method="get" action="servletGenerarExtracto">
                	<div class="modal-body">
                        <div class="form-group text-center">
                        	<p>¿Desea generar el extracto bancario del mes actual?</p>
                        	<small>*Nota: Se generará un PDF con los I/G del mes en curso</small>
                        </div>
                	</div>
                	<div class="modal-footer">
	                    <input type="submit" class="btn btn-primary" value="Aceptar"/>
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
                        <li class="scroll active"><a href="#home">Inicio </a></li>
                        <li class="scroll"><a href="#" data-target="#extractoModal" data-toggle="modal">Generar Extracto</a></li>
                        <li class="scroll"><a href="servletExcel">Generar Excel</a></li>
                        <li class="scroll"><a href="servletOperaciones">Operaciones</a></li>
                        <!--<li class="scroll"><a href="#pricing">Conocimientos</a></li>
                        <li class="scroll"><a href="#blog">  Blog </a></li
                        <li class="scroll"><a href="#testimonial"> Testimonial </a></li>-->
                       <li class="scroll"><a href="servletAjustes">Ajustes</a></li>
                       <li class="scroll"><a href="servletLogout">Cerrar sesión</a></li>
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
    </header><!--/header-->
    
    <section id="get-in-touch">
    	<div class="container">
    		<div class="row">
	    		<div class="col-sm-6">
	    			<fieldset>
	    				<legend class="text-center"><strong>Datos Personales</strong></legend>
		    			<table class="table">
							 <thead>
							  <tr>
							     <th>Titular</th>
							     <th><%=cuenta.getTitularCuenta()%></th>
							  </tr>
							 </thead>
							 <tfoot>
							  <tr>
							     <td>Tipo de Cuenta:</td>
							     <td><%=cuenta.getTipoCuenta() %></td>
							  </tr>
							 </tfoot>
							 <tbody>
							  <tr>
							     <td>Numero de Cuenta:</td>
							     <td><%=cuenta.getNumeroCuenta() %></td>
							  </tr>
							  <tr>
							  	<td>Entidad Bancaria:</td>
							  	<td><%=cuenta.getEntidadCuenta() %></td>
							  </tr>
							  <tr>
							  	<td>Saldo:</td>
							  	<td><%=cuenta.getSaldo().intValue() %> &euro;</td>
							  </tr>
					 		 </tbody>
						</table>
					</fieldset>
	    		</div>
	    		<div class="col-sm-6">
	    			<fieldset>
	    				<legend class="text-center"><strong>Extractos Realizados</strong></legend>
							<div class="wrap">
								<article class="ancho100">
									<div class="list-group">
										<form action="servletPDF" method="get"> 
									<%
									File folder = new File("C:\\Users\\carlo\\workspace\\ProyectoFinal\\WebContent\\usuarios\\"
											+ sesion.getAttribute("user").toString() + "\\");
									File[] listOfFiles = folder.listFiles();

									    for (int i = 0; i < listOfFiles.length; i++) {
									      if (listOfFiles[i].isFile()) {
									    	  ruta = ruta+listOfFiles[i].getName();
									    	  matcher = pattern.matcher(listOfFiles[i].getName());
									    	  if(matcher.matches()){ %>
										  	  	<input type="submit" name="extracto" class="list-group-item list-group-item-aux-pdf list-group-item-aux" value="<%=listOfFiles[i].getName()%>">
									  		  <% }else {%>
										  		<input type="submit" name="extracto" class="list-group-item list-group-item-aux-excel list-group-item-aux" value="<%=listOfFiles[i].getName()%>">
							  	  	<%			} 
									    	}
							      		}
									%>
											  </form>
									</div>
								</article>
							</div>
							<div><small><i>*Nota: Los cálculos se realizan al seleccionar la opción "Generar Extractos".<br> Los archivos excel muestran una hoja de cálculo sin calcular del saldo resultante</i></small></div>
    				</fieldset>
	    		</div>
    		</div>
    		<div class="row">
	    		<div class="col-sm-6">
	    			<fieldset>
	    				<legend class="text-center"><strong>Estado Mes Actual</strong></legend>
		    			<table class="table table-striped table-hover header-fixed">
		    				<thead>
		    					<tr>
		    						<th class="text-center">Nombre</th>
		    						<th class="text-center">Tipo</th>
		    						<th class="text-center">Cuantía</th>
		    						<th class="text-center">Fecha Oper.</th>
		    						<th class="text-center">Fecha Valor</th>
		    					</tr>
		    				</thead>
		    				<tfoot>
		    					<tr>
		    						<th class="text-right">Sumatorio: <%=sumatorio %> &euro;</th>
		   						</tr>
		    				</tfoot>
		    				<tbody>
		    					<% 
		    						for(Operacion o: operaciones){ 
		    							if(o.getFechaOperacion().getMonth()==Calendar.getInstance().get(Calendar.MONTH)){
		    					%>
		    					<tr>
    								<td class="text-center">
    									<%=o.getNombreOperacion().toString()%>
    								</td>
    								<td class="text-center">
    									<%=o.getTipoOperacion().toString()%>
    								</td>
    								<td class="text-center">
    									<%=o.getCuantia().intValue() %> &euro;
    								</td>
    								<td class="text-center">
    									<%=o.getFechaOperacion()%>
    								</td>
    								<td class="text-center">
    									<%=o.getFechaValor() %>
    								</td>
    							</tr>
		    					<%
		    								if(o.getTipoOperacion().equals("Gasto")){
		    									mediaGastos+=o.getCuantia().doubleValue();
		    									contGastos++;
		    								}
		    								else if(o.getTipoOperacion().equals("Ingreso")){
		    									mediaIngresos+=o.getCuantia().doubleValue();
		    									contIngresos++;
		    								}
		    							}
	    							}
		    						mediaGastos = (mediaGastos/contGastos)*-1;
		    						mediaIngresos = mediaIngresos/contIngresos;
		    					%>
		    				</tbody>
		    			</table>
	    			</fieldset>
	    		</div>
	    		<div class="col-sm-6">
	    			<fieldset>
	    				<legend class="text-center"><strong>Estadísticas Mes Actual</strong></legend>
	    				<div id="myCarousel" class="carousel slide" data-ride="carousel">
	    					<ol class="carousel-indicators">
							    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
							    <li data-target="#myCarousel" data-slide-to="1"></li>
							    <li data-target="#myCarousel" data-slide-to="2"></li>
							    <li data-target="#myCarousel" data-slide-to="3"></li>
						  	</ol>
						  	<div class="carousel-inner">
    							<div class="item active">
    								<canvas id="myChart" width="400" height="400"></canvas>
    							</div>
    							<div class="item">
    								<canvas id="myChart2" width="400" height="400"></canvas>
    							</div>
    							<div class="item">
    								<canvas id="myChart3" width="400" height="400"></canvas>
    							</div>
    							<div class="item">
    								<canvas id="myChart4" width="400" height="400"></canvas>
    							</div>
   							</div>
	    				</div>
	    			</fieldset>
	    		</div>
    		</div>
    	</div>
    </section><!-- /#get-in-touch -->

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
		<script src="js/Chart.js"></script>
		<script src="js/Chart.min.js"></script>
		<script>
			var ctx = document.getElementById("myChart");
			var myChart = new Chart(ctx, {
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
			
			var ctx2 = document.getElementById("myChart2");
			var myChart2 = new Chart(ctx2, {
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
			
			var ctx3 = document.getElementById("myChart3");
			var myChart3 = new Chart(ctx3, {
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
			
			var ctx4 = document.getElementById("myChart4");
			var myChart4 = new Chart(ctx4, {
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
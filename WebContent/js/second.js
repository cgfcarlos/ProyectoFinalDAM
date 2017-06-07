//javascript para ciertas funciones aisladas del main
function displayPopover() {
    $('[data-toggle="popover"]').popover();
}

function amortizacion() {
	var tbody = document.getElementById('table');

	while (tbody.hasChildNodes()) {
    	tbody.removeChild(tbody.lastChild);
	}

	var capital = document.getElementById('capital').value;
	if(capital==null || capital==undefined || capital==""){
		document.getElementById('capital').classList.add('error');
	}
	else{
		document.getElementById('capital').classList.remove('error');	
		var realizarPrestamo = document.getElementById('realizarPrestamo');
		var ps = [];
		
		var A = document.getElementById('capital').value;
		var aux = document.getElementById('capital').value;
		var numpagos = document.getElementById('numcuotas').value;
		for (var i = 1; i <= numpagos; i++) {
			var prestamo = {
				numpagos: 0,
				anualidad: 0,
				intereses: 0,
				amortizacion: 0,
				capitalamortizado: 0,
				capitalpendiente: 0,
			};
			prestamo.numpagos=i;
			var elevado = document.getElementById('numcuotas').value;
			var valor = document.getElementById('interes').value.substring(0,1);
			valor = valor/100;
			var v = valor+1;
			var pot = Math.pow(v,elevado);
			var v2 = pot-1;
			var pot2 = Math.pow((1+valor), numpagos);
			var dividendo = valor * pot2;
			var v3 = v2 / dividendo;
			var res = capital/v3;
			prestamo.anualidad=Number(res).toFixed(2);
			if(ps.length>0){
				prestamo.intereses=Number(valor*aux).toFixed(2);
				prestamo.amortizacion=Number(prestamo.anualidad - prestamo.intereses).toFixed(2);
				var prestamoaux = ps[(ps.length-1)];
				prestamo.capitalamortizado = Number(prestamoaux.capitalamortizado) + Number(prestamo.amortizacion);
				prestamo.capitalamortizado = Number(prestamo.capitalamortizado.toFixed(2));
			}
			else{
				prestamo.intereses = Number(capital * valor).toFixed(2);
				prestamo.amortizacion = Number(prestamo.anualidad - prestamo.intereses).toFixed(2);
				prestamo.capitalamortizado = Number(prestamo.amortizacion).toFixed(2);
			}
			prestamo.capitalpendiente = Number(aux - prestamo.amortizacion).toFixed(2);
			aux = prestamo.capitalpendiente;
			A = prestamo.amortizacion;
			ps.push(prestamo);


		}

		for (var j = 0; j < ps.length; j++) {
			var tr = document.createElement('TR');
			tbody.appendChild(tr);

			var td = document.createElement('TD');
			td.appendChild(document.createTextNode(ps[j].numpagos));
			tr.appendChild(td);

			var td2 = document.createElement('TD');
			td2.appendChild(document.createTextNode(ps[j].amortizacion));
			tr.appendChild(td2);

			var td3 = document.createElement('TD');
			td3.appendChild(document.createTextNode(ps[j].anualidad));
			tr.appendChild(td3);

			var td4 = document.createElement('TD');
			td4.appendChild(document.createTextNode(ps[j].capitalamortizado));
			tr.appendChild(td4);

			var td5 = document.createElement('TD');
			td5.appendChild(document.createTextNode(ps[j].capitalpendiente));
			tr.appendChild(td5);

			var td6 = document.createElement('TD');
			td6.appendChild(document.createTextNode(ps[j].intereses));
			tr.appendChild(td6);
		}

		realizarPrestamo.disabled=false;

	}
	
	function validatePrestamo(){
		
	}
}
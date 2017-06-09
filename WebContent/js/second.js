function displayPopover() {
    $('[data-toggle="popover"]').popover();
}

function amortizacion() {
	var tbody = document.getElementById('table');

	while (tbody.hasChildNodes()) {
    	tbody.removeChild(tbody.lastChild);
	}

	var capital = document.getElementById('capital').value;
	if(capital===null || capital===undefined || capital===""){
		document.getElementById('capital').classList.add('error');

		var tamano = document.getElementById('capital').parentElement.children;
		if(tamano.length==3){
			document.getElementById('capital').parentElement.removeChild(tamano[2]);	
		}
		
		var error = document.createElement('SPAN');
		error.appendChild(document.createTextNode("Rellenar"));
		error.setAttribute("name","error");
		error.setAttribute("class","alert-danger");
		document.getElementById('capital').parentElement.appendChild(error);
	}
	else{
		var tamano2 = document.getElementById('capital').parentElement.children;
		if(tamano2.length==3){
			document.getElementById('capital').parentElement.removeChild(tamano2[2]);	
		}
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
}

function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function validateNumber(number){
	var re = /^[0-9]+$/;
	return re.test(number);
}

function validatePrestamo() {
	var span;
	span = document.createElement('SPAN');
	span.appendChild(document.createTextNode("Rellenar"));
	span.setAttribute("name","error");
	span.setAttribute("class","alert-danger");	
	var fechaconcesion = document.getElementById('fechaconcesion').value;
	var fechafinalizacion = document.getElementById('fechafinalizacion').value;
	var capital = document.getElementById('capital').value;
	var validate =true;
	if(capital===null || capital===undefined || capital=== ""){
		document.getElementById('capital').classList.add('error');
		if(document.getElementById('capital').parentElement.children.length<3){
			document.getElementById('capital').parentElement.appendChild(span);
		}
		validate =false;
	}
	if((fechafinalizacion===null || fechafinalizacion===undefined || fechafinalizacion==="")){
		document.getElementById('fechafinalizacion').classList.add('error');
		if(document.getElementById('fechafinalizacion').parentElement.children.length<3){
			document.getElementById('fechafinalizacion').parentElement.appendChild(span);	
		}
		
		validate =false;
	}
	if((fechaconcesion===null || fechaconcesion===undefined || fechaconcesion==="")){
		document.getElementById('fechaconcesion').classList.add('error');
		if(document.getElementById('fechafinalizacion').parentElement.children.length<3){
			document.getElementById('fechaconcesion').parentElement.appendChild(span);	
		}
		validate=false;
	}
	if(validate) {
		document.getElementById('capital').classList.remove('error');
		document.getElementById('fechaconcesion').classList.remove('error');
		document.getElementById('fechafinalizacion').classList.remove('error');
		var tamanoC = document.getElementById('capital').parentElement.children;
		if(tamanoC.length==3){
			document.getElementById('capital').parentElement.removeChild(tamanoC[2]);	
		}
		var tamanoFC = document.getElementById('fechaconcesion').parentElement.children;
		if(tamanoFC.length==3){
			document.getElementById('fechaconcesion').parentElement.removeChild(tamanoFC[2]);	
		}
		var tamanoFF = document.getElementById('fechafinalizacion').parentElement.children;
		if(tamanoFF.length==3){
			document.getElementById('fechafinalizacion').parentElement.removeChild(tamanoFF[2]);	
		}
	}
	return validate;

}

function selectBeneficiary(btn) {
	var beneficiario = btn.value;
	document.getElementById('beneficiario').value=beneficiario;
}

function validateTransaccion(){
	var span;
	span = document.createElement('SPAN');
	span.appendChild(document.createTextNode("Rellenar"));
	span.setAttribute("name","error");
	span.setAttribute("class","alert-danger");	
	var beneficiario = document.getElementById('beneficiario').value;
	var banco = document.getElementById('banco').value;
	var numCuenta = document.getElementById('numcuenta').value;
	var concepto = document.getElementById('concepto').value;
	var importe = document.getElementById('importe').value;
	var validateT = true;
	if((beneficiario==null || beneficiario==undefined || beneficiario=="")){
		document.getElementById('beneficiario').appendChild(span);
		validateT = false;
	}
	if((banco==null || banco==undefined || banco=="")){
		document.getElementById('banco').appendChild(span);
		validateT = false;
	}
	if((numCuenta==null || numCuenta==undefined || numCuenta=="")){
		document.getElementById('numcuenta').appendChild(span);
		validateT = false;
	}
	if((concepto==null || concepto==undefined || concepto=="")){
		document.getElementById('concepto').appendChild(span);
		validateT = false;
	}
	if((importe==null || importe==undefined || importe=="")){
		document.getElementById('importe').appendChild(span);
		validateT = false;
	}
	if(validateT){
		var tamanoBene = document.getElementById('beneficiario').parentElement.children;
		if(tamanoBene.length==3){
			document.getElementById('beneficiario').parentElement.removeChild();
		}
		var tamanoBanc = document.getElementById('banco').parentElement.children;
		if(tamanoBanc.length==3){
			document.getElementById('banco').parentElement.removeChild();
		}
		var tamanoNumC = document.getElementById('numcuenta').parentElement.children;
		if(tamanoNumC.length==3){
			document.getElementById('numcuenta').parentElement.removeChild();
		}
		var tamanoConc = document.getElementById('concepto').parentElement.children;
		if(tamanoConc.length==3){
			document.getElementById('concepto').parentElement.removeChild([2]);
		}
		var tamanoImp = document.getElementById('importe').parentElement.children;
		if(tamanoImp.length==3){
			document.getElementById('importe').parentElement.removeChild([2]);
		}
	}
	
	return validateT;
}
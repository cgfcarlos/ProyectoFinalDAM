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
			
			var inpt = document.createElement('INPUT');
			inpt.setAttribute("name","anualidad"+j);
			inpt.setAttribute("value",ps[j].anualidad);
			inpt.setAttribute("type","text");
			inpt.setAttribute("class", "default");
			inpt.setAttribute("readonly","");
			td3.appendChild(inpt);
			
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

function validateNumber(el, evt) {
	var validate = true;
    var charCode = (evt.which) ? evt.which : event.keyCode;
    var number = el.value.split('.');
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
        validate= false;
    }
    //just one dot
    if(number.length>1 && charCode == 46){
         validate= false;
    }
    //get the carat position
    var caratPos = getSelectionStart(el);
    var dotPos = el.value.indexOf(".");
    if( caratPos > dotPos && dotPos>-1 && (number[1].length > 1)){
        validate= false;
    }
    return validate;
}

function getSelectionStart(o) {
	if (o.createTextRange) {
		var r = document.selection.createRange().duplicate()
		r.moveEnd('character', o.value.length)
		if (r.text == '') return o.value.length
		return o.value.lastIndexOf(r.text)
	} else return o.selectionStart
}

function validatePrestamo() {
	var span;
	span = document.createElement('SPAN');
	span.appendChild(document.createTextNode("Rellenar Correctamente"));
	span.setAttribute("name","error");
	span.setAttribute("class","alert-danger");	
	var fechaconcesion = document.getElementById('fechaconcesion').value;
	var fechafinalizacion = document.getElementById('fechafinalizacion').value;
	
	var span2;
	span2 = document.createElement('SPAN');
	span2.appendChild(document.createTextNode("Rellenar Correctamente"));
	span2.setAttribute("name","error");
	span2.setAttribute("class","alert-danger");	
	
	var span3;
	span3 = document.createElement('SPAN');
	span3.appendChild(document.createTextNode("Rellenar Correctamente"));
	span3.setAttribute("name","error");
	span3.setAttribute("class","alert-danger");	
	var capital = document.getElementById('capital').value;
	var validate =true;
	var validateCapital = true;
	var validateFF = true;
	var validateFCf
	if((capital===null || capital===undefined || capital=== "")){
		document.getElementById('capital').classList.add('error');
		if(document.getElementById('capital').parentElement.children.length<3){
			document.getElementById('capital').parentElement.appendChild(span);
		}
		validateCapital=false;
		validate =false;
	}
	if((fechafinalizacion===null || fechafinalizacion===undefined || fechafinalizacion==="")){
		document.getElementById('fechafinalizacion').classList.add('error');
		if(document.getElementById('fechafinalizacion').parentElement.children.length<3){
			document.getElementById('fechafinalizacion').parentElement.appendChild(span2);	
		}
		validateFF = false;
		validate =false;
	}
	if((fechaconcesion===null || fechaconcesion===undefined || fechaconcesion==="")){
		document.getElementById('fechaconcesion').classList.add('error');
		if(document.getElementById('fechaconcesion').parentElement.children.length<3){
			document.getElementById('fechaconcesion').parentElement.appendChild(span3);	
		}
		validateFC=false;
		validate=false;
	}

	var tamanoC = document.getElementById('capital').parentElement.children;
	if(tamanoC.length==3 && validateCapital){
		document.getElementById('capital').classList.remove('error');
		document.getElementById('capital').parentElement.removeChild(tamanoC[2]);	
	}
	var tamanoFC = document.getElementById('fechaconcesion').parentElement.children;
	if(tamanoFC.length==3 && validateFC){
		document.getElementById('fechaconcesion').classList.remove('error');
		document.getElementById('fechaconcesion').parentElement.removeChild(tamanoFC[2]);	
	}
	var tamanoFF = document.getElementById('fechafinalizacion').parentElement.children;
	if(tamanoFF.length==3 && validateFF){
		document.getElementById('fechafinalizacion').classList.remove('error');
		document.getElementById('fechafinalizacion').parentElement.removeChild(tamanoFF[2]);	
	}

	return validate;

}

function selectBeneficiary(btn) {
	var valor = btn.value;
	var beneficiario = valor.split(';')[0];
	var numcuenta = valor.split(';')[1];
	var entidad = valor.split(';')[2];
	if((beneficiario!=null || beneficiario!=undefined || beneficiario!="") && (numcuenta!=null || numcuenta!=undefined || numcuenta!="") && (entidad!=null || entidad!=undefined || entidad!="")){
		document.getElementById('beneficiario').value=beneficiario;
		document.getElementById('banco').value=entidad;
		document.getElementById('numcuenta').value=numcuenta;
	}
}

function validateTransaccion(){
	var span;
	span = document.createElement('SPAN');
	span.appendChild(document.createTextNode("Rellenar Correctamente"));
	span.setAttribute("name","error");
	span.setAttribute("class","alert-danger");
	
	var span2;
	span2 = document.createElement('SPAN');
	span2.appendChild(document.createTextNode("Rellenar Correctamente"));
	span2.setAttribute("name","error");
	span2.setAttribute("class","alert-danger");	
	
	var span3;
	span3 = document.createElement('SPAN');
	span3.appendChild(document.createTextNode("Rellenar Correctamente"));
	span3.setAttribute("name","error");
	span3.setAttribute("class","alert-danger");	
	
	var span4;
	span4 = document.createElement('SPAN');
	span4.appendChild(document.createTextNode("Rellenar Correctamente"));
	span4.setAttribute("name","error");
	span4.setAttribute("class","alert-danger");	
	
	var span5;
	span5 = document.createElement('SPAN');
	span5.appendChild(document.createTextNode("Rellenar Correctamente"));
	span5.setAttribute("name","error");
	span5.setAttribute("class","alert-danger");	
	
	var beneficiario = document.getElementById('beneficiario').value;
	var banco = document.getElementById('banco').value;
	var numCuenta = document.getElementById('numcuenta').value;
	var concepto = document.getElementById('concepto').value;
	var importe = document.getElementById('importe').value;
	var validateT = true;
	var validateBene = true;
	var validateNumcuenta = true;
	var validateBanco = true;
	var validateConcepto = true;
	var validateImporte = true;
	
	if((beneficiario==null || beneficiario==undefined || beneficiario=="")){
		document.getElementById('beneficiario').classList.add('error');
		document.getElementById('beneficiario').parentElement.appendChild(span);
		validateT = false;
		validateBene=false;
	}
	if((banco==null || banco==undefined || banco=="")){
		document.getElementById('banco').classList.add('error');
		document.getElementById('banco').parentElement.appendChild(span2);
		validateT = false;
		validateBanco = false;
	}
	if((numCuenta==null || numCuenta==undefined || numCuenta=="")){
		document.getElementById('numcuenta').classList.add('error');
		document.getElementById('numcuenta').parentElement.appendChild(span3);
		validateT = false;
		validateNumcuenta = false;
	}
	if((concepto==null || concepto==undefined || concepto=="")){
		document.getElementById('concepto').classList.add('error');
		document.getElementById('concepto').parentElement.appendChild(span4);
		validateT = false;
		validateConcepto = false;
	}
	if((importe==null || importe==undefined || importe=="")){
		document.getElementById('importe').classList.add('error');
		document.getElementById('importe').parentElement.appendChild(span5);
		validateT = false;
		validateImporte = false;
	}	
	var tamanoBene = document.getElementById('beneficiario').parentElement.children;
	if(tamanoBene.length==3 && validateBene){
		document.getElementById('beneficiario').classList.remove('error');
		document.getElementById('beneficiario').parentElement.removeChild();
	}
	var tamanoBanc = document.getElementById('banco').parentElement.children;
	if(tamanoBanc.length==3 && validateBanco){
		document.getElementById('banco').classList.remove('error');
		document.getElementById('banco').parentElement.removeChild();
	}
	var tamanoNumC = document.getElementById('numcuenta').parentElement.children;
	if(tamanoNumC.length==3 && validateNumcuenta){
		document.getElementById('numcuenta').classList.remove('error');
		document.getElementById('numcuenta').parentElement.removeChild();
	}
	var tamanoConc = document.getElementById('concepto').parentElement.children;
	if(tamanoConc.length==3 && validateConcepto){
		document.getElementById('concepto').classList.remove('error');
		document.getElementById('concepto').parentElement.removeChild([2]);
	}
	var tamanoImp = document.getElementById('importe').parentElement.children;
	if(tamanoImp.length==3 && validateImporte){
		document.getElementById('importe').classList.remove('error');
		document.getElementById('importe').parentElement.removeChild([2]);
		
	}
	
	return validateT;
}
function validateOperacion(){
	var span;
	span = document.createElement('SPAN');
	span.appendChild(document.createTextNode("Rellenar Correctamente"));
	span.setAttribute("name","error");
	span.setAttribute("class","alert-danger");
	
	var span2;
	span2 = document.createElement('SPAN');
	span2.appendChild(document.createTextNode("Rellenar Correctamente"));
	span2.setAttribute("name","error");
	span2.setAttribute("class","alert-danger");
	
	var span3;
	span3 = document.createElement('SPAN');
	span3.appendChild(document.createTextNode("Rellenar Correctamente"));
	span3.setAttribute("name","error");
	span3.setAttribute("class","alert-danger");
	
	var span4;
	span4 = document.createElement('SPAN');
	span4.appendChild(document.createTextNode("Rellenar Correctamente"));
	span4.setAttribute("name","error");
	span4.setAttribute("class","alert-danger");
	
	var span5;
	span5= document.createElement('SPAN');
	span5.appendChild(document.createTextNode("Rellenar Correctamente"));
	span5.setAttribute("name","error");
	span5.setAttribute("class","alert-danger");
	
	var nombreOp = document.getElementsByName("nombreOperacion")[0].value;
	var tipoOp = document.getElementsByName("tipoOperacion")[0].value;
	var cuantia = document.getElementsByName("cuantia")[0].value;
	var fechaOp = document.getElementsByName("fechaOperacion")[0].value;
	var fechaV = document.getElementsByName("fechaValor")[0].value;
	
	var validateOp=true;
	var validateNombre=true;
	var validateTipo=true;
	var validateCuantia=true;
	var validateFechaOp=true;
	var validateFechaV=true;
	
	if(nombreOp==null || nombreOp==undefined || nombreOp==""){
		document.getElementsByName('nombreOperacion')[0].classList.add('error');
		document.getElementsByName('nombreOperacion')[0].parentElement.appendChild(span);
		validateNombre = false;
		validateOp=false;
	}
	
	if(tipoOp==null || tipoOp==undefined || tipoOp==""){
		document.getElementsByName('tipoOperacion')[0].classList.add('error');
		document.getElementsByName('tipoOperacion')[0].parentElement.appendChild(span2);
		validateTipo = false;
		validateOp=false;
	}
	if((cuantia==null || cuantia==undefined || cuantia=="")){
		document.getElementsByName('cuantia')[0].classList.add('error');
		document.getElementsByName('cuantia')[0].parentElement.appendChild(span3);
		validateCuantia = false;
		validateOp=false;
	}
	if(fechaOp==null || fechaOp==undefined || fechaOp==""){
		document.getElementsByName('fechaOperacion')[0].classList.add('error');
		document.getElementsByName('fechaOperacion')[0].parentElement.appendChild(span4);
		validateFechaOp = false;
		validateOp=false;
	}
	if(fechaV==null || fechaV==undefined || fechaV==""){
		document.getElementsByName('fechaValor')[0].classList.add('error');
		document.getElementsByName('fechaValor')[0].parentElement.appendChild(span5);
		validateFechaV = false;
		validateOp=false;
	}
	var tamanoNom = document.getElementsByName('nombreOperacion')[0].parentElement.children;
	if(tamanoNom.length==3 && validateNombre){
		document.getElementsByName('nombreOperacion')[0].classList.remove('error');
		document.getElementsByName('nombreOperacion')[0].parentElement.removeChild[2];
	}
	var tamanoTipo = document.getElementsByName('tipoOperacion')[0].parentElement.children;
	if(tamanoTipo.length==2 && validateTipo){
		document.getElementsByName('tipoOperacion')[0].classList.remove('error');
		document.getElementsByName('tipoOperacion')[0].parentElement.removeChild[1];
	}
	var tamanoCuantia = document.getElementsByName('cuantia')[0].parentElement.children;
	if(tamanoCuantia.length==2 && validateCuantia){
		document.getElementsByName('cuantia')[0].classList.remove('error');
		document.getElementsByName('cuantia')[0].parentElement.removeChild[1];
	}
	var tamanoFechaOp = document.getElementsByName('fechaOperacion')[0].parentElement.children;
	if(tamanoFechaOp.length==2 && validateFechaOp){
		document.getElementsByName('fechaOperacion')[0].classList.remove('error');
		document.getElementsByName('fechaOperacion')[0].parentElement.removeChild[1];
	}
	var tamanoFechaV = document.getElementsByName('fechaValor')[0].parentElement.children;
	if(tamanoFechaV.length==2 && validateFechaV){
		document.getElementsByName('fechaValor')[0].classList.remove('error');
		document.getElementsByName('fechaValor')[0].parentElement.removeChild[1];
	}
	return validateOp;
}
function validateRegistro(){
	
	var span;
	span = document.createElement('SPAN');
	span.appendChild(document.createTextNode("Rellenar Correctamente"));
	span.setAttribute("name","error");
	span.setAttribute("class","alert-danger");
	
	var span2;
	span2 = document.createElement('SPAN');
	span2.appendChild(document.createTextNode("Rellenar Correctamente"));
	span2.setAttribute("name","error");
	span2.setAttribute("class","alert-danger");

	var span3;
	span3 = document.createElement('SPAN');
	span3.appendChild(document.createTextNode("Rellenar Correctamente"));
	span3.setAttribute("name","error");
	span3.setAttribute("class","alert-danger");
	
	var span4;
	span4 = document.createElement('SPAN');
	span4.appendChild(document.createTextNode("Rellenar Correctamente"));
	span4.setAttribute("name","error");
	span4.setAttribute("class","alert-danger");
	
	var span5;
	span5 = document.createElement('SPAN');
	span5.appendChild(document.createTextNode("Rellenar Correctamente"));
	span5.setAttribute("name","error");
	span5.setAttribute("class","alert-danger");
	
	var span6;
	span6 = document.createElement('SPAN');
	span6.appendChild(document.createTextNode("Rellenar Correctamente"));
	span6.setAttribute("name","error");
	span6.setAttribute("class","alert-danger");
	
	var span7;
	span7 = document.createElement('SPAN');
	span7.appendChild(document.createTextNode("Rellenar Correctamente"));
	span7.setAttribute("name","error");
	span7.setAttribute("class","alert-danger");
	
	var span8;
	span8 = document.createElement('SPAN');
	span8.appendChild(document.createTextNode("Rellenar Correctamente"));
	span8.setAttribute("name","error");
	span8.setAttribute("class","alert-danger");
	
	var span9;
	span9 = document.createElement('SPAN');
	span9.appendChild(document.createTextNode("Rellenar Correctamente"));
	span9.setAttribute("name","error");
	span9.setAttribute("class","alert-danger");
	
	var span10;
	span10 = document.createElement('SPAN');
	span10.appendChild(document.createTextNode("Rellenar Correctamente"));
	span10.setAttribute("name","error");
	span10.setAttribute("class","alert-danger");
	
	var span11;
	span11 = document.createElement('SPAN');
	span11.appendChild(document.createTextNode("Rellenar Correctamente"));
	span11.setAttribute("name","error");
	span11.setAttribute("class","alert-danger");
	
	var span12;
	span12 = document.createElement('SPAN');
	span12.appendChild(document.createTextNode("Rellenar Correctamente"));
	span12.setAttribute("name","error");
	span12.setAttribute("class","alert-danger");
	
	var span13;
	span13 = document.createElement('SPAN');
	span13.appendChild(document.createTextNode("Rellenar Correctamente"));
	span13.setAttribute("name","error");
	span13.setAttribute("class","alert-danger");
	
	var span14;
	span14 = document.createElement('SPAN');
	span14.appendChild(document.createTextNode("Rellenar Correctamente"));
	span14.setAttribute("name","error");
	span14.setAttribute("class","alert-danger");
	
	var nombre = document.getElementsByName("nombre")[0].value;
	var apellidos = document.getElementsByName("apellidos")[0].value;
	var dni = document.getElementsByName("dni")[0].value;
	var tlf = document.getElementsByName("tlf")[0].value;
	var email = document.getElementsByName("email")[0].value;
	var usuario = document.getElementsByName("nick")[0].value;
	var pass = document.getElementsByName("pass")[0].value;
	var numcuenta = document.getElementsByName("numCuenta")[0].value;
	var titular = document.getElementsByName("titularCuenta")[0].value;
	var entidad = document.getElementsByName("entidad")[0].value;
	var tipocuenta = document.getElementsByName("tipoCuenta")[0].value;
	var pais = document.getElementsByName("pais")[0].value;
	var bic = document.getElementsByName("bic")[0].value;
	var saldo = document.getElementsByName("saldo")[0].value;
	
	var validateR = true;
	var validateNom=true;
	var validateAp=true;
	var validateDNI=true;
	var validateTlf=true;
	var validateEmail=true;
	var validateUsr=true;
	var validatePass=true;
	var validateNumCuenta=true;
	var validateTitular=true;
	var validateTipoCuenta=true;
	var validateEntidad=true;
	var validatePais=true;
	var validateBic=true;
	var validateSaldo=true;
	
	if(nombre==null || nombre==undefined || nombre==""){
		document.getElementsByName("nombre")[0].classList.add("error");
		document.getElementsByName("nombre")[0].parentElement.appendChild(span);
		validateNom=false;
		validateR=false;
	}
	if(apellidos==null || apellidos==undefined || apellidos==""){
		document.getElementsByName("apellidos")[0].classList.add("error");
		document.getElementsByName("apellidos")[0].parentElement.appendChild(span2);
		validateAp=false;
		validateR=false;
	}
	if(dni==null || dni==undefined || dni==""){
		document.getElementsByName("dni")[0].classList.add("error");
		document.getElementsByName("dni")[0].parentElement.appendChild(span3);
		validateDNI=false;
		validateR=false;
	}
	if(tlf==null || tlf==undefined || tlf==""){
		document.getElementsByName("tlf")[0].classList.add("error");
		document.getElementsByName("tlf")[0].parentElement.appendChild(span4);
		validateTlf=false;
		validateR=false;
	}
	if(email==null || email==undefined || email==""){
		document.getElementsByName("email")[0].classList.add("error");
		document.getElementsByName("email")[0].parentElement.appendChild(span5);
		validateEmail=false;
		validateR=false;
	}
	if(usuario==null || usuario==undefined || usuario==""){
		document.getElementsByName("nick")[0].classList.add("error");
		document.getElementsByName("nick")[0].parentElement.appendChild(span6);
		validateUsr=false;
		validateR=false;
	}
	if(pass==null || pass==undefined || pass==""){
		document.getElementsByName("pass")[0].classList.add("error");
		document.getElementsByName("pass")[0].parentElement.appendChild(span7);
		validatePass=false;
		validateR=false;
	}
	if(numcuenta==null || numcuenta==undefined || numcuenta==""){
		document.getElementsByName("numCuenta")[0].classList.add("error");
		document.getElementsByName("numCuenta")[0].parentElement.appendChild(span8);
		validateNumCuenta=false;
		validateR=false;
	}
	if(titular==null || titular==undefined || titular==""){
		document.getElementsByName("titularCuenta")[0].classList.add("error");
		document.getElementsByName("titularCuenta")[0].parentElement.appendChild(span9);
		validateTitular=false;
		validateR=false;
	}
	if(entidad==null || entidad==undefined || entidad==""){
		document.getElementsByName("entidad")[0].classList.add("error");
		document.getElementsByName("entidad")[0].parentElement.appendChild(span10);
		validateEntidad=false;
		validateR=false;
	}
	if(tipocuenta==null || tipocuenta==undefined || tipocuenta==""){
		document.getElementsByName("tipoCuenta")[0].classList.add("error");
		document.getElementsByName("tipoCuenta")[0].parentElement.appendChild(span11);
		validateTipoCuenta=false;
		validateR=false;
	}
	if(pais==null || pais==undefined || pais==""){
		document.getElementsByName("pais")[0].classList.add("error");
		document.getElementsByName("pais")[0].parentElement.appendChild(span12);
		validatePais=false;
		validateR=false;
	}
	if(bic==null || bic==undefined || bic==""){
		document.getElementsByName("bic")[0].classList.add("error");
		document.getElementsByName("bic")[0].parentElement.appendChild(span13);
		validateBic=false;
		validateR=false;
	}
	if(saldo==null || saldo==undefined || saldo==""){
		document.getElementsByName("saldo")[0].classList.add("error");
		document.getElementsByName("saldo")[0].parentElement.appendChild(span14);
		validateSaldo=false;
		validateR=false;
	}
	
	if(validateNom){
		document.getElementsByName('nombre')[0].classList.remove('error');
		document.getElementsByName('nombre')[0].parentElement.removeChild[1];
	}
	if(validateAp){
		document.getElementsByName('apellidos')[0].classList.remove('error');
		document.getElementsByName('apellidos')[0].parentElement.removeChild[1];
	}
	if(validateDNI){
		document.getElementsByName('dni')[0].classList.remove('error');
		document.getElementsByName('dni')[0].parentElement.removeChild[1];
	}
	if(validateTlf){
		document.getElementsByName('tlf')[0].classList.remove('error');
		document.getElementsByName('tlf')[0].parentElement.removeChild[1];
	}
	if(validateEmail){
		document.getElementsByName('email')[0].classList.remove('error');
		document.getElementsByName('email')[0].parentElement.removeChild[1];
	}
	if(validateUsr){
		document.getElementsByName('nick')[0].classList.remove('error');
		document.getElementsByName('nick')[0].parentElement.removeChild[1];
	}
	if(validatePass){
		document.getElementsByName('pass')[0].classList.remove('error');
		document.getElementsByName('pass')[0].parentElement.removeChild[1];
	}
	if(validateNumCuenta){
		document.getElementsByName('numCuenta')[0].classList.remove('error');
		document.getElementsByName('numCuenta')[0].parentElement.removeChild[1];
	}
	if(validateTitular){
		document.getElementsByName('titularCuenta')[0].classList.remove('error');
		document.getElementsByName('titularCuenta')[0].parentElement.removeChild[1];
	}
	if(validateEntidad){
		document.getElementsByName('entidad')[0].classList.remove('error');
		document.getElementsByName('entidad')[0].parentElement.removeChild[1];
	}
	if(validateTipoCuenta){
		document.getElementsByName('tipoCuenta')[0].classList.remove('error');
		document.getElementsByName('tipoCuenta')[0].parentElement.removeChild[1];
	}
	if(validatePais){
		document.getElementsByName('pais')[0].classList.remove('error');
		document.getElementsByName('pais')[0].parentElement.removeChild[1];
	}
	if(validateBic){
		document.getElementsByName('bic')[0].classList.remove('error');
		document.getElementsByName('bic')[0].parentElement.removeChild[1];
	}
	if(validateSaldo){
		document.getElementsByName('saldo')[0].classList.remove('error');
		document.getElementsByName('saldo')[0].parentElement.removeChild[1];
	}
	
	return validateR;
}
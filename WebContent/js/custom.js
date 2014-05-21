//////   LOGIN FORM POPOVER	 ////////
$('#loginForm').popover({
	html : true,
	content: function() {
		return $('#loginForm-div').html();
	}
});

//////   REGISTRATION FORM SUBMIT /////
$('#submitButton').on('click', function(e){
	
	// We don't want this to act as a link so cancel the link action
	e.preventDefault();
	
	// Find form and submit it
	$('#signupForm').submit();

});

//////   VALIDATE REGISTRATION FORM //////
$(document).ready(function(){

	$('#signupForm').validate({
		rules: {
			firstName: {
				minlength: 3,
				required: true,
			},
			lastName: {
				minlength: 3,
				required: true,
			},
			email: {
				required: true,
				email: true
			},
			typePassword: {
				required: true,
				rangelength: [6,32],
			},
			retypePassword: {
				required: true,
				equalTo: "#typePassword"
			},
			curso: {
				minlength: 3,
				required: true
			},
			anoCurso: {
				number: true,
				required: true,
				max: [5]
			},
			checkTerms: {
				required: true
			}
		},
		
		submitHandler: function(form) {
			if ($('#signupForm').valid()) {

				// Hide the modal
				$("#signupModal").modal('hide');

				// Delay to end animation and redirect to server controller
				var delay = 1000;
				setTimeout(function(){
					form.submit();
				}, delay);
			}
		},
		
		highlight: function(label) {
			$(label).closest('.control-group').addClass('error');
		},
		success: function(label) {
			label
			.addClass('valid')
			.closest('.control-group').addClass('success');
		},
	});

}); // end document.ready

/////// CHECK FILE EXTENSIONS ////////
function check_file() {
	str = document.getElementById('filebutton').value.toUpperCase();
	suffix = ".RAR";
	suffix2 = ".ZIP";
	suffix3 = ".PDF";
	suffix4 = ".DOC";
	suffix5 = ".DOCX";
	
	if (!(str.indexOf(suffix, str.length - suffix.length) !== -1 || str
			.indexOf(suffix2, str.length - suffix2.length) !== -1 || str
			.indexOf(suffix3, str.length - suffix3.length) !== -1 || str
			.indexOf(suffix4, str.length - suffix4.length) !== -1 || str
			.indexOf(suffix5, str.length - suffix5.length) !== -1)) {
		alert('Extensão de ficheiro não permitida!,\nTipos permitidos: *.zip, *.rar, *.pdf, *.doc, *.docx');
		document.getElementById('filebutton').value = '';
	}
}

/////// INFO TOOLTIPS /////////
$('#urlinfo').tooltip();
$('#resinfo').tooltip();

/////// INSERT FILE CHECKS ////////
function radioCheck() {
	if(document.getElementById('tipoexame').checked || document.getElementById('tipofreq').checked) {
		document.getElementById('1ep').disabled = false;
		document.getElementById('2ep').disabled = false;
		document.getElementById('eep').disabled = false;
	} else {
		document.getElementById('1ep').disabled = true;
		document.getElementById('2ep').disabled = true;
		document.getElementById('eep').disabled = true;
	}
	
	if(document.getElementById('tipoexame').checked || document.getElementById('tipofreq').checked || document.getElementById('tipoteste').checked) {
		document.getElementById('resolution').disabled = false;
	} else {
		document.getElementById('resolution').disabled = true;
	}
}
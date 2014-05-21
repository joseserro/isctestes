<!-- REGISTRATION FORM HTML STYLE CODE -->
<div id="signupModal" class="modal hide fade" style="display: none;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">�</button>
		<h4>Formul�rio de Registo</h4>
	</div>
	<div class="modal-body">
		<h6 align="center">
			Efectua o teu registo, preenchendo <font style="color: red;">todos</font>
			os campos abaixo aprentados.
		</h6>
		<form id="signupForm" class="form-horizontal" data-remote="true"
			accept-charset="ISO-8859-1" action="/servlet" method="post"
			data-async data-target="#signupModal" style="margin-left: -35px;">
			<fieldset>
				<div class="control-group" style="margin-top: 10px">
					<div class="controls">
						<div class="input-prepend">
							<span class="add-on"><i class="icon-user"></i></span> <input
								type="text" name="firstName" id="firstName"
								placeholder="Primeiro nome" class="input-large" />
						</div>
					</div>
				</div>
				<div class="control-group" style="margin-top: -10px">
					<div class="controls">
						<div class="input-prepend">
							<span class="add-on"><i class="icon-user"></i></span> <input
								type="text" name="lastName" placeholder="�ltimo nome"
								class="input-large">
						</div>
					</div>
				</div>
				<div class="control-group" style="margin-top: -10px">
					<div class="controls">
						<div class="input-prepend">
							<span class="add-on"><i class="icon-envelope"></i></span> <input
								type="email" name="email" placeholder="Email (@iscte-iul.pt)"
								class="input-large">
						</div>
					</div>
				</div>
				<div class="control-group" style="margin-top: -10px">
					<div class="controls">
						<div class="input-prepend">
							<span class="add-on"><i class="icon-lock"></i></span> <input
								type="password" name="typePassword" placeholder="Password"
								class="input-large" id="typePassword">
						</div>
					</div>
				</div>
				<div class="control-group" style="margin-top: -10px">
					<div class="controls">
						<div class="input-prepend">
							<span class="add-on"><i class="icon-lock"></i></span> <input
								type="password" name="retypePassword"
								placeholder="Repetir password" class="input-large">
						</div>
					</div>
				</div>
				<div class="control-group" style="margin-top: -10px">
					<div class="controls controls-row">
						<div class="input-prepend">
							<span class="add-on"><i class="icon-th-list"></i></span>
							<input type="text" class="input-large" name="curso" style="margin: 0 auto;" data-provide="typeahead" placeholder="Curso" data-items="2"
							data-source="[&quot;Antropologia&quot;,&quot;Arquitectura&quot;,&quot;Ci�ncia Pol�tica&quot;,&quot;Economia&quot;,&quot;Engenharia de Telecomunica��es e Inform�tica&quot;,&quot;Engenharia Inform�tica&quot;,&quot;Finan�as e Contabilidade&quot;,&quot;Gest�o&quot;,&quot;Gest�o de Marketing&quot;,&quot;Gest�o de Recursos Humanos&quot;,&quot;Gest�o e Engenharia Industrial&quot;,&quot;Hist�ria Moderna e Contempor�nea&quot;,&quot;Inform�tica e Gest�o de Empresas&quot;,&quot;Psicologia&quot;,&quot;Servi�o Social&quot;,&quot;Sociologia&quot;]">
						</div>
					</div>
				</div>
				<div class="control-group" style="margin-top: -10px">
					<div class="controls">
						<div class="input-prepend">
							<span class="add-on"><i class="icon-calendar"></i></span><input
								type="number" min="1" max="5" name="anoCurso" placeholder="Ano"
								class="input-large">
						</div>
					</div>
				</div>
				<input type="hidden" name="sessao" value="signup">
			</fieldset>
		</form>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal">Cancelar</button>
		<button id="submitButton" type="submit" class="btn btn-primary">Submeter</button>
	</div>
</div>
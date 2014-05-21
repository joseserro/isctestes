<div id="loginForm-div" style="display: none">
	<form id="loginForm" action="servlet" method="post">
		<fieldset>
			<div class="control-group" style="margin-top: 10px">
				<div class="controls">
					<div class="input-prepend">
						<span class="add-on"><i class="icon-envelope"></i></span> <input
							type="email" name="email" placeholder="Email" class="span2">
					</div>
				</div>
			</div>
			<div class="control-group" style="margin-top: -10px">
				<div class="controls">
					<div class="input-prepend">
						<span class="add-on"><i class="icon-lock"></i></span> <input
							type="password" name="typePassword" placeholder="Password"
							class="span2">
					</div>
				</div>
			</div>
			<div align="center" style="margin-left: -15px">
				<button type="submit" class="btn btn-primary span2" 
				name="sessao" value="login">Submeter</button>
			</div>
		</fieldset>
	</form>
</div>
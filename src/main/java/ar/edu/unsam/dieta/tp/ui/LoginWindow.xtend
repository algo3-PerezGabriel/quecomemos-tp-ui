package ar.edu.unsam.dieta.tp.ui

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.MainWindow
import ar.edu.unsam.dieta.tp.model.app.LoginUserModel

class LoginWindow extends MainWindow<LoginUserModel> {

	new() {
		super(new LoginUserModel())
	}

	override createContents(Panel mainPanel) {
		title = "Login"
		
		val camposPanel = new Panel(mainPanel)
		new Label(camposPanel).setText("Usuario")
		new TextBox(camposPanel).bindValueToProperty("nombreUsuario")
		new Label(camposPanel).setText("Contraseña")
		new TextBox(camposPanel).bindValueToProperty("passUsuario")
		
		val botonesPanel = new Panel(mainPanel)
		botonesPanel.layout = new HorizontalLayout()
		
		new Button(botonesPanel) => [
			caption = "OK"
			onClick = [|this.logear()]
		]
		new Button(botonesPanel) => [
			caption = "Cancelar"
			onClick = [|this.close()]
		]
		
	}
	
	def logear() {
		//hay que ver como se traeria el error de login hasta la vista
		this.openDialog(new VistaBienvenidoWindow(this, modelObject.validarLogin()))
	}

	def openDialog(Dialog<?> dialog) {
		//dialog.onAccept[|modelObject.]
		dialog.open
	}

	def static main(String[] args) {
		new LoginWindow().startApplication()
	}
}

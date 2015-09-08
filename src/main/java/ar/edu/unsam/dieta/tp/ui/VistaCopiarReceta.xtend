package ar.edu.unsam.dieta.tp.ui

import ar.edu.unsam.dieta.tp.model.app.CopiarRecetaModelo
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner

class VistaCopiarReceta extends TransactionalDialog<CopiarRecetaModelo> {
	
	new(WindowOwner owner, CopiarRecetaModelo model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Copiar Receta"
		val panelNombre = new Panel(mainPanel).layout = new HorizontalLayout
		new Label(panelNombre).setText("Receta: ")
		new Label(panelNombre).bindValueToProperty("nombreOrigen")
		val copiaPanel = new Panel(mainPanel).layout = new HorizontalLayout
		new Label(copiaPanel).setText("Nombre de la copia: ")
		new TextBox(copiaPanel).bindValueToProperty("nombreReceta")
	}
	
}
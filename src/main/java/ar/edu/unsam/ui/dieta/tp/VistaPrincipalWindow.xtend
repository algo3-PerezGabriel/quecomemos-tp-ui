package ar.edu.unsam.ui.dieta.tp

import ar.tp.dieta.IngredienteBuilder
import ar.tp.dieta.Receta
import ar.tp.dieta.RecetaBuilder
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.ColumnLayout

class VistaPrincipalWindow extends MainWindow<Receta> {
	
	new(){
		super(new RecetaBuilder("Arroz Blanco").calorias(10).autor("Antonio Gasalla").dificultad("Facil").procesoPreparacion("Hervir el arroz. Comer.").temporada("Invierno").agregar(new IngredienteBuilder("arroz").cantidad(2).build()).build())
	}

	override createContents(Panel mainPanel) {
		
		title = "Detalle de receta"
		mainPanel.layout = new ColumnLayout(2)
		
		val panelDeArriba = new Panel(mainPanel)
		new Label(panelDeArriba).bindValueToProperty("nombreDeLaReceta")
		
		val panelIzquierdo = new Panel(mainPanel)
		new Label(panelIzquierdo).bindValueToProperty("calorias")
		
		val panelDerecho = new Panel(mainPanel)
		new Label(panelDerecho).text = "Creado por"

	}
	
	def static main(String[] args){
		new VistaPrincipalWindow().startApplication
	}
		
}
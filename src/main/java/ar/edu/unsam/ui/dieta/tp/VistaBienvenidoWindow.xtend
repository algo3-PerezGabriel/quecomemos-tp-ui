package ar.edu.unsam.ui.dieta.tp

import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import ar.tp.dieta.Receta
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.widgets.tables.Column

class VistaBienvenidoWindow extends MainWindow<Object> { //FALTA EL MODEL OBJECT
	
	new(Object model) {
		super(model)
	}
	
	override createContents(Panel mainPanel) {
		title = "Bienvenoido a ¿Qué Comemos?"
		
		new Label (mainPanel).setText("Estas fueron tus últimas consultas")
		
		crearGrillaRecetas(mainPanel)
		
		val buttonsPanel = new Panel(mainPanel)
		buttonsPanel.layout = new HorizontalLayout
		new Button(buttonsPanel) => [
      		setCaption("Ver")
      		onClick [|] //BINDEAR A LA VISTA DEL DETALLE RECETA
		]
		new Button(buttonsPanel) => [
      		setCaption("Favorita")
      		onClick [|] //BINDEAR A AGREGAR FAVORITA LA RECETA
		]
	}
	
	def crearGrillaRecetas(Panel unPanel) {
		val grillaRecetas = new Table(unPanel, typeof(Receta))=>[
		width = 600
		height = 400				
		bindItems(new ObservableProperty(this.modelObject,"ultimasConsultas")) 
		]
		
		new Column<Receta>(grillaRecetas) => [
			title = "Nombre"
			bindContentsToProperty("nombre")
		]
		new Column<Receta>(grillaRecetas) => [
			title = "Calorias"
			bindContentsToProperty("calorias")
		]
		new Column<Receta>(grillaRecetas) => [
			title = "Dificultad"
			bindContentsToProperty("dificultadDePreparacion")
		]
		new Column<Receta>(grillaRecetas) => [
			title = "Temporada"
			bindContentsToProperty("temporadaALaQueCorresponde")
		]
	}
	
	def static main(String[] args){
		new VistaBienvenidoWindow().startApplication
	}


}
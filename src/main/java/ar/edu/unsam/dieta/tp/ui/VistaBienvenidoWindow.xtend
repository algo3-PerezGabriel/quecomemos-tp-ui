package ar.edu.unsam.dieta.tp.ui

import ar.edu.unsam.dieta.tp.model.app.QueComemosAppModel
import ar.tp.dieta.Receta
import java.awt.Color
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.MainWindow

class VistaBienvenidoWindow extends MainWindow<QueComemosAppModel> {
	
	new() {
		super(new QueComemosAppModel())
	}
	
	override createContents(Panel mainPanel) {

		title = "Bienvenido a ¿Qué Comemos?"
		val topPanel = new Panel (mainPanel).layout = new ColumnLayout(1)
		new Label (topPanel).bindValueToProperty("output")

		this.crearGrillaRecetas(mainPanel)
		this.createAccionesGrilla(mainPanel)

	}
	
	def crearGrillaRecetas(Panel unPanel) { 
											
		val grillaRecetas = new Table(unPanel, typeof(Receta))=>[
			width = 600
			height = 400
			bindItems(new ObservableProperty(this.modelObject,"ultimasConsultas"))
			bindValueToProperty("recetaSeleccionada")
		]
		
		new Column<Receta>(grillaRecetas) => [
			title = "Nombre"
			fixedSize = 200
			bindContentsToProperty("nombreDeLaReceta")
			colorearRecetas(it)
		]

		new Column<Receta>(grillaRecetas) => [
			title = "Calorias"
			fixedSize = 100
			bindContentsToProperty("calorias")
			colorearRecetas(it)
		]

		new Column<Receta>(grillaRecetas) => [
			title = "Dificultad"
			fixedSize = 100
			bindContentsToProperty("dificultadDePreparacion")
			colorearRecetas(it)
		]

		new Column<Receta>(grillaRecetas) => [
			title = "Temporada"
			fixedSize = 150
			bindContentsToProperty("temporadaALaQueCorresponde")
			colorearRecetas(it)
		]

	}
		
	def createAccionesGrilla(Panel panel) {
		val elementSelected = new NotNullObservable("recetaSeleccionada")
		val buttonsPanel = new Panel(panel).layout = new HorizontalLayout
		
		new Button(buttonsPanel) => [
			caption = "Ver"
			onClick = [|this.visualizarReceta]
			bindEnabled(elementSelected)
		]

		new Button(buttonsPanel) => [
			caption = "Favorita"
			onClick = [|modelObject.favearReceta]
			bindEnabled(elementSelected)
		]

	}
	
	def void visualizarReceta(){
		this.openDialog(new VistaDetalleReceta(this, modelObject.vistaDetalle()))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.ultimasConsultas]
		dialog.open
	}
		
	def colorearRecetas(Column<Receta> it) {
		bindBackground("devolverme").transformer = [ Receta unaReceta | 
			if(modelObject.theUser.creeEstaReceta(unaReceta)){
				Color.RED //Recetas que fueron creadas por el usuario EN ROJO.
			}
			else{
				if(modelObject.recetarioPublico.recetarioContiene(unaReceta)){
					Color.MAGENTA //Recetas PUBLICAS en MAGENTA.
				}
				else{
					Color.YELLOW //Recetas que son de otro usuario que pertenece al mismo grupo EN AMARILLO.
				}
			}
		]
	}
	
	def static main(String[] args){
		new  VistaBienvenidoWindow().startApplication()
	}
	
}
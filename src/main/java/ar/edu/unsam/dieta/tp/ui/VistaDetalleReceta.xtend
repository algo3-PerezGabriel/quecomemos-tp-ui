package ar.edu.unsam.dieta.tp.ui

import ar.tp.dieta.Ingrediente
import ar.tp.dieta.Receta
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner

class VistaDetalleReceta extends TransactionalDialog<Receta> {

	new (WindowOwner window, Receta modelo){
		super(window, modelo)
		title = "Detalle de receta"
	}

	override protected createFormPanel(Panel mainPanel) {

		val topPanel = new Panel (mainPanel)
		topPanel.layout = new ColumnLayout(1)
		new Label (topPanel).bindValueToProperty("nombreDeLaReceta")
		val datosPanel = new Panel (topPanel)
		datosPanel.layout = new HorizontalLayout
		new Label(datosPanel).bindValueToProperty("calorias")
		new Label(datosPanel).setText("Calorias")
		new Label(datosPanel).setText("Creado por: ")
		new Label(datosPanel).bindValueToProperty("autor")

		val centerPanel = new Panel(mainPanel) 
		centerPanel.layout = new ColumnLayout(2)

		val izqPanel = new Panel (centerPanel)
		new Label (izqPanel).setText("Dificultad")
		new Label (izqPanel).bindValueToProperty("dificultadDePreparacion") 
		new Label (izqPanel).setText("Ingredientes")
		crearGrillaIngredientes(izqPanel) 

		val favoritaPanel = new Panel (izqPanel)
		favoritaPanel.layout = new HorizontalLayout
		new CheckBox(favoritaPanel) 
		new Label (favoritaPanel).setText("Favorita")
		
		val derPanel = new Panel (centerPanel) // columna der
		new Label (derPanel).setText("Temporada")
		new Label (derPanel).bindValueToProperty("temporadaALaQueCorresponde")

		new Label (derPanel).setText ("Condimentos")
		new List<Ingrediente> (derPanel).bindItemsToProperty("condimentos")
		
		new Label (derPanel).setText("CondicionesPreexistentes")
		new List<String> (derPanel)=> [ 
			bindItems(new ObservableProperty (this.modelObject, "obtenerCondicionesAsString"))
		]

		val botPanel = new Panel(mainPanel)
		new Label (botPanel).setText("Proceso de preparacion:")
		new Label (botPanel).bindValueToProperty("procesoDePreparacion")
		new Button(botPanel) => [
      		setCaption("Volver")
      		onClick [|this.cancel]
		]
		
	}
	
	def crearGrillaIngredientes(Panel unPanel){
		val grillaIngredientes = new Table (unPanel, typeof(Ingrediente) ) =>[
			width = 600
			height = 400				
			bindItems(new ObservableProperty(this.modelObject, "ingredientes")) 
		]

		new Column<Ingrediente>(grillaIngredientes) => [
		title = "Dosis"
		bindContentsToProperty("cantidad")
		]
		
		new Column<Ingrediente>(grillaIngredientes) => [
			title = "Ingrediente"
			bindContentsToProperty("nombre")
		]
	}
	
		
}
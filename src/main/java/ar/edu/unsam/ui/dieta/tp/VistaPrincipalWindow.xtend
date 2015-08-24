package ar.edu.unsam.ui.dieta.tp

import ar.tp.dieta.Ingrediente
import ar.tp.dieta.IngredienteBuilder
import ar.tp.dieta.Receta
import ar.tp.dieta.RecetaBuilder
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.List

class VistaPrincipalWindow extends MainWindow<Receta> {
	
	new(){
		super(new RecetaBuilder("Arroz Blanco")
			.calorias(10).autor("Antonio Gasalla")
			.dificultad("Facil")
			.procesoPreparacion("Hervir el arroz. Comer.")
			.temporada("Invierno")
			.agregarIngrediente(new IngredienteBuilder("arroz").cantidad(500).build())
			.agregarIngrediente(new IngredienteBuilder("papa").cantidad(200).build())
			.agregarIngrediente(new IngredienteBuilder("azucar").cantidad(200).build())
			.agregarCondimento(new IngredienteBuilder("sal").build())
			.agregarCondimento(new IngredienteBuilder("vinagre").build())
			.build()
		)
	}

	override createContents(Panel mainPanel) {
		
		title = "Detalle de receta"
// el mainPanel lo divido en 3, unax parte bajo la otra

// ----------TOP PANEL---------------

		val topPanel = new Panel (mainPanel)
		topPanel.layout = new ColumnLayout(1)
		new Label (topPanel).bindValueToProperty("nombreDeLaReceta")
		val datosPanel = new Panel (topPanel)
		datosPanel.layout = new HorizontalLayout
		new Label(datosPanel).bindValueToProperty("calorias")
		new Label(datosPanel).setText("Calorias")
		new Label(datosPanel).setText("Creado por: ")
		new Label(datosPanel).bindValueToProperty("autor")

//---------------end topPanel---------------		

//---------------centerPanel------------

		val centerPanel = new Panel(mainPanel) 
		centerPanel.layout = new ColumnLayout(2)
		val izqPanel = new Panel (centerPanel)
		new Label (izqPanel).setText("Dificultad")
		new Label (izqPanel).bindValueToProperty("dificultadDePreparacion") 
		new Label (izqPanel).setText("Ingredientes")
		crearGrillaIngredientes(izqPanel) 
		//ACA HAY QUE AGREGAR EL CHECKBOX DE FAVORITA
		
		val derPanel = new Panel (centerPanel) // columna der
		new Label (derPanel).setText("Temporada")
		new Label (derPanel).bindValueToProperty("temporadaALaQueCorresponde")
		new Label (derPanel).setText ("Condimentos")
		
		new List (derPanel).bindItemsToProperty("condimentos")
		/* Ahora se trabaja con una lista de string
		=> [ // TODO ESTO PARECE FUNCIONAR, PERO NO SE COMO LO HACE
			bindItems(new ObservableProperty (this.modelObject, "condimentos"))
			.adapter = (new PropertyAdapter(typeof(Ingrediente), "nombre"))
			width = 50
			height = 50
			]*/
			
		new Label (derPanel).setText("CondicionesPreexistentes")
		new List (derPanel).bindItemsToProperty("inadecuadaCondiciones")
		
//------------------------end centerPanel---------------------

//----------------------botPanel---------------------

		val botPanel = new Panel(mainPanel)
		new Label (botPanel).setText("Proceso de preparacion:")
		new Label (botPanel).bindValueToProperty("procesoDePreparacion")	
		
		
//--------------------------end botPanel---------------
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
	
	def static main(String[] args){
		new VistaPrincipalWindow().startApplication
	}
		
}
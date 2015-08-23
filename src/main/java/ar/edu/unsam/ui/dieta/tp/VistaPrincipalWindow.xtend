package ar.edu.unsam.ui.dieta.tp

import ar.tp.dieta.IngredienteBuilder
import ar.tp.dieta.Receta
import ar.tp.dieta.RecetaBuilder
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout

class VistaPrincipalWindow extends MainWindow<Receta> {
	
	new(){
		super(new RecetaBuilder("Arroz Blanco").calorias(10).autor("Antonio Gasalla").dificultad("Facil").procesoPreparacion("Hervir el arroz. Comer.").temporada("Invierno").agregar(new IngredienteBuilder("arroz").cantidad(2).build()).build())
	}

	override createContents(Panel mainPanel) {
		
		title = "Detalle de receta"
// el mainPanel lo divido en 3, una parte bajo la otra

// ----------TOP PANEL---------------

		val topPanel = new Panel (mainPanel)
		new Label (topPanel) // se bindea al nombre de la receta
		val datosPanel = new Panel (topPanel) // aca se meten las calorias y el creador
		datosPanel.layout = new HorizontalLayout
		new Label(datosPanel) //se bindea a las calorias
		new Label(datosPanel) // se bindea al creador

//---------------end topPanel---------------		

//---------------centerPanel------------

		val centerPanel = new Panel(mainPanel) 
		centerPanel.layout = new ColumnLayout(2) //el panel central q tenga 2 columnas
		val izqPanel = new Panel (centerPanel) // columna izq
		new Label (izqPanel).setText("Dificultad")
		new Label (izqPanel) // bindear a la dificultad de la receta modelo
		new Label (izqPanel).setText("Ingredientes")
		// ACA HAY QUE AGREGAR LA GRILLA DE INGREDIENTES
		//ACA HAY QUE AGREGAR EL CHECKBOX DE FAVORITA
		
		val derPanel = new Panel (centerPanel) // columna der
		new Label (derPanel).setText("Temporada")
		new Label (derPanel) // bind a temporada del modelo
		new Label (derPanel).setText ("Condimentos")
		//ACA HAY QUE AGREGAR EL TEXTBOX PARA LOS CONDIMENTOS
		new Label (derPanel).setText("CondicionesPreexistentes")
		//ACA HAY QUE AGREGAR EL TEXTBOX DE LAS CONDICIONES PREEXISTENTES
		
//------------------------end centerPanel---------------------

//----------------------botPanel---------------------

		val botPanel = new Panel(mainPanel)
		new Label (botPanel).setText("Proceso de preparacion")
		//aca se pone el objeto que contenga el texto de preparacion que no se cual es.
		
		
//--------------------------end botPanel---------------



/*
		mainPanel.layout = new ColumnLayout(2)
		
		val panelDeArriba = new Panel(mainPanel)
		new Label(panelDeArriba).bindValueToProperty("nombreDeLaReceta")
		
		val panelIzquierdo = new Panel(mainPanel)
		new Label(panelIzquierdo).bindValueToProperty("calorias")
		
		val panelDerecho = new Panel(mainPanel)
		new Label(panelDerecho).text = "Creado por"

*/
	}
	
	def static main(String[] args){
		new VistaPrincipalWindow().startApplication
	}
		
}
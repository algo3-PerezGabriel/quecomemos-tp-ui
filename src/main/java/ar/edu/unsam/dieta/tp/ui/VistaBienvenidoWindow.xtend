package ar.edu.unsam.dieta.tp.ui

import ar.edu.unsam.dieta.tp.model.app.QueComemosAppModel
import ar.tp.dieta.Receta
import java.awt.Color
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.CheckBox

class VistaBienvenidoWindow extends TransactionalDialog<QueComemosAppModel> {

	
	new(WindowOwner owner, QueComemosAppModel model) {
		super(owner, model)
		title = "Bienvenido a que comemos?"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		val busquedaPanel = new Panel(mainPanel).layout = new ColumnLayout(2)
		val izqPanel = new Panel(busquedaPanel)
		new Label(izqPanel).setText("Nombre")
		new TextBox(izqPanel).bindValueToProperty("conNombre")
		new Label(izqPanel).setText("Dificultad")
		new Selector(izqPanel)=>[
			allowNull = false
			bindItemsToProperty("dificultades")	
			bindValueToProperty("conDificultad")
			]
		new Label(izqPanel).setText("Que Contenga Ingrediente: ")
		new TextBox(izqPanel).bindValueToProperty("conIngrediente")
		
		val derPanel = new Panel(busquedaPanel)
		new Label(derPanel).setText("Calorias")
		val caloriasPanel = new Panel(derPanel).layout = new HorizontalLayout()
		new Label(caloriasPanel).setText("De: ") 
		new TextBox(caloriasPanel).bindValueToProperty("caloriasInferior")
		new Label(caloriasPanel).setText("a :")
		new TextBox(caloriasPanel).bindValueToProperty("caloriasSuperior")
		new Label(derPanel).setText("Temporada") 
		new Selector(derPanel)=>[
			allowNull = false
			bindValueToProperty("conTemporada")
			bindItemsToProperty("temporadas")
			]
		val filtrosCheckPanel = new Panel(derPanel).layout = new HorizontalLayout
		new CheckBox(filtrosCheckPanel).bindValueToProperty("conFiltrosUsuario")
		new Label(filtrosCheckPanel).setText("Aplicar filtros del usuario")
		
		val busquedaButtonPanel = new Panel(mainPanel).layout = new HorizontalLayout
		new Button(busquedaButtonPanel) => [
			caption = "Buscar"
			onClick = [|modelObject.ejecutarBusqueda]
		]
		
		
		val grillPanel = new Panel (mainPanel).layout = new ColumnLayout(1)
		new Label (grillPanel).bindValueToProperty("outputTituloGrilla")

		this.crearGrillaRecetas(mainPanel)
		this.createAccionesGrilla(mainPanel)

	}
	
	def crearGrillaRecetas(Panel unPanel) { 
											
		val grillaRecetas = new Table(unPanel, typeof(Receta))=>[
			width = 600
			height = 400
			bindItemsToProperty("recetasEnGrilla")
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
		//dialog.onAccept[|modelObject.recetasEnGrilla]
		dialog.open
	}
		
	def colorearRecetas(Column<Receta> it) {
		bindBackground("devolverme").transformer = [ Receta unaReceta | 
			if(modelObject.theUser.creeEstaReceta(unaReceta)){
				Color.GREEN //Recetas que fueron creadas por el usuario EN verde.
			}
			else{
				if(modelObject.recetario.recetarioContiene(unaReceta)){
					Color.BLUE //Recetas PUBLICAS en azul.
				}
				else{
					Color.YELLOW //Recetas que son de otro usuario que pertenece al mismo grupo EN AMARILLO.
				}
			}
		]
	}
	
}
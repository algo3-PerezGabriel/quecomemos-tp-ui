package ar.edu.unsam.dieta.tp.model.app

import ar.tp.dieta.AgregaResultadosAFavoritos
import ar.tp.dieta.Busqueda
import ar.tp.dieta.RepoRecetas
import ar.tp.dieta.RutinaActiva
import ar.tp.dieta.Usuario
import ar.tp.dieta.UsuarioBuilder
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import ar.tp.dieta.FiltroExcesoDeCalorias
import ar.tp.dieta.Receta
import java.util.List
import java.util.ArrayList
import ar.tp.dieta.IngredienteBuilder

@Observable
@Accessors
class QueComemosAppModel extends RepoRecetas {
	
	Usuario theUser
	String output
	AgregaResultadosAFavoritos accionConsulta
	Receta recetaSeleccionada
	List<Receta> topTenConsultas = new ArrayList<Receta>
	Busqueda busquedaPorIngredienteCaro = new Busqueda => [
			agregarFiltro(new FiltroExcesoDeCalorias) //Filtra las recetas que tienen 500 o menos cal
	]
	
	
	new(){
		new RepoRecetas	//Creo las recetas usando la clase RepoRecetas del domain.
		theUser = new UsuarioBuilder("Marcela") //Creacion usuario Marcela
					.peso(120.4)
					.altura(1.75)
					.fechaNacimiento(1992, 6, 4)
					.sexo("F")
					.rutina(new RutinaActiva)
					.preferencia("carne")
					.preferencia("pescado")
					.email("mujersincondicion@test.com")
					//.conRecetaFavorita(gelatinaFrambuesa) Recetas favoritas del repo publico
					//.conRecetaFavorita(arrozConPollo)
					.build()
		theUser => [
			agregarBusqueda(busquedaPorIngredienteCaro)
			setRecetario(recetarioPublico)
			crearReceta("Pastel de papa", 1500, "Marcela", "Very dificult", "Hervir la papa, sellar la carne picada, mezclar ambas en una fuente y poner durante 40 minutos en el horno", "Todo el año", new IngredienteBuilder("carne picada").cantidad(500).build(), new IngredienteBuilder("papa").cantidad(300).build())
			crearReceta("Fideos con Tuco", 400, "Marcela", "Facil", "Hervir los fideos, mezclar con la salsa de tomate caliente.", "Todo el año", new IngredienteBuilder("fideos").cantidad(200).build(), new IngredienteBuilder("tomate").cantidad(300).build())
		]
		topTenConsultas = recetarioPublico.getRecetas
	}
	
	def ultimasConsultas(){
		if(!theUser.sinFavoritas){ //Si hay recetas Favoritas.
			output = "Estas son tus recetas favoritas"
			theUser.recetasFavoritas
		}
		else{
			if(!theUser.misBusquedas.empty){ //Si hay busquedas
				output = "Estas fueron tus últimas consultas"
				theUser.busquedaFiltrada()
			}
			else{ //Si no hay recetas favoritas ni busquedas
				output = "Estas son las recetas top del momento"
				this.topTenConsultas
			}
		}
	}
	
	def favearReceta(){
		if(theUser.tieneFavorita(recetaSeleccionada)){
			theUser.quitarFavorita(recetaSeleccionada)
		}
		else{
			theUser.agregarRecetaFavorita(recetaSeleccionada)
		}
	}
	
	def vistaDetalle() {
		var modeloDetalle = new VistaRecetaModel(theUser, recetaSeleccionada)
		modeloDetalle
	}
	
}
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

@Observable
@Accessors
class QueComemosAppModel extends RepoRecetas {
	
	Usuario Marcela
	String output
	AgregaResultadosAFavoritos accionConsulta
	Receta recetaSeleccionada
	Busqueda busquedaPorIngredienteCaro = new Busqueda => [
			agregarFiltro(new FiltroExcesoDeCalorias) //Filtra las recetas que tienen 500 o menos cal
	]
	
	new(){
		new RepoRecetas	//Creo las recetas usando la clase RepoRecetas del domain.
		Marcela = new UsuarioBuilder("Marcela")
					.peso(120.4)
					.altura(1.75)
					.fechaNacimiento(1992, 6, 4)
					.sexo("F")
					.rutina(new RutinaActiva)
					.preferencia("carne")
					.preferencia("pescado")
					.email("mujersincondicion@test.com")
					.conRecetaFavorita(gelatinaFrambuesa)
					.build()		
		Marcela => [
			agregarBusqueda(busquedaPorIngredienteCaro)
			setRecetario(recetarioPublico)
		]
		
		//Verificado OK si se agregan Recetas Favoritas por default.
		//Marcela.agregarRecetaFavorita(arrozConPollo) 
		//Marcela.agregarRecetaFavorita(lomoMostaza)
		
	}

	//Falta Definir comportamientos de favoritas	
	def getFavorita(){
		
	}

	def setFavorita(){
	
	}
	
	def ultimasConsultas(){
		if(!Marcela.recetasFavoritas.isEmpty){ //Si hay recetas Favoritas.
			output = "Estas son tus recetas favoritas"
			Marcela.recetasFavoritas
		}
		else{
			if(!Marcela.misBusquedas.isEmpty){ //Si hay busquedas
				output = "Estas fueron tus últimas consultas"
				Marcela.busquedaFiltrada()
			}
			else{ //Si no hay recetas favoritas ni busquedas
				output = "Estas son las recetas top del momento"
				Marcela.busquedaFiltrada()
			//	return(Marcela.acciones.getRecetasFinales)
			}
		}
	}
	
	def vistaDetalle() {
		var modeloDetalle = new VistaRecetaModel(Marcela, recetaSeleccionada)
		modeloDetalle
	}
	
}
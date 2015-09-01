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

@Observable
@Accessors
class QueComemosAppModel extends RepoRecetas {
	
	Usuario theUser
	String output
	AgregaResultadosAFavoritos accionConsulta
	Receta recetaSeleccionada
	List<Receta> topTenConsultas = new ArrayList<Receta>
//	Busqueda busquedaPorIngredienteCaro = new Busqueda => [
//			agregarFiltro(new FiltroExcesoDeCalorias) //Filtra las recetas que tienen 500 o menos cal
//	]
	
	
	new(){
		new RepoRecetas	//Creo las recetas usando la clase RepoRecetas del domain.
		theUser = new UsuarioBuilder("Marcela")
					.peso(120.4)
					.altura(1.75)
					.fechaNacimiento(1992, 6, 4)
					.sexo("F")
					.rutina(new RutinaActiva)
					.preferencia("carne")
					.preferencia("pescado")
					.email("mujersincondicion@test.com")
//					.conRecetaFavorita(gelatinaFrambuesa)
					.build()		
//		theUser => [
//			agregarBusqueda(busquedaPorIngredienteCaro)
//			setRecetario(recetarioPublico)
//		]
		topTenConsultas = recetarioPublico.getRecetas //aca inicializar con datos de ejemplo el TOPTEN
	}
	
	def ultimasConsultas(){
		if(!theUser.sinFavoritas){ //Si hay recetas Favoritas.
			output = "Estas son tus recetas favoritas"
			theUser.recetasFavoritas
		}
		else{
			if(!theUser.sinConsultadas){ //Si hay busquedas
				output = "Estas fueron tus últimas consultas"
				theUser.ultimasConsultadas
			}
			else{ //Si no hay recetas favoritas ni busquedas
				output = "Estas son las recetas top del momento"
				this.topTenConsultas
			}
		}
	}
	
	def favearReceta(){// ESTO NO ESTÁ LINDO, FUNCIONA PERO DEBERÍA TENER UNA SOLUCION MEJOR
		if(theUser.tieneFavorita(recetaSeleccionada)){theUser.quitarFavorita(recetaSeleccionada)}
		else{theUser.agregarRecetaFavorita(recetaSeleccionada)}
	}
	
	def vistaDetalle() {
		var modeloDetalle = new VistaRecetaModel(theUser, recetaSeleccionada)
		modeloDetalle
	}
	
}
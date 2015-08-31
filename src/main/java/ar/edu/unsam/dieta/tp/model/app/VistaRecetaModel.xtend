package ar.edu.unsam.dieta.tp.model.app

import ar.tp.dieta.Receta
import ar.tp.dieta.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class VistaRecetaModel {

	Usuario elUsuario
	Receta laReceta
	
	new(Usuario unUsuario,Receta unaReceta){
		elUsuario = unUsuario
		laReceta = unaReceta
	}
	
	def getEsFavorita(){
		elUsuario.tieneFavorita(laReceta)
	}
	
	def setEsFavorita(){
		elUsuario.agregarRecetaFavorita(laReceta)
	}
	
}
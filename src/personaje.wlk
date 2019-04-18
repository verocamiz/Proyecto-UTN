import artefactos.*
import hechizos.*

class NoLeAlcanza inherits Exception{}

class Personaje {

	const valorBase = 3
	var hechizoPreferido = hechizoBasico
	var valorBaseDeLucha = 1
	var property artefactos = []
	var property oro = 100
	var property capacidadMaxima = 200
    var property comerciante
    
  
   
	method nivelDeHechiceria () {
		return valorBase*hechizoPreferido.poder() + fuerzaOscura.energia()
	}   
	method cambiarHechizoPreferido(nuevoHechizo){
		
		var importeHechizo = 0.max(nuevoHechizo.precio(null)-hechizoPreferido.precio(null)/2) 
		self.validarPrecio(importeHechizo)
		oro = oro - importeHechizo
		hechizoPreferido = nuevoHechizo
	}	
	method validarPrecio(precio){
		if (oro < precio){
			throw new NoLeAlcanza("el personaje no puede costearlo")
	    }	
	}
	method seCreePoderoso (){
		return hechizoPreferido.esPoderoso() 
	}
    method nivelDeLucha(){
		return valorBaseDeLucha + self.puntosAdicionales()
	}
	method puntosAdicionales () {
		return artefactos.sum({unArtefacto => unArtefacto.puntosLucha(self)})
	}
	method modificarValorBaseLucha (nuevoValor){
		valorBaseDeLucha = nuevoValor
	}
   	method agregar(nuevoArtefacto){
   		var importe = nuevoArtefacto.precio() + comerciante.impuesto(nuevoArtefacto.precio())
   		self.validarPrecio(importe)
   		self.verificarCapacidad(nuevoArtefacto)
   		oro= oro-importe
   		artefactos.add(nuevoArtefacto)
   	}
    method verificarCapacidad(nuevoArtefacto){
   	    if(nuevoArtefacto.peso()+self.pesoTotal()>capacidadMaxima){
   		    throw new NoLeAlcanza("El peso supera la capacidad maxima del personaje")
   	    }
    }
	method eliminar(unArtefacto){
		artefactos.remove(unArtefacto)
	} 
	method eliminarTodos() {
		artefactos.clear()
   	}
    method mayorNivelDeLucha(){
		return self.nivelDeLucha() > self.nivelDeHechiceria()
	}
   	method soloTieneEspejo(){
   		return artefactos.contains(espejo) and artefactos.size() == 1
   	}
   	method mayorPertenencia(){
   		return (artefactos.filter({unArtefacto =>unArtefacto != espejo })).max({unArtefacto =>unArtefacto.puntosLucha(self)})
    }
    method estaCargado(){
    	return artefactos.size() > 4
    }
    
    method pesoTotal(){
    	return artefactos.sum({unArtefacto => unArtefacto.peso()})
    }
}


class PersonajeNoControlado inherits Personaje {
	var property nivel
	override method nivelDeLucha(){
		return super()* nivel.multiplicador()
	}
}

class Nivel {
	var property multiplicador
}
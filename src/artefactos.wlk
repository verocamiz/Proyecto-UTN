
import hechizos.*
class IndiceFueraDeRango inherits Exception{}

class Artefacto {

	var property peso = 0
    var property fechaCompra = new Date()
	
	method peso (){
   		return peso - 1.min(self.dias()/1000) 
   	}
	method dias(){
		return new Date() - fechaCompra
	}
}

class Arma inherits Artefacto{

	const puntosLucha = 3
  
	method puntosLucha(personaje){
   		return puntosLucha 
   	}
   	method precio(){
   		return 5*peso 
   	}
}
object espadaComun inherits Arma {
	override method dias (){
		return 50
	}
} 	
   	
class Collar inherits Artefacto {

	var property perlas = 0
	
	method puntosLucha(personaje){
   		return perlas
   	}
   	method cambiarCantidadPerlas(cantidadNueva){
   		perlas = cantidadNueva
   	}   	
   	method precio(){
   		return 2*perlas
   	}
   	override method peso(){
   		return super() + perlas/2
   	}
}

class Mascara inherits Artefacto{

	var property indiceDeOscuridad
	var property valorMinimo = 4

   
	method puntosLucha(personaje){
		self.verificarIndice(indiceDeOscuridad)
   		return valorMinimo.max((fuerzaOscura.energia()/2)*indiceDeOscuridad)
   	}
   	method verificarIndice(indice){
   		if (indice >1 or indice < 0){
   			throw new IndiceFueraDeRango("el indice de oscuridad va de 1 a 0")
   		}
   	}	
   override method peso(){
   		if(indiceDeOscuridad==1){
   			return super() + (self.puntosLucha(null)-3).max(0)
   		}
   		else {
   			return peso
   	    }
   	}
   	method precio (){
   		return 10*indiceDeOscuridad
   	}
} 

class Armadura inherits Artefacto{

	var property base = 0
	var property refuerzo = ninguno

	method puntosLucha(personaje) {
 		return base + refuerzo.puntosRefuerzo(personaje)
 	}
	method precio(){
		return refuerzo.precio(self)
	}
	override method peso () {
		return super() + refuerzo.pesoExtra()
	}
}
 
class CotaDeMalla{

	var property poder 
	var peso = 1

 	method poderRefuerzo(personaje){
 		return poder
 	}
 	method precio(armadura){
 		return poder/2
 	}
 	method pesoExtra () {
 		return peso
 	}
}
 
object bendicion{
	
	method puntosRefuerzo(personaje){
		return personaje.nivelDeHechiceria()
	}
	method precio(armadura){
	return armadura.base()
	}
	method pesoExtra() {
		return 0
	}
}
 


object ninguno {

	method puntosRefuerzo(personaje){
		return 0
	}
	method precio(armadura){
		return 2
	}
	method pesoExtra(){
		return 0
	}
}

object espejo {

    var property peso = 0
	
	method puntosLucha(personaje){
		if (personaje.soloTieneEspejo()){
			return 0
		} else {
			return (personaje.mayorPertenencia()).puntosLucha(personaje)
		
		}
	}
	method precio(){
		return 90
	}
	method peso(){
		return peso
	}
}




 
 
 
 
 
 
 
 
 
 
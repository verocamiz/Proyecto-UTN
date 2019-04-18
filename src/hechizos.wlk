
class Hechizo {

	method esPoderoso(){
   		return self.poder() > 15
   }
    method poder()
    method peso(){
		return 0
	}
	method precio(armadura){
		return self.poder()
	}
	method pesoExtra () {
		if (self.poder().even()){
			return 2
		} else {
			return  1 
		}
		
		}
}

object hechizoBasico inherits Hechizo{

	const poder = 10

	override method poder(){
		return poder
   }
}

class HechizoDeLogos inherits Hechizo{

	var property nombre
	var property multiploDe
	override method poder() {
   	 	return multiploDe * nombre.size() 
	}
}

object fuerzaOscura {

	var poder = 5
	
    method energia() {
   		return poder
   	}
   	method eclipse(){
   		poder *= 2 	
   	}
}


object libroDeHechizos inherits Hechizo{

	var hechizos = []

	override method poder() {
    	return hechizos.filter({unHechizo=>unHechizo.esPoderoso()}).sum({unHechizo=>unHechizo.poder()})
    }
    method agregar(unHechizo){
    	hechizos.add(unHechizo)
    }
    method eliminar(unHechizo){
    	hechizos.remove(unHechizo)
    }
    override method precio(armadura){
    	return hechizos.size()*10+hechizos.sum({unHechizo=>unHechizo.poder()})
    }
}

class HechizoComercial inherits Hechizo{
 var multiplicador = 2
 var porcentaje = 20
 var nombre = "el hechizo comercial"
 
 override method poder(){
   	return (((nombre.size())*porcentaje).div(100))*multiplicador
 }	
}
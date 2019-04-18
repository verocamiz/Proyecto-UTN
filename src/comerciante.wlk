class Comerciante {
 	var property tipoDeComerciante 
 	
 	method impuesto (precio){
 	 return iva.adicional(precio)+tipoDeComerciante.adicional(precio) 
 }
    method recategorizacion(){
    	tipoDeComerciante.recategorizacion(self)
    }
 }

 object iva{
 	method adicional(precio){
 		return precio*21/100
 	}
 }

 
 class ComercianteIndependiente {
 	var property comision = 0
 	method adicional (precio) {
 		return precio *comision/100
 	}
 	
 	method recategorizacion(comerciante){
 		comision*=2
 		self.registrar(comerciante)
 	}
 	
 	method registrar(comerciante){
 		if(comision>21){
 			comerciante.tipoDeComerciante(comercianteRegistrado)
 		}
 	}
 }
 
 
 object comercianteRegistrado {
 	
 	method adicional (precio){
 		return 0
 	}
 	
 	method recategorizacion(comerciante){
 		comerciante.tipoDeComerciante(new ComercianteConImpuesto())
 	}
 	
} 	
 class ComercianteConImpuesto {
 	var property minimo = 5
 	method adicional(precio){
 		if(precio < minimo){
 			return 0
 		} else{
 			return (precio-minimo)*35/100
 		}
 	}
 	method recategorizacion(comerciante){
 		
 	}
 
 }
 
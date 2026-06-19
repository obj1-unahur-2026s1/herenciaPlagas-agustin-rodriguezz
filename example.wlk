class Elemento{
  method esBuenoParaHumanos()
}



class Hogar inherits Elemento{
  var nivelDeMugre
  var confort

  override method esBuenoParaHumanos(){
    return nivelDeMugre <= confort/2
  }

  method sufrirAtaque(plaga) {
    nivelDeMugre += plaga.nivelDeDaño()
  }
}

class Huerta inherits Elemento{
  var capacidadDeProduccion
  var property nivelASuperar = 50


  override method esBuenoParaHumanos(){
    return capacidadDeProduccion > nivelASuperar
  }

  method sufrirAtaque(plaga) {
    capacidadDeProduccion -= plaga.nivelDeDaño() * 0.1
    if (plaga.transmitenEnfermedades()){
      capacidadDeProduccion-=10
    }
  }

}

class Mascota inherits Elemento{
  var nivelDeSalud


  override method esBuenoParaHumanos(){
    return nivelDeSalud > 250
  }

  method sufrirAtaque(plaga) {
    if (plaga.transmitenEnfermedades()){
      nivelDeSalud-=plaga.nivelDeDaño()
    }
  }

}

class Barrio{
  var elementos=[]

  method añadirElemento(elemento) {
    elementos.add(elemento)
  }

  method sacarElemento(elemento){
    elementos.remove(elemento)
  }

  method esCopado() {
    return elementos.count{e => e.esBuenoParaHumanos()} >
           elementos.count{e => !e.esBuenoParaHumanos()}
  }
}


class Plaga{
  var poblacion 
  method poblacion()= poblacion

  method nivelDeDaño()

  method transmitenEnfermedades(){
    return poblacion >=10
  }

  method atacar(elemento){
    elemento.sufrirAtaque(self)
    poblacion += (poblacion*0.1) 
  }

}

class Cucarachas inherits Plaga{
  var pesoPromedio 

  override method nivelDeDaño(){
    return poblacion/2
  }

  override method transmitenEnfermedades(){
    return super() and (pesoPromedio >= 10)
  }

  override method atacar(elemento){
    super(elemento)
    pesoPromedio+=2
  }
}

class Pulgas inherits Plaga{

  override method nivelDeDaño(){
    return poblacion*2
  }

  
}

class Garrapatas inherits Pulgas{


  override method atacar(elemento){
    elemento.sufrirAtaque(self)
    poblacion += poblacion * 0.2
  }
}


class Mosquitos inherits Plaga{
  
  override method nivelDeDaño(){
    return poblacion
  }

 override method transmitenEnfermedades(){
    return super() and (poblacion % 3 == 0)
  }

}




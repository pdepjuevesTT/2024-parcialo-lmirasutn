class Persona {
  var property listaDeCosas = []
  var property tarjetasCredito
  var property cuentasBancarias
  var property pagoPreferido
  var property trabajo
  var property saldo
  
  method comprar(cosa) {
    if (pagoPreferido.puedePagar(cosa)) {
      pagoPreferido.pagar(cosa)
      listaDeCosas.add(cosa)
    }
  }
  //2 
  method cambiarFormaDePago(pago){
   pagoPreferido = pago
  }


  method cuotasImpagas(){
    tarjetasCredito.sum{c => c.cuotas()} // obtengo la suma de cuotas impagas
  }
  method pagarCuota(objeto) = tarjetasCredito.pagar(objeto)
  
}

class FormasDePago {
  var property saldo
  
  method disminuirDinero(monto) {
    saldo = saldo - monto
  }
  
  method puedePagar(objeto) = saldo > objeto.precio()
  
  method pagar(objeto) {
    self.disminuirDinero(objeto.precio())
  }
}

object efectivo inherits FormasDePago (saldo = 500) {
  
}

class CuentaBancaria inherits FormasDePago {
  
}

class TarjetaDeCredito inherits FormasDePago(saldo = bancoEmisor.maximoPermitido()) {
  var property bancoEmisor
  var property cuotas
  
  override method puedePagar(
    objeto
  ) = bancoEmisor.maximoPermitido() > objeto.precio() && cuotas == 0
  
  method precioCuota(objeto) = (objeto.precio() / cuotas) + (objeto.precio() * bancoEmisor.tasaInteres())
  
  override method pagar(objeto) {
    self.disminuirDinero(self.precioCuota(objeto))
    cuotas -=1
  }
}

//5. solo queda rezar 
class TarjetaCristiana inherits TarjetaDeCredito{
    var property fe

    method fuiALujan(){´
    fe +=1 
    }

    override method precioCuota(objeto) =(super() - 200 * fe).min(0)  
}


class BancoEmisor {
  var property maximoPermitido = 5000
  var property tasaInteres = 0.5
}

class Cosa {
  var property precio
}

class Trabajo {
  var property salario
  var property trabajadores = []
  
    method aumentarSalario(monto){
        salario += monto
    } 

  method pagarSalario() {
    trabajadores.forEach({ t => t.saldo(t.saldo() + salario) })
  }

    method agregarTrabajador(trabajador){
        trabajadores.add(trabajador)
    }
    
}

object mes {
  var property mesActual = 11
  var property trabajos = [ingeniero] 
  var property personas = []
  method condicionAvanzarMes() {
    if (mesActual.between(1, 11)) {
      mesActual = mesActual + 1
    } else {
      mesActual = 1
    }
  }

    method agregarPersona(persona){
        personas.add(persona)
    }

  const ingeniero = new Trabajo(salario = 3000, trabajadores = [])

  method avanzarMes() {
    self.condicionAvanzarMes()
     trabajos.forEach({ t => t.pagarSalario() }) // todos los trabajos pagan el salario
     personas.forEach({p => p.pagarCuota()}) // todos pagan sus cuotas

  }

    // 6
    method elQueMasTiene(){
        personas.max{p => p.listaDeCosas().size()}
    }



}

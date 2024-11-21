class Persona {
  var property listaDeCosas = []
  var property tarjetasCredito = []
  var property cuentasBancarias = []
  var property pagoPreferido
  var property trabajo
  var property saldo = 0
  
  method comprar(cosa) {
    if (pagoPreferido.puedePagar(cosa)) {
      pagoPreferido.pagar(cosa)
      listaDeCosas.add(cosa)
    }
  }
  
  method elegirTarjeta(tarjeta) {
    cuentasBancarias.get(tarjeta)
  }
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

class TarjetaDeCredito inherits FormasDePago {
  var property bancoEmisor
  var property cuotas
  var property titulares = []
  
  override method puedePagar(
    objeto
  ) = bancoEmisor.maximoPermitido() > objeto.precio()
  
  method pagarCuota(
    objeto
  ) = (objeto.precio() / cuotas) + (objeto.precio() * bancoEmisor.tasaInteres())
  
  override method pagar(objeto) {
    self.disminuirDinero(self.pagarCuota(objeto))
  }
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
  
  method pagarSalario() {
    trabajadores.forEach({ t => t.saldo(t.saldo() + salario) })
  }

    method agregarTrabajador(trabajador){
        trabajadores.add(trabajador)
    }

}

object mes {
  var property mesActual = 11
  
  method condicionAvanzarMes() {
    if (mesActual.between(1, 11)) {
      mesActual = mesActual + 1
    } else {
      mesActual = 1
    }
  }
  
  method avanzarMes() {
    self.condicionAvanzarMes()
  }
}

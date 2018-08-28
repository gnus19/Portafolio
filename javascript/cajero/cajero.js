class Billete {
  constructor(valor, cantidad) {
    this.valor = valor;
    this.cantidad = cantidad;
  }
}

//Dinero a retirar
var dinero = 0;
var retiro;

//Billetes disponibles en caja
var caja = [];
caja.push( new Billete(50, 3) );
caja.push( new Billete(20, 4) );
caja.push( new Billete(10, 3) );

//Cantidad de billetes a retirar
var entregado = [];

//Boton para activar la funcion atm
var boton = document.getElementById('retirar');
boton.addEventListener("click", atm);

function atm() {
  var texto = document.getElementById("dinero");
  console.log(texto.value);
  dinero = parseInt(texto.value);
  retiro = dinero;

  for (var b of caja) {
  //  document.write(b.valor + ": "+ b.cantidad+"<br>");
    if (dinero > 0) {
      var div = Math.floor(dinero/b.valor);

      if (div > b.cantidad) {
        entregado.push( new Billete(b.valor, b.cantidad) );
        dinero = dinero - (b.cantidad*b.valor);
      }
      else {
        entregado.push( new Billete(b.valor, div) );
        dinero = dinero - (div*b.valor);
      }
    }
  }

  var resultado = document.getElementById("resultado")
  if (dinero == 0) {
    resultado.innerHTML = "Se le ha entregado por "+retiro+"<br>";
    for (e of entregado) {
      if (e.cantidad > 0) {
        resultado.innerHTML += e.cantidad + " billetes de " + e.valor + "<br>";
      }
    }
  }
  else {
    document.write("La transaccion no se pudo realizar.");
  }
}

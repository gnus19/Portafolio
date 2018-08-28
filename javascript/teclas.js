document.addEventListener("keydown", dibujarTeclado);
document.addEventListener("keyup", soltarTecla);

var botonLimpiar = document.getElementById("limpiar");
botonLimpiar.addEventListener("click", limpiar);


var cuadro = document.getElementById("dibujito");
var papel = cuadro.getContext("2d");
//Coordenadas del punto inicial
var x = 150;
var y = 150;

var direccion = [];
var teclas = {
  LEFT: 37,
  UP: 38,
  RIGHT: 39,
  DOWN: 40
};

function dibujarLinea(color, xinicial, yinicial, xfinal, yfinal, lienzo) {
  lienzo.beginPath();
  lienzo.strokeStyle = color;
  lienzo.lineWidth = 3;
  lienzo.moveTo(xinicial, yinicial);
  lienzo.lineTo(xfinal, yfinal);
  lienzo.stroke();
  lienzo.closePath();
}
//*** Inicio del manejo de eventos con teclas ***//
//Funcion para resetear el teclado
function soltarTecla(evento) {
  direccion[evento.keyCode] = false
}
//Dibuja una linea de acuerdo al teclado
function dibujarTeclado(evento) {
  var colorTrazo = "blue"
  var movimiento = 5;
  console.log(evento);
  direccion[evento.keyCode] = true;

  //Mover la linea diagonalmente
  if (direccion[teclas.LEFT]) {
    dibujarLinea(colorTrazo, x, y, x-movimiento, y, papel);
    x = x - movimiento;
  }
  if (direccion[teclas.UP]) {
    dibujarLinea(colorTrazo, x, y, x, y - movimiento, papel);
    y = y - movimiento;
  }
  if (direccion[teclas.RIGHT]) {
    dibujarLinea(colorTrazo, x, y, x+movimiento, y, papel);
    x = x + movimiento;
  }
  if (direccion[teclas.DOWN]) {
    dibujarLinea(colorTrazo, x, y, x, y+movimiento, papel);
    y = y + movimiento;
  }
}
//*** Fin del manejo de eventos con teclas ***//

//*** Manejo de eventos con el mouse ***//
var cuadroM = document.getElementById("dibujito_mouse");
var papelM = cuadroM.getContext("2d");
cuadroM.addEventListener("mousedown", haceClick);
cuadroM.addEventListener("mouseup", sueltaMouse);
cuadroM.addEventListener("mousemove", mueveMouse);

var xMouse;
var yMouse;
var estado = false;

//Hace click en el canvas
function haceClick(evento) {
  estado = true;
  xMouse = evento.layerX;
  yMouse = evento.layerY;
}

//Mueve el mouse
function mueveMouse(evento) {
  if (estado) {
    dibujarLinea("red", xMouse, yMouse, evento.layerX, evento.layerY, papelM);
  }
  xMouse = evento.layerX;
  yMouse = evento.layerY;
}
//Deja de presionar el boton del mouse
function sueltaMouse(evento) {
  estado = false;
}

//*** Fin del manejo con el mouse ***//
// Limpia el Canvas
function limpiar(evento){
  papel.clearRect(0, 0, 300, 300);
  //Punto central o inicial
  dibujarLinea("#AAF", 149, 149, 151, 151, papel);
  //Bordes
  dibujarLinea("#000", 0, 0, 300, 0, papel);
  dibujarLinea("#000", 300, 0, 300, 300, papel);
  dibujarLinea("#000", 300, 300, 0, 300, papel);
  dibujarLinea("#000", 0, 300, 0, 0, papel);
  x = 150;
  y = 150;
}

//Punto central o inicial
dibujarLinea("#AAF", 149, 149, 151, 151, papel);
//Bordes
dibujarLinea("#000", 0, 0, 300, 0, papel);
dibujarLinea("#000", 300, 0, 300, 300, papel);
dibujarLinea("#000", 300, 300, 0, 300, papel);
dibujarLinea("#000", 0, 300, 0, 0, papel);

dibujarLinea("#000", 0, 0, 300, 0, papelM);
dibujarLinea("#000", 300, 0, 300, 300, papelM);
dibujarLinea("#000", 300, 300, 0, 300, papelM);
dibujarLinea("#000", 0, 300, 0, 0, papelM);

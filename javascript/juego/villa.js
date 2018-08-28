document.addEventListener("keydown", dibujarTeclado);
document.addEventListener("keyup", soltarTecla);

var vp = document.getElementById("villaPlatzi");
var papel = vp.getContext("2d");

var fondo = {
  url: "tile.png",
  cargaOk: false
}
fondo.imagen = new Image();
fondo.imagen.src = fondo.url;
//fondo.imagen.addEventListener("load", dibujar);
fondo.imagen.addEventListener("load", cargarFondo);

// vaca
var vaca ={
  url: "vaca.png",
  cargaOk: false
  //imagen: new Image()
}
vaca.imagen = new Image();
vaca.imagen.src = vaca.url;
//vaca.imagen.addEventListener("load", dibujarVaca);
vaca.imagen.addEventListener("load", cargarVaca);

var cerdo ={
  url: "cerdo.png",
  cargaOk: false,
  x: 0,
  y: 0
  //imagen: new Image()
}

//cerdo
cerdo.imagen = new Image();
cerdo.imagen.src = cerdo.url;
//vaca.imagen.addEventListener("load", dibujarVaca);
cerdo.imagen.addEventListener("load", cargarCerdo);
//Posicion del cerdo
cerdo.x = aleatorio(0, 7) * 60;;
cerdo.y = aleatorio(0, 7) * 60;;

// pollo
var pollo ={
  url: "pollo.png",
  cargaOk: false
  //imagen: new Image()
}
pollo.imagen = new Image();
pollo.imagen.src = pollo.url;
//vaca.imagen.addEventListener("load", dibujarVaca);
pollo.imagen.addEventListener("load", cargarPollo);

var numVacas = aleatorio(1, 5);
var numPollos = aleatorio(1, 5);
var numCerdos = 1;
var posicionVaca = [];
var posicionPollo = [];

function aleatorio(min, max) {
  var resultado;
  resultado =  Math.floor(Math.random() * (max - min + 1)) + min;
  return resultado;
}

function cargarFondo(evento) {
  fondo.cargaOk = true;
  dibujar();
}

function cargarVaca(evento) {
  vaca.cargaOk = true;
  for (var i = 0; i < numVacas; i++) {
    var x = aleatorio(0, 7) * 60;
    var y = aleatorio(0, 7) * 60;
    posicionVaca.push([x, y]);
  }
  dibujar();
}
function cargarCerdo(evento) {
  cerdo.cargaOk = true;
  dibujar();
}
function cargarPollo(evento) {
  pollo.cargaOk = true;
  for (var i = 0; i < numPollos; i++) {
    var x = aleatorio(0, 12) * 40;
    var y = aleatorio(0, 12) * 40;
    posicionPollo.push([x, y]);
  }
  dibujar();
}

// Funcion para dibujar las imagenes
function dibujar(evento) {
  if (fondo.cargaOk) {
    papel.drawImage(fondo.imagen, 0, 0);
  }
  if (vaca.cargaOk) {
    for (var i = 0; i < numVacas; i++) {
      var x = posicionVaca[i][0];
      var y = posicionVaca[i][1];
      papel.drawImage(vaca.imagen, x, y);
    }
  }
  if (pollo.cargaOk) {
    for (var i = 0; i < numPollos; i++) {
      var x = posicionPollo[i][0];
      var y = posicionPollo[i][1];
      papel.drawImage(pollo.imagen, x, y);
    }
  }
  if (cerdo.cargaOk) {
    papel.drawImage(cerdo.imagen, cerdo.x, cerdo.y);
  }
}

/* Movimiento con las teclas */
var direccion = [];
var teclas = {
  LEFT: 37,
  UP: 38,
  RIGHT: 39,
  DOWN: 40
};

//*** Inicio del manejo de eventos con teclas ***//
//Funcion para resetear el teclado
function soltarTecla(evento) {
  direccion[evento.keyCode] = false
}
//Dibuja una linea de acuerdo al teclado
function dibujarTeclado(evento) {
  console.log(evento);
  var colorTrazo = "blue"
  var movimiento = 5;
  //console.log(evento);
  direccion[evento.keyCode] = true;

  //Mover la linea diagonalmente
  if (direccion[teclas.LEFT]) {
    //dibujarLinea(colorTrazo, x, y, x-movimiento, y, papel);
    moveLeft();
    //x = x - movimiento;
    //papel.drawImage(cerdo.imagen, cerdo.x-movimiento, cerdo.y);
  }
  if (direccion[teclas.UP]) {
    //dibujarLinea(colorTrazo, x, y, x, y - movimiento, papel);
    moveUp();
    //y = y - movimiento;
    //papel.drawImage(cerdo.imagen, cerdo.x, cerdo.y-movimiento);
  }
  if (direccion[teclas.RIGHT]) {
    //dibujarLinea(colorTrazo, x, y, x+movimiento, y, papel);
    moveRight();
    //x = x + movimiento;
    //papel.drawImage(cerdo.imagen, cerdo.x+movimiento, cerdo.y);
  }
  if (direccion[teclas.DOWN]) {
    //dibujarLinea(colorTrazo, x, y, x, y+movimiento, papel);
    moveDown();
    //y = y + movimiento;
    //papel.drawImage(cerdo.imagen, cerdo.x, cerdo.y+movimiento);
  }
}

function moveLeft() {
  cerdo.x -= 5;
  dibujar();
}
function moveUp() {
  cerdo.y -= 5;
  dibujar();
}
function moveRight() {
  cerdo.x += 5;
  dibujar();
}
function moveDown() {
  cerdo.y += 5;
  dibujar();
}

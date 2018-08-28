
var d = document.getElementById("dibujito");
var texto = document.getElementById("texto_lineas");
var boton = document.getElementById("boton");
boton.addEventListener("click", dibujoPorClick);
var boton2 = document.getElementById("limpiar");
boton2.addEventListener("click", limpiar);

var lienzo = d.getContext("2d");
var lineas = 30;
var ancho = d.width;


function dibujarLinea(color, xinicial, yinicial, xfinal, yfinal) {
  lienzo.beginPath();
  lienzo.strokeStyle = color;
  lienzo.moveTo(xinicial, yinicial);
  lienzo.lineTo(xfinal, yfinal);
  lienzo.stroke();
  lienzo.closePath();
}

function dibujoPorClick() {
  console.log(texto);
  lineas = parseInt(texto.value);
  var factor = ancho/lineas;
  for (var l = 0; l <= lineas; l++) {
    dibujarLinea("#AAF", 0, (l*factor), ((l*factor)+factor), ancho);
    dibujarLinea("red", (l*factor)/2, 0, 150, ((l*factor)+factor)/2);
    dibujarLinea("red", ancho-(l*factor)/2, 0, 150, ((l*factor)+factor)/2);

    dibujarLinea("#AAF", (l*factor), 0, ancho, ((l*factor)+factor));
    dibujarLinea("red", 0, (l*factor)/2, ((l*factor)+factor)/2, 150);
    dibujarLinea("red", 0, ancho-(l*factor)/2, ((l*factor)+factor)/2, 150);

    dibujarLinea("#AAF", ancho-(l*factor), 0, 0, ((l*factor)+factor));
    dibujarLinea("red", ancho, (l*factor)/2, ancho-((l*factor)+factor)/2, 150);
    dibujarLinea("red", ancho, ancho-(l*factor)/2, ancho-((l*factor)+factor)/2, 150);

    dibujarLinea("#AAF", (l*factor), ancho, ancho, ancho-((l*factor)+factor));
    dibujarLinea("red", (l*factor)/2, ancho, 150, (ancho-((l*factor)+factor)/2));
    dibujarLinea("red", ancho-(l*factor)/2, ancho, 150, (ancho-((l*factor)+factor)/2));
  }
}

function limpiar(){
  lienzo.clearRect(0, 0, ancho, ancho);
}

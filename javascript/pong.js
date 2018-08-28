//Clase Tablero, contiene los objetos del tablero
class Tablero {
  constructor(width, height) {
    this.width = width;
    this.height = height;
    this.playing = false;
    this.gameOver = false;
    this.bars = [];
    this.ball = null;

  }
  //Getter para obtener las barras y la pelota
  get getElements(){
    var elements = this.bars.map(function (el) {
      return el;
    });
    elements.push(this.ball);
    return elements;
  }
}

//Clase Vista, representa el contenido visual
class Vista {
  constructor(canvas, board) {
    this.canvas = canvas;
    this.canvas.width = board.width;
    this.canvas.height = board.height;
    this.board = board;
    this.context = canvas.getContext("2d");
  }

  //Funcion dedicada a dibujar el escenario
  draw(){
    var elements = this.board.getElements;
    for (var el of elements) {
      switch (el.kind) {
        case "rectangle":
          this.context.fillRect(el.x, el.y, el.width, el.height);
          break;
        case "circle":
          this.context.beginPath();
          this.context.arc(el.x, el.y, el.radius, 0, 7);
          this.context.fill();
          this.context.closePath();
          break;
        default:
          console.log("Error en draw");
      }
    }
  }

  //Funcion dedicada a limpiar el escenario
  clean(){
    this.context.clearRect(0, 0, this.board.width, this.board.height);
  }

  //Funcion que se encarga de verificar colisiones
  checkCollisions(){
    for (var i = this.board.bars.length-1; i >= 0; i--) {
      var barra = this.board.bars[i];
      //colision con una barra
      if (hit(barra, this.board.ball)) {
        this.board.ball.collision(barra);
      }

      //Rebote en las paredes superior e inferior
      if ((this.board.ball.y + this.board.ball.speedY >= this.board.height - this.board.ball.radius) ||
      (this.board.ball.y + this.board.ball.speedY <= this.board.ball.radius)) {
        this.board.ball.speedY = -this.board.ball.speedY;
      }

      if (this.board.ball.x >= this.board.width) {
        this.board.ball.x = 2*this.board.bars[0].width;
        this.board.ball.speed = 3;
        this.board.ball.speedY = this.board.ball.speed * (-Math.sin(this.board.ball.bounceAngle));
        this.board.ball.speedX = this.board.ball.speed * Math.cos(this.board.ball.bounceAngle);
      }
      if (this.board.ball.x <= 0) {
        this.board.ball.x = this.board.width - 2*this.board.bars[0].width;
        this.board.ball.speed = 3;
        this.board.ball.speedY = this.board.ball.speed * (-Math.sin(this.board.ball.bounceAngle));
        this.board.ball.speedX = this.board.ball.speed * Math.cos(this.board.ball.bounceAngle);
      }
    }
  }
}

//Clase Barra, contiene la informacion de las barras
class Barra {
  constructor(x, y, width, height, board) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.speed = 10;

    this.board = board;
    this.board.bars.push(this);
    this.kind = "rectangle";
  }

  //Funcion que mueve hacia abajo la barra
  down(){
    this.y += this.speed;
    //vista.clean();
    vista.draw();
  }
  //Funcion que mueve la barra hacia arriba
  up(){
    this.y -= this.speed;
    //vista.clean();
    vista.draw();
  }
  //Funcion que muestra la posicion de la barra
  toString(){
    return "x: " + this.x + " y: " + this.y;
  }
}

//Clase Pelota, contiene la informacion de la pelota
class Pelota {
  constructor(x, y, radio, board) {
    this.x = x;
    this.y = y;
    this.radius = radio;
    this.speed = 3;
    this.speedX = 3;
    this.speedY = 0;
    this.board = board;
    this.board.ball = this;
    this.kind = "circle";
    this.direction = 1;

    this.bounceAngle = 0;
    this.maxBounceAngle = Math.PI/12;

  }

  //Funcion que se encarga de mover la pelota
  move(){
    this.x += this.speedX * this.direction;
    this.y += this.speedY;
  }

  //Funcion que se encarga de las colisiones
  collision(bar){
    var relativeIntersectY = ( bar.y + (bar.height / 2) ) - this.y;

    var normalizaedIntersectY = relativeIntersectY / (bar.height / 2);

    this.bounceAngle = normalizaedIntersectY * this.maxBounceAngle;

    this.speedY = this.speed * (-Math.sin(this.bounceAngle));
    this.speedX = this.speed * Math.cos(this.bounceAngle);
    this.speed++;

    if (this.x > (this.board.width / 2)) {
      this.direction = -1;
    }
    else {
      this.direction = 1;
    }

  }

  get width(){
    return this.radius * 2;
  }

  get height(){
    return this.radius * 2;
  }
}

//Funcion para leer los parametros del canvas
function leerCanvas() {
  cuadro.width = anchoTexto.value;
  cuadro.height = altoTexto.value;
  tablero = new Tablero(cuadro.width, cuadro.height);
  vista = new Vista(cuadro, tablero);
  barra1 = new Barra(0, 100, 40, 100, tablero);
  barra2 = new Barra(cuadro.width-40, 100, 40, 100, tablero);
  pelota = new Pelota(350, 100, 10, tablero);
  vista.draw();
  var texto_comenzar = document.getElementById("start");
  texto_comenzar.innerHTML = "Presione la barra espaciadora para empezar y pausar el juego<br />";
  window.requestAnimationFrame(controller);
}

// funcion para mover las barras
function mover(evento) {
  direccion[evento.keyCode] = true;
  if (direccion[teclas.UP]) {
    barra2.up();
  }
  else if (direccion[teclas.DOWN]) {
    barra2.down();
  }

  if (direccion[teclas.W]) {
    barra1.up();
  }
  else if (direccion[teclas.S]) {
    barra1.down();
  }
  else if (evento.keyCode == 32) {
    evento.preventDefault();
    tablero.playing = !tablero.playing;
  }
}
// Funcion para detener las barras
function detener(evento) {
  direccion[evento.keyCode] = false;
}
// Funcion que registra con que barra la pelota colisiono
function hit(a, b) {
  var hit = false;

  //Colisiones horizontal
  if (b.x + b.width >= a.x && b.x < a.x + a.width) {
    //Colisiones verticales
    if (b.y + b.height >= a.y && b.y < a.y + a.height) {
      hit = true;
    }
  }

  //Colision de a con b
  if (b.x <= a.x && b.x + b.width >= a.x + a.width) {
    if (b.y <= a.y && b.y + b.height >= a.y + a.height) {
      hit = true;
    }
  }

  //Colision de b con a
  if (a.x <= b.x && a.x + a.width >= b.x + b.width) {
    if (a.y <= b.y && a.y + a.height >= b.y + b.height) {
      hit = true;
    }
  }

  return hit;
}
//Controlador
function controller() {
    if (tablero.playing) {
      vista.clean();
      vista.draw();
      vista.checkCollisions();
      vista.board.ball.move();
    }
  window.requestAnimationFrame(controller);
}

/** Variables **/
var cuadro = document.getElementById("tablero");
var altoTexto = document.getElementById("alto");
var anchoTexto = document.getElementById("ancho");
var comenzarBoton = document.getElementById("comenzar");
//Estado del juego
var tablero;
//Vista del tablero
var vista;
var barra1;
var barra2;
var pelota;

var direccion = [];
var teclas = {
  LEFT: 37,
  UP: 38,
  RIGHT: 39,
  DOWN: 40,
  W: 87,
  S: 83
};

/** Main **/
comenzarBoton.addEventListener('click', leerCanvas);
//Evento mover
document.addEventListener("keydown", mover);
//Evento detener
document.addEventListener("keyup", detener);
//

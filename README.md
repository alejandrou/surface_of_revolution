<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Tabla de contenidos</summary>
  <ol>
    <li>
      <a href="#Autor">Autor</a>
    </li>
    <li>
      <a href="#Trabajo realizado">Trabajo realizado</a>
    </li>
    <li><a href="#decisiones-adoptadas">Decisiones adoptadas</a></li>
    <li><a href="#referencias">Referencias</a></li>
    <li><a href="#herramientas">Herramientas</a></li>
    <li><a href="#resultado">Resultado</a></li>
  </ol>
</details>




## Autor

El autor de este proyecto es el estudiante Alejandro Daniel Herrera Cárdenes para la asignatura Creando Interfaces de Usuario (CIU) para el profesor Modesto Fernando Castrillón Santana. 


## Trabajo realizado

El trabajo se basa en hacer una superficie de revolucion  en el programa Processing.

## Decisiones adoptadas

Las mayores decisiones tomadas y las que mas pruebas requirieron fue ajustar el algoritmo de superficie para que se generara la rotación y al final generara la figura.

* El principal método que rota la figura dibujada con el ratón.
  ```
    void create_revolution_of_surface(){
  if(drawing){
      stroke(255);
      line(400, 0, 400, 800);
      stroke (255, 225, 0);    
      if(mousePressed){
        if (mouseX<400){
          drawing=false;
          y0=mouseY;
          points.add(new Coordinates(0, y0));
        }else if (firstPress == 1) {
          firstPress = 0;
          x0=mouseX;
          y0=mouseY;
          point(x0, y0);
          points.add(new Coordinates(x0-400, y0));
        }
        else {   
          x=mouseX;
          y=mouseY;
          point(x, y);
          line(x0, y0, x, y);
          x0=x;
          y0=y;
          points.add(new Coordinates(x0-400, y0));
        }
      }
    } else if(!figureCreate){
      
        figureCreate=true;
        
        obj=createShape();
        obj.beginShape(TRIANGLE_STRIP);
        obj.fill(100);
        obj.stroke (255,225,0) ;
        
        Coordinates b, a=points.get(0);
        
        for(int i=1; i<points.size();i++){
          b=points.get(i);
          mainAlgorithm(a.x, a.y, b.x, b.y, 100);
          a = b;
        }  
        obj.endShape();
      
    } else {
      background(0);
      translate (mouseX, mouseY-100);
      shape(obj);
    }
  }

* Este método detecta cuando las paletas hacen contacto con la pelota añadiendole un sonido.

  ```
    void contactPaddle() {
    if (x - w/2 < paddleXL + paddleW/2 && y - h/2 < paddleYL + paddleH/2 && y + h/2 > paddleYL - paddleH/2 ) {
      if (speedX < 0) {
        speedX = -speedX*1;
        sonido.play();
      }
    }
    else if (x + w/2 > paddleXR - paddleW/2 && y - h/2 < paddleYR + paddleH/2 && y + h/2 > paddleYR - paddleH/2 ) {
      if (speedX > 0) {
        speedX = -speedX*1;
        sonido.play();
      }
    }
  }
  ```
  
  
 * Este método detecta cuando la pelota golpea en el limite de la ventana reiniciandola y sumando un punto por el lado en el que la golpea.
    Las últimas dos condiciones lo que permite es que la pelota rebote en la parte superior e inferior de la ventana añadiendo así también un sonido.

    ```
    void bounceOff() {
     if ( x > width - w/2) {
        setup();
        speedX = -speedX;
        scoreL = scoreL + 1;
      } else if ( x < 0 + w/2) {
        setup();
        scoreR = scoreR + 1;
      }
      if ( y > height - h/2) {
        speedY = -speedY;
        sonido.play();
      } else if ( y < 0 + h/2) {
        speedY = -speedY;
        sonido.play();
      }
    }
   ```
* Este método en cuanto el scoreR o el scoreL llega a 10 finaliza el juego mostrando el color que ganó el juego.

    ```
    void gameOver() {
      if(scoreL == winScore) {
        gameOverPage("Red wins!", colorL);
      }
      if(scoreR == winScore) {
        gameOverPage("Green wins!", colorR);
      }
    }
   ```

 <p align="center"><img src="images/gameover.png" alt="gamePlay" width="300" height="300"></br>Pantalla final</p>
 


## Referencias

Para ayudarme en la realización de esta aplicación usé básicamente la API que te proporciona [Processing](https://www.processing.org/).

## Herramientas

* [Processing](https://www.processing.org/)




## Resultado

Añado un GIF con el resultado de la aplicación moviendose ambas paletas y rebotando la pelota en ellas.

  * Resultado
  <p align="center"><img src="images/pong.gif" alt="gamePlay" width="300" height="300"></br>Gif resultado final</p>

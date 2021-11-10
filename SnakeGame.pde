import java.util.LinkedList;
final int screenWidth = 600,
          screenHeight = 600;

int originX,
    originY;
int size;

int cols,
    rows;

int speed = 1;

int newX, newY;

// 2D Array of objects
Cell[][] grid;
Snake head;

LinkedList<Snake> body;

Cell moneda;
int puntos = 0;
PFont f;

void setup() 
{
    frameRate(10); //ideal framerate
    size(600, 600);
    size = 25;


    f  = createFont("Courier", 16,true); // Courier, 16 point, anti-aliasing on

    cols = screenWidth / size;
    rows = screenHeight / size;
    


    grid = new Cell[cols][rows];
    for (int i = 0; i < cols; i++) 
    {
        for (int j = 0; j < rows; j++) 
        {
        // Initialize each object
        grid[i][j] = new Cell(i*size,j*size,size);
        }
    }

    body = new LinkedList<Snake>();
    
    //head creation
    body.add(new Snake(cols * 0.5, rows * 0.25, size, speed));
    body.get(0).setLimits(cols, rows);
    body.get(0).directions[1] = true; 
    

    newCells(); 
    newCells(); 
    
    moneda = new Cell(random(cols), random(rows), size);  
} 
 
void draw()    
{ 
    if (body.get(0).speed != 0) 
    { //<>//
        background(0); //<>//

        newX = body.get(0).x; 
        newY = body.get(0).y; 

         //monedas //<>//
            fill(255,0,0);
            grid[(int)moneda.x][(int)moneda.y].display(); 
            grid[(int)moneda.x][(int)moneda.y].on = true;
            grid[(int)moneda.x][(int)moneda.y].coin = true;
            if ((int)moneda.x == body.get(0).x && (int)moneda.y == body.get(0).y)
            {
                comer();
            }

        body.get(0).moveHead(); 
        body.get(0).setLimits(cols, rows);  
        
        if (body.get(0).speed != 0)
        {
            if (grid[(int)body.get(0).x][(int)body.get(0).y].on == true && grid[(int)body.get(0).x][(int)body.get(0).y].coin == false)
            { 
                body.get(0).speed = 0;
            }


            fill(255);  //<>//
            grid[(int)body.get(0).x][(int)body.get(0).y].display();
            grid[(int)body.get(0).x][(int)body.get(0).y].on = true;
            

            // move and display the rest of the body
            for (int i = 1; i < body.size(); i++) 
            { 
                move(body.get(i),newX, newY);  
                
                grid[(int)body.get(i).x][(int)body.get(i).y].display();
                grid[(int)body.get(i).x][(int)body.get(i).y].on = true;  
            }
            
            //<>//

        } 
        
        // texto puntos
        fill(255, 0, 0);
        textFont(f, 25);
        textAlign(CENTER, CENTER);
        text("Puntaje: " + puntos, 0 + 80 , 0 + 30);
    } 
    else {
        grid[newX][newY].display();
        grid[newX][newY].on = true; 
        for (int i = 1; i < body.size(); i++) 
        {            
            grid[(int)body.get(i).x][(int)body.get(i).y].display();
            grid[(int)body.get(i).x][(int)body.get(i).y].on = true;  
        }
        
    }
} 

void comer(){
    //añadir puntos y celulas
    puntos += 1;
    newCells();
    grid[(int)moneda.x][(int)moneda.y].coin = false;

    //reestablecer posicion a un punto donde no este la serpiente  
    do { 
        moneda.x = (int)random(cols); 
        moneda.y = (int)random(rows); 
    } while (grid[(int)moneda.x][(int)moneda.y].on);
}

void newCells()
{
    int last = body.size() - 1; 
    int x = body.get(last).directions[3] ? body.get(last).x - 1 : (body.get(last).directions[2] ? body.get(last).x + 1 : body.get(last).x);
    int y = body.get(last).directions[1] ? body.get(last).y - 1 : (body.get(last).directions[0] ? body.get(last).y + 1 : body.get(last).y); //<>//
    body.add(new Snake(x, y , size, speed));  
}

void move(Snake s, int prevX, int prevY) 
{ 
    //Establecer nuevas coordenadas del bloque que viene
    newX = s.x;
    newY = s.y;

    //indicar que el bloque actual ya no esta usando la coordenada del grid
    grid[newX][newY].on = false;

    //tomando las coordenadas del anterior bloque y asigandolas a este
    s.x = prevX;
    s.y = prevY;


    // determinar en que direccion, se esta moviendo cada bloque
    if (s.x > newX) //va a la derecha
    {
        s.directions[3] = true;

        s.directions[0] = false;
        s.directions[1] = false;
        s.directions[2] = false;
    } 
    else if (newX > s.x) //va a la izquierda
    {
        s.directions[2] = true;

        s.directions[0] = false;
        s.directions[1] = false;
        s.directions[3] = false;
    }
    else if (s.y > newY) //va hacia abajo
    {
        s.directions[1] = true;

        s.directions[0] = false;
        s.directions[2] = false;
        s.directions[3] = false;
    } 
    else if (newY > s.y) //va hacia arriba
    {
        s.directions[0] = true;
        
        s.directions[1] = false;
        s.directions[2] = false;
        s.directions[3] = false;
    }
}

void keyPressed() {
  if (key == CODED) 
  { // special key
    if (keyCode == UP) 
    {
        if (!body.get(0).directions[1] == true)
        {
            body.get(0).directions[0] = true;

            body.get(0).directions[1] = false;
            body.get(0).directions[2] = false;
            body.get(0).directions[3] = false;
        }
    } 
    else if (keyCode == DOWN) 
    {
        if (!body.get(0).directions[0] == true){
            body.get(0).directions[1] = true;

            body.get(0).directions[0] = false;
            body.get(0).directions[2] = false;
            body.get(0).directions[3] = false;
        }
    } 
    else if (keyCode == LEFT) 
    {
       if (!body.get(0).directions[3] == true)
        {
            body.get(0).directions[2] = true;

            body.get(0).directions[0] = false;
            body.get(0).directions[1] = false;
            body.get(0).directions[3] = false;
        }
    } 
    else if (keyCode == RIGHT) 
    {
         if (!body.get(0).directions[2] == true)
        {
            body.get(0).directions[3] = true;

            body.get(0).directions[0] = false;
            body.get(0).directions[1] = false;
            body.get(0).directions[2] = false;
        }
    }
  }
}

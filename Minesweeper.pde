

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row = 0; row < 20; row++)
    {
        for(int col = 0; col < 20; col++)
        {
            buttons[row][col] = new MSButton(row,col);
        }
    }
    for(int i = 0; i <17; i++)   
        setBombs();
}
public void setBombs()
{
    //your code
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);

    if(!bombs.contains(buttons[r][c]))
            bombs.add(buttons[r][c]);
    
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r = 0; r<NUM_ROWS;r++)
    {
        for(int c = 0; c< NUM_COLS; c++)
        {
            if(bombs.contains(buttons[r][c]) && !buttons[r][c].isMarked())
            {
                return false;
            }
        }
    }
     return true;
}
public void displayLosingMessage()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(bombs.contains(buttons[r][c]))
            {
                buttons[r][c].setLabel("L");
            }
        }
    }
}
public void displayWinningMessage()
{
    //your code here
    buttons[10][7].setLabel("W");
    buttons[10][8].setLabel("I");
    buttons[10][9].setLabel("N");
    buttons[10][10].setLabel("N");
    buttons[10][11].setLabel("E");
    buttons[10][12].setLabel("R");
    buttons[10][13].setLabel("!");


    buttons[12][7].setLabel("W");
    buttons[12][8].setLabel("I");
    buttons[12][9].setLabel("N");
    buttons[12][10].setLabel("N");
    buttons[12][11].setLabel("E");
    buttons[12][12].setLabel("R");
    buttons[12][13].setLabel("!");

    buttons[14][7].setLabel("W");
    buttons[14][8].setLabel("I");
    buttons[14][9].setLabel("N");
    buttons[14][10].setLabel("N");
    buttons[14][11].setLabel("E");
    buttons[14][12].setLabel("R");
    buttons[14][13].setLabel("!");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(keyPressed == true || mousePressed && (mouseButton == RIGHT))
        {
            if(marked == false)
            {
                marked = true;
            }
            else if(marked == true)
            {
                clicked = false;
                marked = false;
            }
        }
            else if(bombs.contains(this))
            {
                displayLosingMessage();
            }
            else if(countBombs(r,c) > 0)
            {
                setLabel("" + countBombs(r,c));
            }
            else{

                if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
                    buttons[r+1][c].mousePressed();

                if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
                    buttons[r-1][c].mousePressed();

                if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
                    buttons[r][c+1].mousePressed();

                if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
                    buttons[r][c-1].mousePressed();

                if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
                    buttons[r+1][c+1].mousePressed();

                if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
                    buttons[r+1][c-1].mousePressed();

                if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
                    buttons[r-1][c-1].mousePressed();

                if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
                    buttons[r-1][c+1].mousePressed();
            }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>-1 && r<20 && c>-1 && c<20)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row+1,col) == true && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if(isValid(row-1,col) == true && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if(isValid(row,col+1) == true && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if(isValid(row,col-1) == true && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if(isValid(row+1,col+1) == true && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if(isValid(row+1,col-1) == true && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if(isValid(row-1,col+1) == true && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        if(isValid(row-1,col-1) == true && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        return numBombs;
    }
}




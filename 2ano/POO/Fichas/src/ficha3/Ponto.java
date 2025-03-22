package ficha3;

public class Ponto {
    // variaveis de instancia
    private int x;
    private int y; //SEMPRE EM PRIVATE

    /**
     * Construtores da classe Ponto.
     * Declaração dos construptores por omissao | parametros | copia
     */

    /**
     * Construtor por omissao
     */

    public Ponto() {
        this.x = 0;
        this.y = 0;
    }

    /**
     * Construtor por parametro
     */
    public Ponto(int x, int y) {
        this.x = x;
        this.y = y;
    }

    /**
     * Construtor por copia
     */

    public Ponto(Ponto p) {
        this.x = p.getX();
        this.y = p.getY();
    }

    /**
     * Metodos de instancia:
     */

    /**
     *
     * Devolve o valor da coordenada em x
     *
     * @return valor de x
     *
     */

    public int getX() {
        return this.x;
    }

    /**
     *
     * Devolve o valor da coordenada em y
     *
     * @return valor de y
     *
     */

    public int getY() {
        return this.y;
    }

    /**
     * atualiza o x
     * @param x nova coord
     */

    public void setX(int x) {
        this.x = x;
    }

    /**
     * atualiza o y
     * @param y nova coord
     */

    public void setY(int y) {
        this.y = y;
    }

    /**
     * desloca um ponto com x e y
     *
     * @param deltaX
     * @param deltaY
     */

    public void deslocamento(int deltaX, int deltaY) {
        this.x += deltaX;
        this.y += deltaY;
    }

    /**
     * soma de dois pontos
     * @param p
     */

    public void somaPonto(Ponto p) {
        this.x += p.getX();
        this.y += p.getY();
    }

    public void movePonto(int x, int y) {
        this.setX(x);
        this.setY(y);
    }

    public double distanciaPonto(Ponto p) {
        return Math.sqrt(Math.pow(this.x - p.getX(), 2) + Math.pow(this.y - p.getY(), 2));
    }

    public boolean equals(Object o) {
        if (this == o)
            return true;
        if ((o == null) || (this.getClass() != o.getClass()))
            return false;
        Ponto p = (Ponto) o; //cast atribuindo o object como ponto (Sendo agr p)
        return (this.x == p.getX()) && (this.y == p.getY());
    }

    public String toString() {
        return "(" + this.x + ", " + this.y + ")";
    }

    public Ponto clone() {
        return new Ponto(this);
    }

}


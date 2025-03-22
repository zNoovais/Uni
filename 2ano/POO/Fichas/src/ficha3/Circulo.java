package ficha3;

public class Circulo {
    private double x;
    private double y;
    private double raio;

    public Circulo() {
        this.x = 0;
        this.y = 0;
        this.raio = 0;
    }

    public Circulo(double x, double y, double raio) {
        this.x = x;
        this.y = y;
        this.raio = raio;
    }

    public Circulo(Circulo c) {
        this.x = c.getX();
        this.y = c.getY();
        this.raio = c.getRaio();
    }

    /**
     *
     * Metodos que devolvem algo sobre o circulo
     */

    public double getX() {
        return this.x;
    }
    public double getY() {
        return this.y;
    }
    public double getRaio() {
        return this.raio;
    }

    public double getArea() {
        return (this.raio * this.raio * Math.PI);
    }

    public double getPerimetro() {
        return (2 * Math.PI * this.raio);
    }

    public void setPosition(double x, double y) {
        this.setX(x);
        this.setY(y);
    }


    public void setX(double x) {
        this.x = x;
    }

    public void setY(double y) {
        this.y = y;
    }

    public void setRaio(double raio) {
        this.raio = raio;
    }



    /**
     *
     * METODOS BASICOS E OBRIGATORIOS:
     *
     */

    public String toString() {
        return "(" + this.x + ", " + this.y + ") " + this.raio;
    }

    public boolean equals(Object o) {
        if(o == null || o.getClass() != o.getClass())
            return false;
        if (o == this)
            return true;
        Circulo c = (Circulo) o;
        return (this.x == c.getX()) && (this.y == c.getY()) && (this.raio == c.getRaio());
    }

    public Circulo clone() {
        return new Circulo(this);
    }


}

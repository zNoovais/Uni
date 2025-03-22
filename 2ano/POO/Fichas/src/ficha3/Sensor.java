package ficha3;

public class Sensor {
    private double valor;

    public Sensor() {
        this.valor = 0;
    }

    public Sensor(double valor) {
        if (valor < 0)
            this.valor = 0;
        this.valor = this.valor;
    }

    public boolean setPressao(double valor) {
        boolean out = valor >= 0;
        if (out)
            this.valor = valor;
        return out;
    }

    public double getPressao() {
        return this.valor;
    }

    /**
     * metodos obrigatorios:
     */

    public Sensor clone(){
        return new Sensor(this.valor);
    }

    public boolean equals(Object o) {
        if (o == null || o.getClass() != this.getClass())
            return false;
        if (o == this)
            return true;
        Sensor s = (Sensor) o;
        return this.getPressao() == s.getPressao();
    }

    public String toString() {
        return "(" + this.getPressao() + "pascal)";
    }

}

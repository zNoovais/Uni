package ficha4;

public class Lampada {

    //variaveis de instancia

    public enum Modo {
        ON,
        OFF,
        ECO
    }

    private Modo modo;

    private String descricao;

    private int consumo;

    // metodos de criação

    public Lampada() {
        this.modo = Modo.OFF;
        this.descricao = "lampada";
        this.consumo = 1;
    }

    public Lampada(Modo modo, String descricao, int consumo) {
        this.modo = modo;
        this.descricao = descricao;
        this.consumo = consumo;
    }

    public Lampada(Lampada l) {
        this.modo = l.modo;
        this.descricao = l.descricao;
        this.consumo = l.consumo;
    }

    // metodos get/set

    public void setModo(Modo modo) {
        this.modo = modo;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public void setConsumo(int consumo) {
        this.consumo = consumo;
    }

    // metodos obrigatorios

    public Lampada clone(Lampada l) {
        return new Lampada(this);
    }

    public Modo getModo() {}








}

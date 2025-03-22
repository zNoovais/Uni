package ficha3;

public class Futebol {

    private Boolean estado;
    private int golosCasa;
    private int golosFora;
    private int[] ultimoJogo = new int[2];

    public Futebol() {
        estado = false;
    }

    public int getGolosCasa() {
        return golosCasa;
    }

    public int getGolosFora() {
        return golosFora;
    }

    public void startGame() {
        if (!estado) {
            estado = true;
            golosCasa = 0;
            golosFora = 0;
        }
    }

    public void endGame() {
        if (estado) {
            estado = false;
            ultimoJogo[0] = golosCasa;
            ultimoJogo[1] = golosFora;
        }

    }

    public void golodaCasa() {
        if (estado) {
            golosCasa++;
        }
    }
    public void golodaFora() {
        if (estado) {
            golosFora++;
        }
    }

    public String resultadoAtual() {

        String str;
        int resultadoCasa;
        int resultadoFora;

        if (estado) {
            str = "Decorrendo!";
            resultadoCasa = golosCasa;
            resultadoFora = golosFora;

        }
        else {
            str = "Acabou";
            resultadoCasa = ultimoJogo[0];
            resultadoFora = ultimoJogo[1];
        }

        return golosCasa + "/" + golosFora + " :: " + str ;
    }

    public String toString() {
        return "(" + this.golosCasa + ", " + this.golosFora + ", " + this.estado + ", " + this.ultimoJogo[0] + ", " + this.ultimoJogo[1] + ")";
    }







}

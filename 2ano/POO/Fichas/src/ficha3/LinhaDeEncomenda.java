package ficha3;

public class LinhaDeEncomenda {

    /**
     * variaveis de instancia:
     */

    private String referencia;
    private String descricao;
    private double preco;
    private int quantidade;
    private double imposto;
    private double desconto;

    // metodos de criacao

    public LinhaDeEncomenda() {
        this.referencia = "referencia";
        this.descricao = "descricao";
        this.preco = 0;
        this.quantidade = 0;
        this.imposto = 0;
        this.desconto = 0;
    }

    public LinhaDeEncomenda(String referencia, String descricao, double preco,
                            int quantidade, double imposto, double desconto) {
        this.referencia = referencia;
        this.descricao = descricao;
        this.preco = preco;
        this.quantidade = quantidade;
        this.imposto = imposto;
        this.desconto = desconto;
    }

    public LinhaDeEncomenda(LinhaDeEncomenda linha) {

        this.referencia = linha.referencia;
        this.descricao = linha.descricao;
        this.preco = linha.preco;
        this.quantidade = linha.quantidade;
        this.imposto = linha.imposto;
        this.desconto = linha.desconto;

    }



    // metodos de acesso e alteração seca seca seca seca seca

    public String getReferencia() {
        String referenciaOut = this.referencia;
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public String getDescricao() {
        String descricaoOut = this.descricao;
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public double getPreco() {
        return preco;
    }

    public void setPreco(double preco) {
        this.preco = preco;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public double getImposto() {
        return imposto;
    }

    public void setImposto(double imposto) {
        this.imposto = imposto;
    }

    public double getDesconto() {
        return desconto;
    }

    public void setDesconto(double desconto) {
        this.desconto = desconto;
    }

    // metodos base

    public double calculaValorLinhaEnc() {
        return (this.getPreco() + this.getImposto()*this.getPreco()/100)*
                (1-this.getDesconto()/100);
    }

    public double calculaValorDesconto() {
        return ((this.getPreco() + this.getImposto()*this.getPreco()/100)-
                this.calculaValorLinhaEnc());
    }

    //metodos obrigatorios

    public boolean equals(Object o) {

        if(o == null || o.getClass() != this.getClass())
            return false;
        if (o == this) {
            System.out.println("alooo");
            return true;
        }

        LinhaDeEncomenda l = (LinhaDeEncomenda) o;

        return this.getReferencia().equals(l.getReferencia()) &&
                this.getDescricao().equals(getDescricao()) &&
                this.getPreco() == l.getPreco() &&
                this.getQuantidade() == l.getQuantidade() &&
                this.getImposto() == l.getImposto() &&
                this.getDesconto() == l.getDesconto();
    }

    public LinhaDeEncomenda clone() {
        return new LinhaDeEncomenda(this);
    }

    public String toString() {
        return "(" + this.referencia + ", " + this.descricao + "," + this.preco + ","
                + this.quantidade + "," + this.imposto + "," + this.desconto + ")";
    }

}

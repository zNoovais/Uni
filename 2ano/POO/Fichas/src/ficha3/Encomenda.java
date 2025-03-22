package ficha3;

import java.time.LocalDate;
import java.util.Arrays;

public class Encomenda {

    // variaveis de instancia

    private String cliente;
    private int numeroFiscal;
    private String morada;
    private int numeroEncomenda;
    private LocalDate dataEncomenda;
    private LinhaDeEncomenda[] linhasDeEncomendas;
    private int tamanho;

    // metodos construtores

    public Encomenda() {
        cliente = "anon";
        numeroFiscal = 000;
        morada = "morada";
        numeroEncomenda = 000;
        dataEncomenda = LocalDate.now();
        linhasDeEncomendas = new LinhaDeEncomenda[10];
        tamanho = 0;
    }

    public Encomenda(Encomenda encomenda) {

        this.cliente = encomenda.cliente;
        this.numeroFiscal = encomenda.numeroFiscal;
        this.morada = encomenda.morada;
        this.numeroEncomenda = encomenda.numeroEncomenda;
        this.dataEncomenda = encomenda.dataEncomenda;
        this.linhasDeEncomendas = encomenda.getLinhasDeEncomendas();
        this.tamanho = encomenda.tamanho;
    }

    // metodos de acesso ou de alteração

    public String getCliente() {
        return this.cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }

    public int getNumeroFiscal() {
        return this.numeroFiscal;
    }

    public void setNumeroFiscal(int numeroFiscal) {
        this.numeroFiscal = numeroFiscal;
    }

    public String getMorada() {
        return this.morada;
    }

    public void setMorada(String morada) {
        this.morada = morada;
    }

    public int getNumeroEncomenda() {
        return this.numeroEncomenda;
    }

    public void setNumeroEncomenda(int numeroEncomenda) {
        this.numeroEncomenda = numeroEncomenda;
    }

    public LocalDate getDataEncomenda() {
        return this.dataEncomenda;
    }

    public void setDataEncomenda(LocalDate dataEncomenda) {
        this.dataEncomenda = dataEncomenda;
    }

    public LinhaDeEncomenda[] getLinhasDeEncomendas() {
        LinhaDeEncomenda [] linhasDeEncomendasOut = new LinhaDeEncomenda[10];
        System.arraycopy(linhasDeEncomendas, 0, linhasDeEncomendasOut, 0, tamanho);
        return linhasDeEncomendasOut;
    }

    public int getTamanho() {
        return this.tamanho;
    }

    public void setTamanho(int tamanho) {
        this.tamanho = tamanho;
    }

    //metodos obrigatorios

    public Encomenda clone() {
        return new Encomenda(this);
    }

    public boolean equals(Object o) {
        if(o == null || o.getClass() != this.getClass())
            return false;
        if (o == this)
            return true;

        Encomenda enco = (Encomenda) o;

        if (this.tamanho == enco.tamanho) {
            boolean out = true;
            LinhaDeEncomenda[] array = enco.getLinhasDeEncomendas();
            for(int i = 0; i < this.tamanho && out; i++) {
                if (!this.linhasDeEncomendas[i].equals(array[i])) {
                    out = false;
                }
            }
        }



        return  this.cliente.equals(enco.cliente) &&
                this.numeroFiscal == enco.numeroFiscal &&
                this.morada.equals(enco.morada) &&
                this.numeroEncomenda == enco.numeroEncomenda &&
                this.dataEncomenda.equals(enco.dataEncomenda) &&
                Arrays.deepEquals(this.linhasDeEncomendas,enco.getLinhasDeEncomendas());
    }

}






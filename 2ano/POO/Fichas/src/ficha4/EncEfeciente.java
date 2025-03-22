package ficha4;

import ficha3.LinhaDeEncomenda;
import ficha3.Ponto;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class EncEfeciente {

    // variaveis

    private List<LinhaDeEncomenda> listaEncomenda;
    private String nome;
    private int numeroFiscal;
    private String morada;
    private int Day;

    // metodos criaçao

    public EncEfeciente() {
        this.listaEncomenda = new ArrayList<>();
        this.nome = "Java";
        this.numeroFiscal = 1000;
        this.morada = "rua";
    }

    public EncEfeciente(String nome, int numeroFiscal, String morada,
                        int Day, ArrayList<LinhaDeEncomenda> listaEncomendaIn) {

        this.listaEncomenda = new ArrayList<>();
        this.nome = nome;
        this.numeroFiscal = numeroFiscal;
        this.morada = morada;
        this.Day = Day;
        this.listaEncomenda = listaEncomendaIn.stream().
                map(LinhaDeEncomenda::clone).collect(Collectors.toList());

    }

    public EncEfeciente( EncEfeciente e) {

        this.listaEncomenda = new ArrayList<>();
        this.nome = e.getNome();
        this.numeroFiscal = e.getNumeroFiscal();
        this.morada = e.getMorada();
        this.Day = e.getDay();
        this.listaEncomenda = e.getListaEncomenda().stream().map(LinhaDeEncomenda::clone).
                collect(Collectors.toList());
    }



    // set/get

    public void setNome(String nome){
        this.nome = nome;
    }
    public String getNome(){
        return this.nome;
    }

    public void setNumeroFiscal(int numeroFiscal){
        this.numeroFiscal = numeroFiscal;
    }
    public int getNumeroFiscal(){
        return this.numeroFiscal;
    }

    public void setMorada(String morada){
        this.morada = morada;
    }
    public String getMorada(){
        return this.morada;
    }

    public void setDay(int Day){
        this.Day = Day;
    }
    public int getDay(){
        return this.Day;
    }

    public List<LinhaDeEncomenda> getListaEncomenda() {
        List<LinhaDeEncomenda> out = new ArrayList<>();
        out = this.listaEncomenda.stream().map(LinhaDeEncomenda::clone).
                collect(Collectors.toList());
        return out;
    }

    public void setListaEncomenda(List<LinhaDeEncomenda> listaEncomendaIn) {
        this.listaEncomenda = this.listaEncomenda.stream().map(LinhaDeEncomenda::clone).
                collect(Collectors.toList());
    }

    // metodos obrigatorios

    public EncEfeciente clone() {
        return new EncEfeciente(this);
    }

    public boolean equals(Object o) {
        if (this == o)
            return true;
        if ((o == null) || (this.getClass() != o.getClass()))
            return false;
        EncEfeciente e = (EncEfeciente) o;
        return this.getNumeroFiscal() == e.getNumeroFiscal() &&
                this.getMorada().equals(e.getMorada()) &&
                this.getDay() == e.getDay() &&
                this.getNome().equals(e.getNome()) &&
                this.getListaEncomenda().equals(e.getListaEncomenda());

    }
    // metodos

    public double calculaValorTotal() {
        return this.listaEncomenda.stream().
                mapToDouble(LinhaDeEncomenda::getPreco).sum();
    }

}

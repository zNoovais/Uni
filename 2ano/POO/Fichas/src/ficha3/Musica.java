package ficha3;

public class Musica {

    private String nome;
    private String interprete;
    private String autor;
    private String editora;
    private String[] letra;
    private String[] musica;
    private float duracao;
    private int views;

    public Musica(String nome,String interprete, String autor, String
            editora, String[] letra, String[] musica, float duracao, int views) {
        this.nome = nome;
        this.interprete = interprete;
        this.autor = autor;
        this.editora = editora;
        this.duracao = duracao;
        this.views = views;
        this.letra = letra.clone();
        this.musica = musica.clone();
    }

    public int qtsLinhasLetra(){
        return this.letra.length;
    }

    public int numeroCaracteres(){
        int out = 0;
        for(int i = 0; i < letra.length; i++) {
            out += letra[i].length();
        }
        return out;
    }

    public void addLetra(int posicao, String novaLinha) {

       String[] novaLinhas = new String[this.letra.length + 1];

        System.arraycopy(this.letra,0,novaLinhas,0,posicao);
        novaLinhas[posicao]=novaLinha;
        System.arraycopy(this.musica,posicao,novaLinhas,posicao + 1,novaLinhas.length);
    }



}

package ficha3;

public class Programa {
    public static void main(String[] args) {

        LinhaDeEncomenda l = new LinhaDeEncomenda();
        LinhaDeEncomenda l1 = l.clone();

        System.out.println(l.equals(l));
        System.out.println(l.toString());



    }
}

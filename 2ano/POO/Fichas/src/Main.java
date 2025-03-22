import java.util.Scanner;


public class Main {
    public static void main(String[] args){
        Ficha2 ficha2 = new Ficha2();



        int[] array = {1,2,3,-42,5,6};

        int menor = ficha2.minimo(array);

        int[] meio = ficha2.meio(array, 1, 3);

        for(int i = 0; i < meio.length; i++){
            System.out.print(meio[i] + " ");
        }


    }

}

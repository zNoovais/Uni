package ficha2;


import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Scanner;

public class Programa {


    public static void main(String[] args){

        Scanner sc = new Scanner(System.in);

        boolean flagProgram = true;

        int opcao_programa = sc.nextInt();

        if (opcao_programa != 0){

            int[] array = {};



            funcArrays func = new funcArrays(array);

            while(flagProgram) {
                System.out.print("Digite o tamanho, Hostia: ");
                int tam = sc.nextInt();
                array = new int[tam];
                for (int i = 0; i < tam; i++) {
                    System.out.print("Posiçao " + i + ": ");
                    array[i] = sc.nextInt();
                }

                func.setArray(array);

                System.out.println(Arrays.toString(array));

                System.out.println("(0: Exit; 1: Continue)");
                int opcao = sc.nextInt();
                if (opcao == 0) {
                    flagProgram = false;
                }

            }

        }

        else{
            FuncDatas datas = new FuncDatas();
            LocalDate data = LocalDate.of(2025, 2,24);
            datas.insereData(data);
            data = LocalDate.of(2025, 2,25);
            datas.insereData(data);
            data = LocalDate.of(2025, 2,26);
            datas.insereData(data);

            LocalDate[] datas_out = new LocalDate[20];

            datas.getDatas(datas_out);

            for(int i = 0; i < datas_out.length && datas_out[i] != null; i++) {
                System.out.print(datas_out[i] + "|");
            }
            System.out.println();
        }

        System.out.println("acabou o programa");
        sc.close();
    }
}

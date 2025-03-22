
public class Ficha2 {

    private int[] myArray;
    






    /**
     * ve o menor numero de um array
     * @param array
     * @return retorna o numero muito zika
     */

    public int minimo(int[] array){
        int minimo = array[0];
        for(int i = 1; i < array.length; i++){
            if(array[i] < minimo){
                minimo = array[i];
            }
        }
        return minimo;
    }
    
    public int[] meio(int array[],int inicio,int fim){

        int tam = fim - inicio+1;
        int[] out;
        out = new int[tam];
        for(int i = 0; i+inicio <= fim; i++){
            out[i] = array[i+inicio];
        }

        return out;
    }
    


}

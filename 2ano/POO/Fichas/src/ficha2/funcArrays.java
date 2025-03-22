package ficha2;

import java.util.Arrays;
import java.util.Set;
import java.util.HashSet;

public class funcArrays {
    int[] myArray;

    public funcArrays(int[] arrayIn){
        int tam = arrayIn.length;
        myArray = new int[tam];
        for(int i = 0; i < tam; i++) {
            myArray[i] = arrayIn[i];
        }
    }

    /**
     * altera a instancia do objeto array B)
     *
     * @param arrayIn
     *
     */

    public void setArray(int[] arrayIn){
        int tam = arrayIn.length;
        myArray = new int[tam];
        for(int i = 0; i < tam; i++) {
            myArray[i] = arrayIn[i];
        }
    }

    public int minimum(){
        int min = myArray[0];
        for(int i = 1; i < myArray.length; i++){
            if(myArray[i] < min){
                min = myArray[i];
            }
        }
        return min;
    }

    public int[] entre(int prim, int seg){
        return Arrays.copyOfRange(myArray,prim,seg);
    }

    public int[] comuns(int[] arrayIn){

        Set<Integer> numeros1 = new java.util.HashSet<>();
        Set<Integer> numeros2 = new java.util.HashSet<>();
        for(int i = 0; i < myArray.length; i++){
            numeros1.add(myArray[i]);
        }
        for(int i = 0; i < arrayIn.length; i++){
            numeros2.add(arrayIn[i]);
        }
        numeros1.retainAll(numeros2);

        Object[] array = numeros1.toArray();
        int[] out = new int[array.length];
        for(int i = 0; i < array.length; i++){
            out[i] = (int)array[i];
        }
        return out;
    }



}



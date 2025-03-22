package ficha2;

import java.time.LocalDate;

public class FuncDatas {

    LocalDate[] datas = new LocalDate[20];
    int aponta_datas = 0;
    int ocupacao = 0;

    public void insereData(LocalDate data){
        if (aponta_datas == datas.length){
            this.aponta_datas = 0;
        }
        if (ocupacao != datas.length){
            this.ocupacao++;
        }
        this.datas[aponta_datas] = data;
        this.aponta_datas++;
    }

    public LocalDate[] getDatas(LocalDate[] datasIn){
        for(int i = 0; i <= this.ocupacao; i++){
            datasIn[i] = this.datas[i];
        }
        return datasIn;
    }

    public LocalDate dataMaisProxima(LocalDate data){
        LocalDate dataMaisProxima = datas[0];
        int diferenca = dataMaisProxima.compareTo(data);

        for(int i = 1; i < ocupacao; i++){
            if (datas[i].compareTo(data) < diferenca){
                diferenca = datas[i].compareTo(data);
                dataMaisProxima = datas[i];
            }
        }

        return dataMaisProxima;

        }



    }






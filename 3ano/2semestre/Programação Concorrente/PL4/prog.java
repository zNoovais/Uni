package PL4;

class Barrier {
    private final int N;
    private int temp;
    private boolean fechada;
    Barrier (int N) { 
        this.N = N;
        this.fechada = true;
        temp = 0;
    }
    public synchronized void await() throws InterruptedException { 
        if(!fechada && temp == N) {
            temp = 0;
            fechada = true;
        }

        temp += 1;
        
        if ( N == temp) {
            notifyAll();
            fechada = false;
        }
        else
            while(fechada) {
                wait();
            }

    }
}
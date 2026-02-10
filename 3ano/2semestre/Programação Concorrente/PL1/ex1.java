class Printer extends Thread {
    final int I;
    
    Counter counter;


    Printer(int I, Counter counter) {
        this.I = I;
        this.counter = counter;
    }

    public void run() {
        counter.Increment();
    }


}

class Counter {
    int counter;
    Counter() {
        counter = 0;
    }

    public void setCounter(int counter) {
        this.counter = counter;
    }

    public int getCounter() {
        return counter;
    }

    public void Increment() {
        counter++;
    }


}

public class ex1 {
    public static void main(String[] args) throws InterruptedException{
        final int N = Integer.parseInt(args[0]);
        final int I = Integer.parseInt(args[0]);

        
        Printer[] a = new Printer[N];

        Counter counter = new Counter();

        for(int i = 0; i < N; i++) {
         a[i] = new Printer(i,counter);
        }
        for(int i = 0; i < N; i++) {
         a[i].start();
        }
        for(int i = 0; i < N; i++) {
         a[i].join();
        }
        System.out.println(counter.counter);
        
    }
    
}

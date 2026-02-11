import java.util.ArrayList;

class Printer extends Thread {
    final int tag;
    
    Counter counter;


    Printer(int I, Counter counter) {
        this.tag = I;
        this.counter = counter;
    }

    public void run() {
            try {
            Thread.sleep((int)(Math.random()*10));
        } catch (InterruptedException e) {}
        counter.Increment(tag);
    }


}

class Counter {
    int counter;

    ArrayList<Integer> countList;

    Counter() {
        counter = 0;
        countList = new ArrayList<>();
    }

    public void setCounter(int counter) {
        this.counter = counter;
    }

    public int getCounter() {
        return counter;
    }

    public void Increment(int tag) {
        counter++;
        countList.add(tag);
    }

    // public void printCountList() {
    //     print(t)
    // }


}

public class ex1 {
    public static void main(String[] args) throws InterruptedException{
        final int N = Integer.parseInt(args[0]);


        
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
        System.out.println(counter.countList);
        
    }
    
}

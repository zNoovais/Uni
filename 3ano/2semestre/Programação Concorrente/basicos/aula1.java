package basicos;
class MyThread extends Thread {
    public void run() {
        //for (long l = 0; l < 1L << 32; l++);
        try {
            Thread.sleep(2000);
        } catch (InterruptedException ignored) {}
        System.out.println("oi");

    }
}


class MyRunnable implements Runnable {
    public void run() {
        for (long l = 0; l < 1L << 32; l++);
        System.out.println("oi");
    }
}

class aula1 {
    public static void main(String[] args) throws InterruptedException{
        MyThread t = new MyThread();
        // t.run() isto é burrice pois nunca invocamos assim.... (nao é concorrente)

        t.start();
        //for (long l = 0; l < 1L << 32; l++);
        System.out.println("EU SOU A MAIN");

        MyRunnable r = new MyRunnable(); // igual ao fazer o myThread...
        Thread t2 = new Thread(r);

        Thread t3 = new Thread(new MyRunnable());

        t.join();
        t2.join();
        t3.join();

        

    }


}
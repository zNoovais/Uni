import java.util.*;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

class Resources implements Controller {

    int T;


    Resources(int T) {
        this.T = T;
    }

    Lock l = new ReentrantLock();
    Condition[] cond = {l.newCondition(),l.newCondition()};

    int[] access = new int[2];

    int[] waiting = new int[2];

    int[] permissions  = new int[2];



    public void request_resource(int i) throws InterruptedException {
        l.lock();
        try {
            waiting[i]++;
            while(access[i] >= T  || access[1-i] > 0 || (permissions[i] == 0 && waiting[1-i] > 0)) {
                cond[i].await();
            }
            waiting[i]--;
            access[i] += 1;
            if (permissions[i] > 0) {
                permissions[i]--;
            }
        } finally {
            l.unlock();
        }
    }

    public void release_resource(int i) {
        l.lock();
        try {
            access[i] -= 1;
            cond[i].signal();
            if (access[i] == 0) {
                permissions[1-i] = waiting[1-i];
                cond[1-i].signalAll();
            }


        } finally {
            l.unlock();
        }

    }



}



interface Controller {
    void request_resource(int i) throws InterruptedException;
    void release_resource(int i);
}





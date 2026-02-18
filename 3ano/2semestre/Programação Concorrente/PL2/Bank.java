package PL2;

public class Bank {

    private static class Account {
        private int balance;
        Account(int balance) { this.balance = balance; }
        synchronized int balance() { return balance; }
        synchronized boolean deposit(int value) {
            balance += value;
            return true;
        }
        synchronized boolean withdraw(int value) {
            if (value > balance)
                return false;
            balance -= value;
            return true;
        }
    }

    // Bank slots and vector of accounts
    private int slots;
    private Account[] av; 

    public Bank(int n) {
        slots=n;
        av=new Account[slots];
        for (int i=0; i<slots; i++) av[i]=new Account(0);
    }

    // Account balance
    public synchronized int balance(int id) {
        if (id < 0 || id >= slots)
            return 0;
        return av[id].balance();
    }

    // Deposit
    public synchronized boolean deposit(int id, int value) {
        if (id < 0 || id >= slots)
            return false;
        return av[id].deposit(value);
    }

    // Withdraw; fails if no such account or insufficient balance
    public synchronized boolean withdraw(int id, int value) {
        if (id < 0 || id >= slots)
            return false;
        return av[id].withdraw(value);
    }

    public synchronized int totalBalance() {
        int sum = 0;

        for (Account i : this.av) {
            sum += i.balance();
        }

        return sum;

    }

    public boolean transfer(int from, int to, int b) {
        if (from < 0 || from >= slots || to < 0 || to >= slots) {
            return false;
        }

        Account cfrom = av[from];
        Account cto = av[to];

        Account first,second;

        if (from < to) {
            first = cfrom;
            second = cto;
        }
        else {
            first = cto;
            second = cfrom;
        }

        synchronized (first) {
            synchronized (second) {
                if(!cfrom.withdraw(b))
                    return false;
                return cto.deposit(b);
            }
        }
        

    }


}

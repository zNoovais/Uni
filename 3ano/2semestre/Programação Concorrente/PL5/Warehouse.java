import java.util.*;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

// nosso warehouse vai ter um reentrant lock
// uma condition por produto

class Warehouse {
    private Map<String, Product> map =  new HashMap<String, Product>();

    private class Product { 
        int quantity = 0; 
        Condition vazio = lock.newCondition();
    }

    private ReentrantLock lock = new ReentrantLock();


    private Product get(String item) {
        Product p = map.get(item);
        if (p != null) return p;
        p = new Product();
        map.put(item, p);
        return p;
    }

    public void supply(String item, int quantity) throws InterruptedException {
        lock.lock(); 
        try {
            Product p = get(item);
            p.quantity += quantity;
            p.vazio.signalAll();
        } finally {
            lock.unlock();    
        }
    }

    // Errado se faltar algum produto...
    public void consume(Set<String> items)  throws InterruptedException {

        lock.lock();

        try {
            Product[] prods = new Product[items.size()];
            int i = 0;

            // retirando os produtos todos 
            for (String s : items)
                prods[i++] = get(s);
        
            // verificação dos produtos no armazem se der porcaria eu dou a volta
            boolean deuasneira = false;

            do {
                deuasneira = false;
                for(int j = 0; j < prods.length; j++) {
                   if (prods[j].quantity == 0) {
                    deuasneira = true;
                    prods[j].vazio.await();
                   }
                }
            } while (deuasneira);


            // retiro os produtos 
            for(Product p : prods)
                p.quantity--;

        } finally {
            lock.unlock();
        }
            
            
    }

}

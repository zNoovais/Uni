import java.util.LinkedList;
import java.util.Queue;

class Postman implements Runnable {

  private ComunicacaoTCP network;

  private Queue<String> messages = new LinkedList<>();

  private boolean running = true;

  public Postman(ComunicacaoTCP network) {
    this.network = network;
  }

  // interface
  public void send(String message) {
    synchronized (this) {
      messages.add(message);
      notify(); // pode ser notifyAll por segurança mas só temos ums thread
    }
  }

  // interface
  public void stop() {
    synchronized (this) {
      running = false;
      notify(); // pode ser notifyAll por segurança mas só temos ums thread
    }
  }

  @Override
  public void run() {
    while (true) {
      String message;

      synchronized (this) {
        while (running && messages.isEmpty()) {
          try {
            wait();
          } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            running = false;
          }
        }

        // teve de ser para n dar erro no messages.remove
        if (!running && messages.isEmpty()) {
          return;
        }

        message = messages.remove();
      }

      network.send(message);
    }
  }
}

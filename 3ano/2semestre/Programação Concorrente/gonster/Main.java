import processing.core.PApplet;

final class Main {
    public static void main(String[] args) {
        String username = args.length >= 1 ? args[0] : "";
        String password = args.length >= 2 ? args[1] : "";
        boolean autoJoin = args.length >= 3 && args[2].equals("--join");

        EstadoJogo data = new EstadoJogo();
        ComunicacaoTCP tcp = new ComunicacaoTCP(data);

        if (!tcp.connect("127.0.0.1", 9000)) {
            System.exit(1);
        }

        Postman postman = new Postman(tcp);
        Cliente janela = new Cliente(data, postman, tcp);

        new Thread(() -> PApplet.runSketch(new String[] { "Cliente" }, janela), "janela").start();

        new Thread(postman, "postman").start();
        new Thread(new RunnableRede(tcp), "server-listener").start();

        if (autoJoin) {
            startAutoJoin(data, postman, username, password);
        }
    }


    // testes
    private static void startAutoJoin(EstadoJogo data, Postman postman, String username, String password) {
        if (username.isEmpty() || password.isEmpty()) {
            System.err.println("Uso: java -cp \".:lib/core.jar\" Main <username> <password> --join");
            return;
        }

        synchronized (data) {
            data.username = username;
            data.password = password;
            data.state = EstadoJogo.LOGIN;
        }

        new Thread(() -> {
            sleep(400);
            postman.send("create_account " + username + " " + password);
            sleep(300);
            postman.send("login " + username + " " + password);
            sleep(300);
            postman.send("join " + username);
        }, "auto-join").start();
    }

    private static void sleep(long millis) {
        try {
            Thread.sleep(millis);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}

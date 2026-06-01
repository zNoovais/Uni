class RunnableRede implements Runnable {

  private ComunicacaoTCP network;

  public RunnableRede(ComunicacaoTCP network) {
    this.network = network;
  }

  @Override
  public void run() {
    network.listen();
  }
}

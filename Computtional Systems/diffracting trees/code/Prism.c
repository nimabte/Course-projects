public class Prism {
private static final int duration = 100;
Exchanger<Integer>[] exchanger;
Random random;
public Prism(int capacity) {
exchanger = (Exchanger<Integer>[]) new Exchanger[capacity];
for (int i = 0; i < capacity; i++) {
exchanger[i] = new Exchanger<Integer>();
}
 random = new Random();
 }
 public boolean visit() throws TimeoutException, InterruptedException {
 int me = ThreadID.get();
 int slot = random.nextInt(exchanger.length);
 int other = exchanger[slot].exchange(me, duration, TimeUnit.MILLISECONDS);
 return (me < other);
 }
}
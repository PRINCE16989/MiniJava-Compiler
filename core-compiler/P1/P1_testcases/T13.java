import java.util.function.Function;

class T13{
public static void main (String[] args) {
System.out.println(new test13().A(5));
}
}

class test13{
public int A(int x) {
Function <Integer, Integer>  inc;

inc = ((y)->y + 1);

return inc.apply(x);
}
}

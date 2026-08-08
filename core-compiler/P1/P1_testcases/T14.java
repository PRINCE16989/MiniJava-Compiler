import java.util.function.Function;

class T14{
public static void main (String[] args) {
System.out.println(new test14().A());
}
}

class foo14{
public int Double(int x) {


return 2 * x;
}
}
class test14{
public int A() {
foo14 B;
Function <foo14, Integer>  f;

B = new foo14();
f = ((y)->y.Double((7)));

return f.apply(B);
}
}

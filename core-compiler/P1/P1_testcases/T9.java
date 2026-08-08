
class T9{
public static void main (String[] args) {
System.out.println(new test9().sw());
}
}

class test9{
public int sw() {
int x;
int y;
int t;

x = 5;
y = 10;
t = x;
x = y;
y = t;
System.out.println(x);
System.out.println(y);

return x;
}
}

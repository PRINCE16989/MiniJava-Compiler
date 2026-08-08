
class T10{
public static void main (String[] args) {
System.out.println(new test10().foo(9,5));
}
}

class test10{
public int foo(int x,int y) {

while ((x != y)) {
System.out.println(x);
x = x - 1;
y = y + 1;
}

return x + y;
}
}

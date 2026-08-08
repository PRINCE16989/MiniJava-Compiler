
class T5{
public static void main (String[] args) {
System.out.println(new test5().foo(10,2));
}
}

class test5{
public int foo(int x,int y) {

while ((!((x) <= (y)))) {
System.out.println(x + y);
x = x - 1;
y = y + 1;
}

return x + y;
}
}

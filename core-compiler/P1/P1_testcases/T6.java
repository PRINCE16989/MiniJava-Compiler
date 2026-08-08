
class T6{
public static void main (String[] args) {
System.out.println(new test6().foo());
}
}

class test6{
public int foo() {
int x;
int y;
int z;

x = 10;
y = 2;
z = 4;
while (((!((x) <= (y)))) && (((y) <= (z)))) {
System.out.println(x + y);
x = x - 1;
y = y + 1;
}

return x + (y + z);
}
}

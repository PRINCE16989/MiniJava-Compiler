
class T8{
public static void main (String[] args) {
System.out.println(new test8().wh());
}
}

class test8{
public int wh() {
int x;
int y;
int z;
boolean flag;

x = 10;
y = 2;
z = 4;
flag = false;
while ((((!((x) <= (y)))) && (((y) <= (z)))) || !flag) {
System.out.println(x + y);
x = x - 1;
y = y + 1;
if ((!((x) <= (0)))) flag = true;
}

return x - (y + z);
}
}

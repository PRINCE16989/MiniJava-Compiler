
class T24{
public static void main (String[] args) {
System.out.println(new test24().sumUp(5));
}
}

class test24{
public int sumUp(int n) {
int s;
int i;

s = 0;
i = 0;
while (i <= (n)) {
s = s + i;
i = i + 1;
}

return s;
}
}

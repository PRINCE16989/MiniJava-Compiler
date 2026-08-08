
class T12{
public static void main (String[] args) {
System.out.println(new test12().A(2));
}
}

class test12{
public int A(int i) {
int[] arr;
int t;

arr = new int[(5)];
t = 1;
while (t <= (arr.length)) {
arr[t - 1] = t;
t = t + 1;
}

return arr[i];
}
}

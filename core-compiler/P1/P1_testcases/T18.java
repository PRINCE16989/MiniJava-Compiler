
class T18{
public static void main (String[] args) {
System.out.println(new test18().exp(3,4));
}
}

class test18{
public int cube(int n) {


return (n * n) * n;
}public int exp(int a,int b) {


return ((((((((a + b) * (a + b)) + 10)) * 2) + (this.cube(a))) - (((((this.cube(b))) * ((this.cube(b)))) + 10))) - a);
}
}

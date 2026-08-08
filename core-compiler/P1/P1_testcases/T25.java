
class T25{
public static void main (String[] args) {
System.out.println(new test25().doubleValue(5));
}
}

class test25{
public int multiply(int a,int b) {


return a * b;
}public int doubleValue(int x) {


return (this.multiply((x),2));
}
}

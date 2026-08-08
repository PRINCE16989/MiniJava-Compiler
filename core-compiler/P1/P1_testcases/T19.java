
class T19{
public static void main (String[] args) {
System.out.println(new test19().bar());
}
}

class testbase19{
public int foo() {


return 1;
}
}
class test19 extends testbase19{
public int bar() {
int t;

t = (((this.foo())) + (2));

return t;
}
}

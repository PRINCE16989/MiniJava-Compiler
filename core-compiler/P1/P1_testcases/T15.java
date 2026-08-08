import java.util.function.Function;

class T15{
public static void main (String[] args) {
System.out.println(new test15().Less_Equal(5,10));
}
}

class test15{
public int Less_Equal(int a,int b) {
Function <Integer, Boolean>  f;
int t;

f = ((x)->(x <= b));
if (f.apply(a)) 
t = 1;
else t = 0;

return t;
}
}

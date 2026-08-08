
class T22{
public static void main (String[] args) {
System.out.println(new test22().plah(30));
}
}

class test22{
public int plah(int score) {
int t;

if (score <= ((10))) 
t = 0;
else {
if (score <= ((50))) 
t = 1;
else t = 2;
}

return t;
}
}

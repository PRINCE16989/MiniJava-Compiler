package helpers;

public class SNF extends RuntimeException {
    public String error_message;
    public SNF() {
        super("Symbol not found");
    }

    public SNF(String s) {
        super("Symbol not found");
        error_message = s;
    }
}

package helpers;

public class TE extends RuntimeException {
    public String error_message;
    public TE(String s) {
        super("Type error");
        error_message = s;
    }
}

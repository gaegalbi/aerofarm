package yj.capstone.aerofarm.exception;

public class NotFoundEnumException extends RuntimeException {
    private String field;

    public String getField() {
        return field;
    }

    public NotFoundEnumException(String field, String message) {
        super(message);
        this.field = field;
    }
}

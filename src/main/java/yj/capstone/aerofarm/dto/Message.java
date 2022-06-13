package yj.capstone.aerofarm.dto;

import lombok.Getter;

@Getter
public class Message {

    private final String message;

    private Message(String message) {
        this.message = message;
    }

    public static Message createMessage(String message) {
        return new Message(message);
    }
}

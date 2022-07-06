package yj.capstone.aerofarm.controller;

import org.springframework.http.HttpStatus;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import yj.capstone.aerofarm.dto.ErrorResponse;
import yj.capstone.aerofarm.exception.NotFoundEnumException;

@RestControllerAdvice
public class ExceptionController {

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ErrorResponse invalidRequestHandler(MethodArgumentNotValidException e) {
        ErrorResponse response = new ErrorResponse("잘못된 요청입니다.");
        for (FieldError fieldError : e.getFieldErrors()) {
            response.addValidation(fieldError.getField(), fieldError.getDefaultMessage());
        }
        return response;
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(NotFoundEnumException.class)
    public ErrorResponse invalidRequestHandler(NotFoundEnumException e) {
        ErrorResponse response = new ErrorResponse("잘못된 요청입니다.");
        response.addValidation(e.getField(), e.getMessage());
        return response;
    }
}

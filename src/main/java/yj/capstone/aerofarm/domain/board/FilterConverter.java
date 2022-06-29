package yj.capstone.aerofarm.domain.board;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter
public class FilterConverter implements AttributeConverter<PostFilter, String> {

    @Override
    public String convertToDatabaseColumn(PostFilter attribute) {
        return attribute.getLowerCase();
    }

    @Override
    public PostFilter convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        return PostFilter.findByLowerCase(dbData);
    }
}
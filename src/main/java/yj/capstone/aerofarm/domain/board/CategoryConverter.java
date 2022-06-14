package yj.capstone.aerofarm.domain.board;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter
public class CategoryConverter implements AttributeConverter<PostCategory, String> {

    @Override
    public String convertToDatabaseColumn(PostCategory attribute) {
        return attribute.getLowerCase();
    }

    @Override
    public PostCategory convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        return PostCategory.findByLowerCase(dbData);
    }
}

public class Test2 {
    public static String generator() {
        String str='';
        JSONgenerator gen = JSON.createGenerator(false);
        gen.writeStartObject();
        gen.writeFieldName('Example');
        gen.writeStartArray();
        for(Integer i=1;i<=10;i++){
            gen.writeStartObject();
            gen.writeStringField('Example','Field'+i);
            gen.writeEndObject();
        }
        gen.writeEndArray();
        gen.writeEndObject();
        str = gen.getAsString();
        return str;
    }
}
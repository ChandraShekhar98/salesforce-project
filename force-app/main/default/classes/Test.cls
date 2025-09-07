public class Test {
    public static string jsonGeneratorSample() {
        String strJson = '';
        JSONGenerator jsGen = JSON.createGenerator(true);
        jsGen.writeStartObject();
        jsGen.writeFieldName('Account');
        jsGen.writeStartArray();
        for(Account accIterator : [SELECT Id, Name, Industry, Phone, Type From Account limit 5]) {
            try {
                jsGen.writeStartObject();
                jsGen.writeStringField('Id', accIterator.Id);
                jsGen.writeStringField('Name', accIterator.Name);
                jsGen.writeStringField('Industry', accIterator.Industry);
                jsGen.writeStringField('Phone', accIterator.Phone);
                jsGen.writeStringField('Account Type', accIterator.Type);
                jsGen.writeEndObject();
            }
            catch(Exception ex) {
                System.debug('Line number ====> '+ex.getLineNumber() + 'Exception Message =====> '+ex.getMessage());   
            }
        }
        jsGen.writeEndArray();
        jsGen.writeEndObject();
        strJson = jsGen.getAsString();
        //System.debug(strJson);
        if(!String.isBlank(strJson)) {
            return strJson;
        }
        else {
            return null;
        }
    }
    
}
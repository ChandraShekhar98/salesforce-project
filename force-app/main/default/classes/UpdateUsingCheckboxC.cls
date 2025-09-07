public class UpdateUsingCheckboxC {
    
    @AuraEnabled
    public static List <Contact> fetchContact() {
        return [SELECT Id, FirstName, LastName, Phone FROM Contact Limit 10];
    }
    
    @AuraEnabled
    public static void updateRecord(List <String> lstRecordId) {
        List<Contact> lstUpdate = new List<Contact>();
        for(Contact con : [SELECT Id, FirstName, LastName, Phone FROM Contact WHERE Id IN : lstRecordId]){
            con.Phone = '999999'; // Add fields which you want to update
            lstUpdate.add(con);
        }
        
        if(lstUpdate.size() > 0){
            update lstUpdate;
        }
        
    }
}
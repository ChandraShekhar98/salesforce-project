public class UtilityClass {
    @future
    public static void updateInteraction(String mail){
        pcs__Interaction__c intrctn;
        try {
            intrctn = [SELECT Id, pcs__Count__c FROM pcs__Interaction__c WHERE Id =: mail];
            intrctn.Count__c += 1;
            System.debug('interaction record which will be updated '+intrctn);
            update intrctn;
        } catch(Exception e) {
            System.debug('Exception occured: '+e.getMessage());
        }
    }
    
    @future
    public static void insertInteraction(String intListString) {
        List<pcs__Interaction__c> interactionList = new List<pcs__Interaction__c>();
        try {
            interactionList = (List<pcs__Interaction__c>) JSON.deserialize(intListString, pcs__Interaction__c.class );
            System.debug('interaction list which will be created '+interactionList);
            insert interactionList;
        } catch(Exception e) {
            System.debug('Exception occured: '+e.getMessage());
        }
    }
    
    @future
    public static void insertRecord(String record) {
        try {
            System.debug('recordd debug '+ record);
            pcs__Interaction__c rec = (pcs__Interaction__c)JSON.deserialize(record, pcs__Interaction__c.class);
            System.debug('rec debug here '+rec);
            insert rec;
        } catch(exception e) {
            System.debug('Error occured: '+ e.getMessage());
        }
    }
}
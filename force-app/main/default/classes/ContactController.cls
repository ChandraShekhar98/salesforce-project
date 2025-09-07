public class ContactController {
	@AuraEnabled
    public static List<Contact> getContactList(List<Id> accountIds) {
        List<Contact> contactList=[SELECT FirstName,LastName,Name,Phone,Email FROM Contact WHERE AccountId in : accountIds];
        return contactList;
    }
    @AuraEnabled
    public static List<Contact> deleteContact(String conid, string accid) {
        if(conid != null){
            Contact delContact=[SELECT Id FROM Contact WHERE id=:conid];
            delete delContact;
        }
        return [SELECT Name, FirstName, LastName, Phone, Email FROM Contact WHERE accountId=:accid];
    }
}
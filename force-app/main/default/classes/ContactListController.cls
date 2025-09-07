public class ContactListController {
    
    @AuraEnabled
    public static List<Contact> getContactList(List<Id> accountIds) {
        List<Contact> contactList=[SELECT FirstName,LastName,Name,Phone,Email FROM Contact WHERE AccountId in : accountIds];
        return contactList;
    }
}
public class ABC {
    public static String contactID{get; set;}
    @AuraEnabled
    public static List<Contact> getContactList(String accountIds) {
        System.debug('');
        List<Contact> contactList=[SELECT id,Name,Phone,Email FROM Contact WHERE AccountId = : accountIds];
        contactID=contactList[0].id;
        System.debug(contactID);
        return contactList;
    }
}
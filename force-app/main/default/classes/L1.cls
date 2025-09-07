public class L1 {
    @AuraEnabled
    public static List<contact> getContactList(String accountId){
        List<Contact> contactList = new List<Contact>([SELECT id, FirstName, LastName, Name, Email, Phone
                                                       FROM Contact
                                                       where AccountId =: accountId]);
        return contactList;
    }
}
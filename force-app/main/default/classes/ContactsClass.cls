public class ContactsClass {
    public List<Account> accList{get;set;}
    public List<Contact> conList{get;set;}
    public String accId{get;set;}
    public void DisplayRelatedContacts(){
        accList=[SELECT Id,Name,AccountNumber FROM Account LIMIT 10];
    }
        public PageReference displayContact(){
            if(accId !=null)
                conList=[SELECT Id,FirstName,LastName FROM Contact WHERE AccountId=:accId];
            return null;
        }

}
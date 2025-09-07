public class DisplayRelatedContacts {
    public List<Account> accountsList{get;set;}
    public List<Contact> contactsList{get;set;}
    public String accountId{get;set;}
    public DisplayRelatedContacts(){
        accountsList=[SELECT Id,Name,AccountNumber,Phone,Fax,Website,ParentId FROM Account];
    }
    public PageReference displayContact() {
        accountId=ApexPages.currentPage().getParameters().get('accname');
        contactsList=new List<Contact>();
        if(accountId != null)
        	contactsList=[SELECT Id,Name,MobilePhone FROM Contact WHERE AccountId=:accountId];
        	if(contactsList.size() == 0)
            contactsList = null;
        return null;
    }
}
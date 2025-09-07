public class RadioButtonController {
	public string selectedAccountId{get; set;}
    public List<Account> accounts{get; set;}
    public List<Contact> contacts{get; set;}
   
    public RadioButtonController() {
         
        accounts = [SELECT Name,AccountNumber,Phone,Fax,Website,ParentId FROM Account LIMIT 10];
    }
    public PageReference getSelected() {
        System.debug('Entered account selection block');
       // selectedAccountId = ApexPages.currentPage().getParameters().get('accid');
        contacts = new List<Contact>();
        return null;
    }
    public void viewContacts() {  
        if(selectedAccountId != null) {
            contacts = [SELECT Name,MobilePhone FROM Contact WHERE AccountId =:selectedAccountId];
            if(contacts.size() == 0)
            contacts = null;
        }
    }
    public PageReference updateRecord() {
         update contacts;
           return null;
    }
}
public class MyController {
    public List<Account> accList {get;set;}
    public List<Account> editAccount {get;set;}
    public String searchKey {get;set;}
    public String accountID {get;set;}
    
    
    public MyController( ) {
    }
    
    public void search(){
        string searchquery='select id,Name,phone from account where name like \'%'+searchKey+'%\' ';
        accList= Database.query(searchquery);
    }
    
    public void clear(){
        accList.clear();
    }
    
    public void updateAccount(){
        system.debug('ID for Update:'+accountID);
        editAccount = [Select Name,phone from Account where id =:accountID];
    }
    
    public PageReference updateRecord()
    {
        update editAccount;
        search();
        return null;
    }
    
    public void deleteAccount(){
        
        system.debug('ID for Delete:'+accountID);
        Account deleteAccount = [Select Name,phone from account where id = :accountID];
        delete deleteAccount; 
       search();
    }
}
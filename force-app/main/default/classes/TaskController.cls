public class TaskController {
     
    public static List<Account> accList{get; set;}
    public PageReference getAccounts(){
       	accList=[SELECT Id,Name,Phone FROM Account]; 
        return null;
    }
    public static void displayAccounts(){
        
    }  
}
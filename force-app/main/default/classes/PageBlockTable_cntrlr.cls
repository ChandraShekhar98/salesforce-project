public class PageBlockTable_cntrlr {
   Public List<Account> acclist {get;set;}
   
   public PageBlockTable_cntrlr(){
     acclist = new List<Account>([select Id,Name,(select firstname,LastName from contacts) from Account]);
    }
}
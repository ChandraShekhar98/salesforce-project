public class MyController2 {
    public List<Account> accList{set;get;}
    public MyController2(){
        accList=[SELECT Id,Name from Account];
    }

}
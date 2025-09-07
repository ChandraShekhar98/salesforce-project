public class CustomClass {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [select Id,Name,AccountNumber,Phone FROM Account Limit 10];
    }
}
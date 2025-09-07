public class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Industry, NumberOfEmployees FROM Account WITH SECURITY_ENFORCED LIMIT 10];
    }
}
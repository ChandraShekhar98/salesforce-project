public without sharing class poc {

    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts() {
        return [SELECT Name, AccountNumber from Account Limit 10];
    }

}
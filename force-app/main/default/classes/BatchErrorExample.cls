global class BatchErrorExample implements Database.Batchable<sObject>, Database.RaisesPlatformEvents {
    
    global Database.QueryLocator start(Database.BatchableContext bctxt){
        return Database.getQueryLocator([SELECT Id,Name FROM Account]);
    }
    
    global void execute(Database.BatchableContext bctxt, List<Account> records){
        for(Account acc: records){
            acc.Name = null;
        }
        update records;
    }
    
    global void finish(Database.BatchableContext bctxt){
        
    }
    
}
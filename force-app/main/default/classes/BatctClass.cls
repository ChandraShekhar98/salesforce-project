global class BatctClass implements Database.Batchable<sObject> {
	global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([SELECT Id, Name, Site FROM Account]);
    }
    global void execute(Database.BatchableContext context, List<SObject> scope) {
        // Process the records in the current batch
        for (SObject record : scope) {
            Account account = (Account)record;
            account.Name += ' Processed';
            update account;
        }
    }
    global void finish(Database.BatchableContext context) {
        // This method will be called after all batches have been processed
    }
}
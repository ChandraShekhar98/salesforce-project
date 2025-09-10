trigger BatchErrorTrigger on BatchApexErrorEvent (after insert) {
    List<pcs__Error_Log__c> errorLogs = new List<pcs__Error_Log__c>();
    for(BatchApexErrorEvent evnt: Trigger.New){
        pcs__Error_Log__c logRec = new pcs__Error_Log__c();
        logRec.pcs__JobId__c = evnt.AsyncApexJobId;
        logRec.pcs__Message__c = evnt.Message;
        logRec.pcs__RecordIds__c = evnt.JobScope;
        errorLogs.add(logRec);
        insert errorLogs;
    }
    System.debug('error logs '+errorLogs);
}
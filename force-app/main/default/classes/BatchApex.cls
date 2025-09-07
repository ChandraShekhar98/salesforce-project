public class BatchApex implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bcxt) {
        Database.QueryLocator leadList = Database.getQueryLocator([SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce']);
        return leadList;
    }
    public void execute(Database.BatchableContext bcxt, List<Lead> records) {
        try {
            for(Lead ld: records) {
                if(ld.LeadSource == 'Dreamforce')
            		ld.LeadSource = 'CS';
            }
            update records;
        } catch(Exception e) {
            System.debug('Exception occured '+e.getStackTraceString());
        }
    }
    public void finish(Database.BatchableContext bcxt) {
        Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();
        emailToSend.setSubject('Batch Job Details');
        emailToSend.setSenderDisplayName('Chandrashekar - SFDC Developer');
        emailToSend.setHtmlBody('Batch job is run successfully and the JOB Id is '+bcxt.getJobId());
        emailToSend.setToAddresses(new String[]{'csp891992@gmail.com'});
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{emailToSend});
    }
}
trigger AccTrigger on Account (before insert, before update) {
    if(false){
        List<Id> ids = new List<Id>();
        for(Account acc: Trigger.new) {
            ids.add(acc.OwnerId);
        }
        
        Map<Id,User> userList = new map<Id,User>([SELECT Id, Name FROM User WHERE Id IN: ids]);
        for(Account acc: Trigger.New){
            acc.pcs__Owner_Name__c = userList.get(acc.OwnerId).Name;
        }
    }
    
    //the logic under this is if the status of account changes then we have to checl if there are contacts , if ther are contacts then dont proceed otherwise proceed
    List<Id> accList = new List<Id>();
    List<Contact> conList = new List<Contact>();
    Map<Id,Contact> conMap = new Map<Id,Contact>();
    
    if(Trigger.isUpdate && Trigger.isBefore) {
        for(Account acc: Trigger.New) {
            if(acc.pcs__CustomStatus__c != Trigger.oldMap.get(acc.Id).pcs__CustomStatus__c) {
                accList.add(acc.Id);
            }
        }
        conList = [SELECT Id, AccountId, FirstName, LastName FROM Contact WHERE AccountId IN: accList];
        
        for(Contact cn: conList) {
            conMap.put(cn.AccountId, cn);
        }
        
        for(Account acc: Trigger.New) {
            if(conMap.get(acc.Id) != null){
                acc.addError('There are contacts associated to this account');
            } else {
                continue;
            }
        }
        
        
    }
}
trigger CaseTrigger on Case (after update) {
    Map<String,String> caseAccMap = new Map<String,String>();
    Map<String,Case> accCaseMap = new Map<String,Case>();
    Map<Case,Contact> caseConMap = new Map<Case,Contact>();
    List<Contact> conList = new List<Contact>();
    List<Task> taskList = new List<Task>();
    for(Case cse: Trigger.New){
        if(cse.pcs__Escalation_Required__c == true){
            caseAccMap.put(cse.Id, cse.AccountId);
        }
        accCaseMap.put(cse.AccountId, cse);
    }
    conList = [SELECT Id, pcs__Primary_Contact__c, AccountId FROM Contact WHERE AccountId =: caseAccMap.values() AND pcs__Primary_Contact__c = true];
    for(Contact ct: conList){
        caseConMap.put(accCaseMap.get(ct.AccountId), ct);
    }
    
    for(Contact cte: caseConMap.values()){
        Task tsk = new Task();
        tsk.WhatId = accCaseMap.get(cte.AccountId).Id;
        tsk.WhoId = cte.Id;
        tsk.Subject = 'Follow Up the case '+accCaseMap.get(cte.AccountId).CaseNumber;
        taskList.add(tsk);
    }
    
    if(taskList.size() > 0){
        insert taskList;
    }
}
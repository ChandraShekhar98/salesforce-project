trigger TriggerOnLead on Lead (before insert) {
    
    List<Lead> leadLst = [SELECT Id, Name, Email FROM Lead];
    List<pcs__Interaction__c> intList = [SELECT Id, Name, Lead__c, pcs__Count__c, Email__c, Industry__c FROM pcs__Interaction__c];
    
    Map<String, String> leadMap = new Map<String, String>();
    for (Lead led: leadLst) {
        leadMap.put(led.Email, led.Id);
    }
    
    Map<String, String> intMap = new Map<String, String>();
    for (pcs__Interaction__c intr : intList) {
        intMap.put(intr.Email__c, intr.Id);
    }
    
    List<pcs__Interaction__c> interactionLst = new List<pcs__Interaction__c>();
    
    if (Trigger.isInsert && Trigger.isBefore) {
        for (Lead ld: Trigger.New) {
            try {
                if (leadMap.containsKey(ld.Email)) { 
                    Throw new StringException('Lead is existing.');
                } else {
                    continue;
                }
            } catch (exception e) {
                System.debug('Exception in the system '+e.getMessage());
            } finally {
                if (intMap.containsKey(ld.Email)) {
                    System.debug('interaction already there.');
                    UtilityClass.updateInteraction(intMap.get(ld.Email));
                } else {
                    System.debug('interaction not there.');
                    pcs__Interaction__c interaction = new pcs__Interaction__c();
                    interaction.Lead__c = leadMap.get(ld.Email);
                    interaction.Email__c = ld.Email;
                    interaction.Industry__c = ld.Industry;
                    interaction.pcs__Count__c = 1;
                    UtilityClass.insertRecord(JSON.serialize(interaction));
                }
            }
        } 
    }
}
trigger LeadTrigger on Lead (before insert, after insert) {
    
     //first get all the lead and interactions records available.
    List<Lead> leadLst = [SELECT Id, Name, Email FROM Lead];
    List<pcs__Interaction__c> intList = [SELECT Id, Name, Lead__c, pcs__Count__c, Email__c, Industry__c FROM pcs__Interaction__c];
    System.debug('initial lead list '+leadLst);
    System.debug('initial interactions list '+intList);
    
    //create a lead map and put lead email and lead id as key value.
    Map<String, String> leadMap = new Map<String, String>();
    for (Lead led: leadLst) {
        leadMap.put(led.Email, led.Id);
    }
    System.debug('lead map => '+leadMap);
    
    //create a interactions map and put interaction mail and id as key value.
    Map<String, String> intMap = new Map<String, String>();
    for (pcs__Interaction__c intr : intList) {
        intMap.put(intr.Email__c, intr.Id);
    }
    System.debug('interaction map => '+intMap);
    
    List<pcs__Interaction__c> interactionLst = new List<pcs__Interaction__c>();
    
    if (Trigger.isInsert && Trigger.isBefore) {
        System.debug('inside trigger.');
        System.debug('Trigger.New debug '+ Trigger.New);
        for (Lead ld: Trigger.New) {
            System.debug('Trigger.New mail debug '+ ld.Email);
            if (leadMap.containsKey(ld.Email)) {
                
                System.debug('Lead is already there in system.');
                
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
                    //interactionLst.add(interaction);
                    UtilityClass.insertRecord(JSON.serialize(interaction));
                }
                System.debug('error will be thrown');
                
                ld.addError('Lead record cannot be created.');
                
                
            } else {
                
                System.debug('Lead is not existing.');
                
            }
        }
        
        /*if (interactionLst.size()>0) {
            System.debug('data there in interactionLst');
            String jsonString = JSON.serialize(interactionLst);
            System.debug('json string '+jsonString);
            UtilityClass.insertInteraction(jsonString);
            System.debug('id of records inserted '+ interactionLst[0]);
        }*/
    }
    
    /*if (Trigger.isAfter) {
        System.debug('lead list in after trigger '+leadLst);
        System.debug('interaction list in after trigger '+intList);
        List<String> deleteIds = new List<String>();
        System.debug('trigger . new in after trigger '+ Trigger.New);
        for (Lead ld: Trigger.New) {
            if (leadMap.containsKey(ld.Email)) {
                if (intMap.containsKey(ld.Email)) {
                    deleteIds.add(ld.Id);   
                }
            }
        }
        List<Lead> leadsToDelete = [SELECT Id FROM Lead WHERE Id IN: deleteIds];
        delete leadsToDelete;
    }*/
}
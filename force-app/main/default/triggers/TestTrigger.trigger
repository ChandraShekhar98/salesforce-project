trigger TestTrigger on Lead (before insert, after insert) {
	List<Lead> leadLst = [SELECT Id, Name, Email FROM Lead WHERE Id NOT IN: Trigger.New];
    List<pcs__Interaction__c> intList = [SELECT Id, Name, Lead__c, pcs__Count__c, Email__c, Industry__c FROM pcs__Interaction__c];
    
    Map<String, String> leadMap = new Map<String, String>();
    for (Lead led: leadLst) {
        leadMap.put(led.Email, led.Id);
    }
    
    Map<String, String> intMap = new Map<String, String>();
    for (pcs__Interaction__c intr : intList) {
        intMap.put(intr.Email__c, intr.Id);
    }
    
    /*if (Trigger.isInsert && Trigger.isBefore) {


            for (Lead ld: Trigger.New) {
                if (leadMap.containsKey(ld.Email)) { 
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
                    Savepoint spoint = Database.setSavepoint();
                    ld.addError('Record should not be created.');
                    Database.rollback(spoint);
                }
            }
    }*/
    
    if(Trigger.isInsert && Trigger.isAfter) {

        for (Lead ld: Trigger.New) {
            
            try{

            if (leadMap.containsKey(ld.Email)) {


                if (intMap.containsKey(ld.Email)) {

                    UtilityClass.updateInteraction(intMap.get(ld.Email));
                } else {

                    pcs__Interaction__c interaction = new pcs__Interaction__c();
                    interaction.Lead__c = leadMap.get(ld.Email);
                    interaction.Email__c = ld.Email;
                    interaction.Industry__c = ld.Industry;
                    interaction.pcs__Count__c = 1;
                    UtilityClass.insertRecord(JSON.serialize(interaction));
                 }
                throw new stringexception('cadkm');
				
            }
            } catch(exception e){
    			System.debug('debug exc '+e.getMessage());            
	            }
        }
    }
}
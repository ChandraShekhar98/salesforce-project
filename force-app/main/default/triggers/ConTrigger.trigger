trigger ConTrigger on Contact (before insert, before update, after insert) {
    
    if(false){
        List<String> accList = new List<String>();
        
        for(Contact con: Trigger.new){
            if(con.pcs__Primary_Contact__c){
                accList.add(con.AccountId);   
            }
        }
        if(!accList.isEmpty()){
            Map<Id,Contact> conList = new Map<Id,Contact>([SELECT Id, AccountId, pcs__Primary_Contact__c FROM Contact WHERE AccountID IN: accList AND pcs__Primary_Contact__c = true]);
            
            Map<String, Contact> accConMap = new Map<String, Contact>();
            for(Contact cn: conList.values()){
                accConMap.put(cn.AccountId, cn);
            }
            
            for(Contact con : Trigger.new){
                if(con.pcs__Primary_Contact__c){
                    if(accConMap.get(con.AccountId) != null){
                        con.addError('Account Already has a primary contact');
                    }
                }
            }
        }
    }
    
    List<pcs__Contact_Relationship__c> conRelRecs = new List<pcs__Contact_Relationship__c>();
    
    if(Trigger.isAfter && Trigger.isInsert){
        for(Contact con: Trigger.new){
            pcs__Contact_Relationship__c rec = new pcs__Contact_Relationship__c();
            rec.pcs__Contact_Record__c = con.Id;
            rec.Name = 'Test'+con.LastName;
            conRelRecs.add(rec);
        }
        insert conRelRecs;
    }
}
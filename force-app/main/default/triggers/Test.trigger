trigger Test on Account (before insert, before update, before delete, after insert, after update, after undelete) {
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            
        }
        if(Trigger.isUpdate) {
            
        }
        if(Trigger.isDelete) {
            
        }
    }
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            
        }
        if(Trigger.isUpdate) {
            Test4.takeNew(Trigger.new,Trigger.old);
        }
        if(Trigger.isUndelete) {
            
        }
    }
}
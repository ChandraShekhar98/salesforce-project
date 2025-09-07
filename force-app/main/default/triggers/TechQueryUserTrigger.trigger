trigger TechQueryUserTrigger on User (after insert) { 
    if(Trigger.isAfter && Trigger.isInsert) { 
        Set<Id> userIds = new Set<Id>(); 
        Profile salesProfile = [Select Id From Profile Where Name = 'Custom: Sales Profile' LIMIT 1]; 
        for(User u : Trigger.new) { 
            if(u.ProfileId == salesProfile.Id) { 
                userIds.add(u.Id); 
            } 
        } 
        if(userIds != null) { 
            UserTriggerHandler.assignSalesPermissionSet(userIds); 
        } 
    } 
}
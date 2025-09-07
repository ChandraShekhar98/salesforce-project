public class UserTriggerHandler { 
   public static void assignSalesPermissionSet(Set<Id> newUsersId) { 
        PermissionSet salesUserPermissionSet = [Select Id From PermissionSet Where Name = 'Sales_User_Permissions']; 
        List<PermissionSetAssignment> psAssignments = new List<PermissionSetAssignment>(); 
        if(salesUserPermissionSet != null) { 
            for(Id userId : newUsersId) { 
                psAssignments.add(new PermissionSetAssignment(PermissionSetId = salesUserPermissionSet.Id, AssigneeId = userId)); 
            } 
        } 
        if(psAssignments != null) { 
            insert psAssignments; 
        } 
    } 
}
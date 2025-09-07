({
    fetchContact : function(component, event, helper) {
        var action = component.get("c.getContactList");
        var accountId = component.get("v.recordId");
        action.setParams({
            accountIds :accountId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS') {
                var contactsList=response.getReturnValue();
                component.set("v.contacts", contactsList);
            } 
            else {
                alert('Error Occured');
            }
        });
        $A.enqueueAction(action);
    },
    deleteAccount : function(component, event) {
        var toastEvent = $A.get('e.force:showToast');
        var action = component.get("c.deleteContact"); //Calling Apex Method
        var eventSource=event.getSource();
        var Id=eventSource.get('v.name');
        var accountid = component.get('v.recordId');
        action.setParams({
            conid:Id,
            accid:accountid
        });
       
        action.setCallback(this, function(response) {
            component.set("v.contacts",response.getReturnValue());
            var state=reponse.getState();
            alert(state);
            if(state=='SUCCESS') {
                toastEvent.setParams({
                    'title':'Success!',
                    'type':'success',
                    'mode':'dismissable',
                    'message':'Contact Successfully deleted.'
                });
                toastEvent.fire();
                window.location.reload();
            } else {
                toastEvent.setParams({
                    'title':'Error!',
                    'type':'error',
                    'mode':'dismissable',
                    'message':'Contact deletion failed.'
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})
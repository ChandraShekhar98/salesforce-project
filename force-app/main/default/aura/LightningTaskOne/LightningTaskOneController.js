({
    getContactsList : function(component, event, helper) {
        helper.fetchContact(component, event, helper);
    },
    doRedirect: function(component, event, helper){ 
        var eventSource=event.getSource();
        var Id=eventSource.get('v.name');
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId":Id,
            "slideDevName":"detail"
        });
        navEvt.fire();
    },
    editContact: function(component, event, helper) {
        var eventSource=event.getSource();
        var Id=eventSource.get('v.name');
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": Id
        });
        editRecordEvent.fire();
    },
    newContact: function(component, event, helper) {
        var createContact = $A.get("e.force:createRecord");
        createContact.setParams({
            "entityApiName": "Contact",
            "defaultFieldValues": {
                "AccountId": component.get("v.recordId")
            }
        });
        createContact.fire();
    },
    handleDeleteRecord: function(component, event, helper) {
        component.find("recordHandler").deleteRecord($A.getCallback(function(deleteResult) {
            if (deleteResult.state === "SUCCESS" || deleteResult.state === "DRAFT") {
                console.log("Record is deleted.");
            } else if (deleteResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
            } else if (deleteResult.state === "ERROR") {
                console.log('Problem deleting record, error: ' + JSON.stringify(deleteResult.error));
            } else {
                console.log('Unknown problem, state: ' + deleteResult.state + ', error: ' + JSON.stringify(deleteResult.error));
            }
        }));
    },
 
    /**
     * Control the component behavior here when record is changed (via any component)
     */
    handleRecordUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "CHANGED") {
           // record is changed
        } else if(eventParams.changeType === "LOADED") {
            // record is loaded in the cache
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted, show a toast UI message
            var resultsToast = $A.get("e.force:showToast");
            resultsToast.setParams({
                "title": "Deleted",
                "message": "The record was deleted."
            });
            resultsToast.fire();
 			window.location.reload();
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving, or deleting the record
        }
    },
    deleteRecord : function(component, event, helper) {
        if(confirm('Are you sure?'))
            helper.deleteAccount(component, event, helper);
    }
})
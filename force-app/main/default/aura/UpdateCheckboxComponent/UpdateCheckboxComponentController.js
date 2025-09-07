({
    loadContacts: function(component, event, helper) {
        var action = component.get('c.fetchContact');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.ContactList', response.getReturnValue());
                component.find("box3").set("v.value", false);
            }
        });
        $A.enqueueAction(action);
    },
    
    selectAll: function(component, event, helper) {
        var selectedHeaderCheck = event.getSource().get("v.value");
        var getAllId = component.find("boxPack"); 
        if(! Array.isArray(getAllId)){
            if(selectedHeaderCheck == true){ 
                component.find("boxPack").set("v.value", true);    
            }else{
                component.find("boxPack").set("v.value", false);
            }
        }else{
            // check if select all (header checkbox) is true then true all checkboxes on table in a for loop  
            // and set the all selected checkbox length in selectedCount attribute.
            // if value is false then make all checkboxes false in else part with play for loop 
            // and select count as 0
            if (selectedHeaderCheck == true) {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", true);
                }
            } else {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", false);
                }
            } 
        }  
    },
    updateFields: function(component, event, helper) {
        var updateId = [];
        var getAllId = component.find("boxPack");
        
        if(! Array.isArray(getAllId)){
            if (getAllId.get("v.value") == true) {
                updateId.push(getAllId.get("v.text"));
            }
        }else{
            
            for (var i = 0; i < getAllId.length; i++) {
                if (getAllId[i].get("v.value") == true) {
                    updateId.push(getAllId[i].get("v.text"));
                }
            }
        } 
        
        var action = component.get('c.updateRecord');
        action.setParams({
            "lstRecordId": updateId
        });
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(state);
                $A.get('e.force:refreshView').fire();
            }
        });
        $A.enqueueAction(action);
    },
    
})
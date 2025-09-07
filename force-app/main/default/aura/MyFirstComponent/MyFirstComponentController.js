({
	add : function(component) {
        var sumVal=component.get("v.value1")+component.get("v.value2");
        component.set("v.sum",sumVal);
	}
})
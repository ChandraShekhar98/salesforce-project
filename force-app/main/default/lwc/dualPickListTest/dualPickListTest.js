import { LightningElement } from 'lwc';
export default class DualPickListTest extends LightningElement {
    options = [
        { value: '1', label: 'Option 1' },
        { value: '2', label: 'Option 2' },
        { value: '3', label: 'Option 3' },
        { value: '4', label: 'Option 4' },
        { value: '5', label: 'Option 5' },
        { value: '6', label: 'Option 6' },
        { value: '7', label: 'Option 7' },
        { value: '8', label: 'Option 8' },
    ];

    handleChange(event) {
        // Get the list of the "value" attribute on all the selected options
        var selectedOptionsList = event.detail.value;
        console.log('select values '+ event.detail.value);
        //alert(`Options selected: ${selectedOptionsList}`);
    }

    handleClick(event){
        this.template.querySelector('lightning-dual-listbox').value = null;
    }
     
}
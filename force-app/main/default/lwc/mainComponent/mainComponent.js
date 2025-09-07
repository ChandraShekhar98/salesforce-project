import { LightningElement } from 'lwc';
import {returnMethod} from 'c/helperComponent';
export default class MainComponent extends LightningElement {
    outputValue;
    handleClick(){
        this.outputValue = returnMethod(this);
    }
}
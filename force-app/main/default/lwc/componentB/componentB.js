import { LightningElement,wire } from 'lwc';
import { subscribe, MessageContext} from 'lightning/messageservice';
import TestMessageChannel from '@salesforce/messageChannel/TestMessageChannel__c';
export default class ComponentB extends LightningElement {

    datahere;

    @wire(MessageContext)
    messageContext;

    subscription = null;

    connectedCallback() {
        this.subscribeMethod();
    }

    subscribeMethod(){
        if(subscription = null){
            this.subscription = subscribe(this.messageContext, TestMessageChannel, (message) => this.handleMessage(message));
        }
    }

    handleMessage(message) {
        this.datahere = message.textField;
    }

    
}
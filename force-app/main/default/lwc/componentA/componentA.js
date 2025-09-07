import { LightningElement,wire } from 'lwc';
import {publish, MessageContext} from 'lightning/messageService';
import TestMessageChannel from '@salesforce/messageChannel/TestMessageChannel__c';
export default class ComponentA extends LightningElement {
    message = 'test';

    @wire(MessageContext)
    messageContext;

    handleOnClick(){
        const payload = {
            textField : this.message
        }

        publish(this.messageContext, TestMessageChannel, payload);
    }
}
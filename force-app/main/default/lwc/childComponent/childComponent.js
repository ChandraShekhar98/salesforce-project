import { LightningElement,wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import MessageChannel from '@salesforce/messageChannel/MyMessageChannel__c';
export default class ChildComponent extends LightningElement {

    @wire(MessageContext)
    messageContext;

    subscription = null;
    receivedMessage = 'default value';

    subscribeToMessageChannel(){
        if(this.subscription==null){
            this.subscription = subscribe(this.messageContext,MessageChannel,(message) => this.handleMessage(message));
        }
    }

    connectedCallback(){
        this.subscribeToMessageChannel();
    }
    
    handleMessage(message){
        this.receivedMessage = message ? message.messageToSend : 'No message received';
    }
}
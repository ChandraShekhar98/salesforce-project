import { LightningElement,wire,api } from 'lwc';
import { publish,  MessageContext } from 'lightning/messageService';
import MessageChannel from '@salesforce/messageChannel/MyMessageChannel__c';
export default class ParentComponent extends LightningElement {

    @wire(MessageContext)
    messageContext;

    publishMessage(){
        const messagePayload = {
            messageToSend: 'Data from parent/publishing component'
        };
        publish(this.messageContext, MessageChannel, messagePayload);
    }
}
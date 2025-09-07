import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import AccountObject from '@salesforce/schema/Account';
import NameField from '@salesforce/schema/Account.Name';
import RevenueField from '@salesforce/schema/Account.AnnualRevenue';
import IndustryField from '@salesforce/schema/Account.Industry';
export default class RecordFormCmp extends LightningElement {
    objectApiName = AccountObject;
    accountFields =[NameField, RevenueField, IndustryField];
    handleSuccess(event){
        const toastEvnt = new ShowToastEvent({
            title:"Account Created",
            message:"Account is created successfully and the record id is "+event.detail.id,
            variant:"success"
        });
        this.dispatchEvent(toastEvnt);

    }
}
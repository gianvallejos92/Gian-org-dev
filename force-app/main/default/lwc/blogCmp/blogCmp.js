import { LightningElement, wire, track } from 'lwc';
import getBlogRecord from '@salesforce/apex/BlogController.getBlogRecords';

const columns = [
  { label: 'Title', fieldName: 'nameUrl', type: 'url', typeAttributes: {label: { fieldName: 'Title__c'}} }, 
  { label: 'Author FullName', fieldName: 'Author__c' }, 
  { label: 'Thumbnail', fieldName: 'Thumbnail__c', type: 'image' }, 
  { label: 'Selftext', fieldName: 'Selftext__c' }, 
];

export default class BlogCmp extends LightningElement {
  @track data;
  @track columns = columns;

  @wire(getBlogRecord)
  wiredPosts({error, data}) {
    console.log('wire');
    if(data) {
      let nameUrl;
      this.data = data.map(row => {
        nameUrl = '/' + row.Id;
        return {...row, nameUrl}
      });
      console.log('!: ' + JSON.stringify(this.data));
    } else if (error){
      console.error('Error message: ' + error);
    }
  }

}
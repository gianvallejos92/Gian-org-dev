import { createElement } from 'lwc';
import BlogCmp from 'c/blogCmp';
import getBlogRecord from '@salesforce/apex/BlogController.getBlogRecords';

const mockGetRecord = require("./data/getRecord.json");
const DATA_NUMBER = 10;

jest.mock(
    '@salesforce/apex/BlogController.getBlogRecords',
    () => {
        const {
            createApexTestWireAdapter
        } = require('@salesforce/sfdx-lwc-jest');
        return {
            default: createApexTestWireAdapter(jest.fn())
        };
    },
    { virtual: true }
);

describe('c-blog-cmp', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('Datatable records', () => {
        const element = createElement('c-blog-cmp', {
            is: BlogCmp
        });

        document.body.appendChild(element);

        getBlogRecord.emit(mockGetRecord);

        return Promise.resolve().then(() => {
            const table = element.shadowRoot.querySelectorAll('lightning-datatable');
            const recordsNumber = table[0].data.length;
            expect(recordsNumber).toBe(DATA_NUMBER);
        });        
    });
});
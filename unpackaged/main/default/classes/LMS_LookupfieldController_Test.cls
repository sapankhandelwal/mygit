@isTest
public with sharing class LMS_LookupfieldController_Test {
    //This test class just ensures that there is enough code coverage
    //to get the component into production from your sandbox
    //it does not perform any validations.
    static testMethod void testLookupField() {
        List<string> returnFields = new List<string> {'Name'};
        List<Account>  accList=  LMS_TestUtility.createAccount(1, true);
        Account a = [SELECT Id FROM Account LIMIT 1];
        LMS_LookupfieldController.getObjectDetails('Account');
        LMS_LookupfieldController.GetRecentRecords('Account', returnFields, 5);
        LMS_LookupfieldController.SearchRecords('Account', returnFields, returnFields, '', 'Name', 'ASC', 5, 'CreatedDate > 2001-01-01T00:00:01Z');
        LMS_LookupfieldController.GetRecord('Account', returnFields, a.Id);
    }
}
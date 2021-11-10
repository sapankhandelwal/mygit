/*--
* @File Name          : LMS_ItemRating_Trigger_Test.cls
* @Summary            : test class for Trigger LMS_ItemRating_Trigger
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/
@isTest
public class LMS_ItemRating_Trigger_Test {
    
    
    
    @isTest static void testMethod1()
    {
        //create Library Items
        List<Library_Item__c> itemList=LMS_TestUtility.createLibraryItems(5, true);
        
        //Create Account and Contact
        List<Account> accList=LMS_TestUtility.createAccount(1, true);
        List<Contact> conList=LMS_TestUtility.createContact(accList[0], 'test', 5, true);
        LMS_TestUtility.createRatings(conList[0], itemList[0], 1, true);  
        List<Library_Issue_Ret_Item__c> itemIssueList=LMS_TestUtility.createLibrary_Issue_Items(itemList, conList[0], 5, true);
        //check itemList
    }
}
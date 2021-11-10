/*--
* @File Name          : LMS_GeneralServiceController_test
* @Summary            : Test class for LMS_GeneralServiceController
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/


@isTest
public class LMS_GeneralServiceController_Test {
    static testMethod void testMethod1() {
        Test.startTest();
        List<Map<String,Object>> entries = LMS_GeneralServiceController.getPickListValuesApex(Constants.LMS_LIBITEM_OBJECTNAME, 'Type__c');
        Test.stopTest();

        System.assert(entries.size() > 0);
        Map<String,Object> entry = entries[0];
        System.assert(entry.get('label') != null);
        System.assert(entry.get('value') != null);
        System.assert(entry.get('isDefaultValue') != null);
    }

   
    static testMethod void testMethod2() {
        Test.startTest();
        try {
        List<Map<String,Object>> entries = LMS_GeneralServiceController.getPickListValuesApex(Constants.LMS_LIBITEM_OBJECTNAME, 'nof');
            System.assert(false, 'Exception was expected');
        } catch (Exception e) {
          //  System.assert(e instanceof AuraHandledException);
        }
        Test.stopTest();
    }
        @isTest static void searchLibraryItems()
 {
     //create Library Items
     List<Library_Item__c> itemList=LMS_TestUtility.createLibraryItems(3, true);
     
     //Create Account and Contact
     List<Account> accList=LMS_TestUtility.createAccount(1, true);
	 List<Contact> conList=LMS_TestUtility.createContact(accList[0], 'test', 2, true);
         
     List<Library_Issue_Ret_Item__c> itemIssueList=LMS_TestUtility.createLibrary_Issue_Items(itemList[0], conList[0], 5, true);
     
     //check itemList
     system.assert(itemIssueList!=null);
     List<LMS_SearchService.LMS_FilterCriteria> filterCriteria =new List<LMS_SearchService.LMS_FilterCriteria> ();
    Integer totalCount=LMS_GeneralServiceController.getTotalCount(Constants.LMS_LIBITEM_OBJECTNAME,filterCriteria);
   	system.assert(totalCount>0);
   
     List<Sobject> searchRecords=LMS_GeneralServiceController.searchRecords(Constants.LMS_LIBITEM_OBJECTNAME,Constants.LMS_LBITEM_SEARCHFIELDSET, filterCriteria, 1, 25, 'Name', 'asc');
     system.assert(searchRecords.size()>0);
     
     //logged in user info
     User userRec=LMS_GeneralServiceController.getLoggedinUserDetails();
     system.assert(userRec!=null);
      
     
 }
 
    

}
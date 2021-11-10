@isTest
public class LMS_SearchLibItemsController_Test {


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
    
     //check getLibraryItems
     List<Sobject> searchRecords1=LMS_SearchLibItemsController.getLibraryItems(filterCriteria);
     
 	 system.assert(searchRecords1.size()>0);
         
 }
    
    
}
/*--
* @File Name          : LMS_IssueItemController
* @Summary            : Test class for LMS_IssueItemController
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/

@isTest
public class LMS_IssueItemController_Test {



 @isTest static void searchLibraryItems()
 {
     //create Library Items
     List<Library_Item__c> itemList=LMS_TestUtility.createLibraryItems(5, true);
     
     //Create Account and Contact
     List<Account> accList=LMS_TestUtility.createAccount(1, true);
	 List<Contact> conList=LMS_TestUtility.createContact(accList[0], 'test', 5, true);
         
     List<Library_Issue_Ret_Item__c> itemIssueList=LMS_TestUtility.createLibrary_Issue_Items(itemList, conList[0], 5, true);
     //check itemList
     system.assert(itemIssueList!=null);
     List<LMS_SearchService.LMS_FilterCriteria> filterCriteria =new List<LMS_SearchService.LMS_FilterCriteria> ();
     
     
     List<Library_Issue_Ret_Item__c> itemIssueList1=LMS_TestUtility.createLibrary_Issue_Items(itemList, conList[1], 5, false);
    
   	LMS_IssueItemController.saveItemTransaction(itemIssueList1);
     
      Sobject searchRecord=LMS_IssueItemController.searchRecords(filterCriteria);
      system.assert(searchRecord!=null);
     
      List<Sobject> searchRecords=LMS_IssueItemController.getIssuedLibItems(filterCriteria);
      system.assert(searchRecords!=null);
    
     
     
     //actual return date is required for returning items
     itemIssueList[0].Actual_Return_Date__c=system.today();
     searchRecords=LMS_IssueItemController.returnLibItems(itemIssueList);
     
     system.debug('itemIssueList[0].status__c'+itemIssueList[0].status__c);
     system.assert(itemIssueList[0].status__c=='Returned');
     
      String message=LMS_IssueItemController.saveRatings(4, itemIssueList[0]);
      system.assert(message=='success');
        
     //get logged in user items
      List<LMS_IssueItemController.IssueItemGridCard> myissued=LMS_IssueItemController.getMyIssuedLibItems(filterCriteria);
    
 }
    
    
}
/*--
* @File Name          : lms_SearchLibItems.cmp (Aura Component)
* @Summary            : Component to display Library Items Search Page
* @Created On         : 01 Oct 2020
* @Created By         : sapan Khandelwal
* @Controller         : LMS_SearchLibItemsController
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/
public class LMS_SearchLibItemsController {
    
    //common function to search Records on the basis of Fieldsets and ObjectName
    	/**
	* @description common function to search Records on the basis of Fieldsets and ObjectName.
	* @return List<Library_Item__c>
	*/
    
    @auraEnabled
    public static List<Library_Item__c> getLibraryItems(List<LMS_SearchService.LMS_FilterCriteria> filterCriteria)
    {
        List<Library_Item__c> libItemsList=new List<Library_Item__c>();
        LMS_SearchService searchObj=new LMS_SearchService(filterCriteria,1,200,'Name','Asc');
        searchObj.objectName=Constants.LMS_LIBITEM_OBJECTNAME;
        searchObj.objectFieldSetName=Constants.LMS_LBITEM_SEARCHFIELDSET;
        libItemsList= searchObj.searchRecords();
        return libItemsList;
        
        
    }  
    
 
    
   
    
    
}
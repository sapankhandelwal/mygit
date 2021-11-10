/*--
* @File Name          : LMS_GeneralServiceController
* @Summary            : Controller for lms_GeneralService.cmp
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Controller         : LMS_GeneralServiceController
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/

public  class LMS_GeneralServiceController  {
	    
    private class LMS_GeneralServiceException extends Exception {}
        
	/**
	* @description get logged in user details and return fields from  Fieldsts 
	* @return User
	*/
    //get logged in user details from Fieldsts 
       @AuraEnabled(Cacheable=true)
        public static User getLoggedinUserDetails()
        {
             List<LMS_SearchService.LMS_FilterCriteria> filterCriteria =new List<LMS_SearchService.LMS_FilterCriteria>();
  			 LMS_SearchService.LMS_FilterCriteria fl= new LMS_SearchService.LMS_FilterCriteria();
			fl.property='id';
            fl.operator='equals';
            fl.value=UserInfo.getUserId();
            fl.valueType ='String';
            filterCriteria.add(fl);
            LMS_SearchService searchObj=new LMS_SearchService(filterCriteria,1,1,'Name','Asc');
        searchObj.objectName=Constants.LMS_USER_OBJECTNAME;
        searchObj.objectFieldSetName=Constants.LMS_USER_SEARCHFIELDSET;
        List<User> searchList= searchObj.searchRecords();
        return searchList[0];
        }
    
    	/**
	* @descriptionThis is a common function called from all components for getting total counts of Records for search Criteria
	* @return Integer
	*/
    //This is a common function called from all components for getting total counts of Records for search Criteria,used by lms_searchLib item
     @auraEnabled
    public static Integer getTotalCount(String objectName,List<LMS_SearchService.LMS_FilterCriteria> filterCriteria)
    {system.debug('filterCriteria'+filterCriteria);
        
        LMS_SearchService searchObj=new LMS_SearchService(filterCriteria,1,1,'Name','Asc');
        searchObj.objectName=objectName;
        searchObj.objectFieldSetName=Constants.LMS_LBITEM_SEARCHFIELDSET;
        
        List<Library_Item__c> libItemsList=new List<Library_Item__c>();
        Integer totalRecordCount= searchObj.getTotalRecordsCount();
        
        return totalRecordCount;
        
    }
   
    	/**
	* @description common function to get picklist values for a field
	* @return List<Map<String,Object>>
	*/
    //common function to get picklist values for a field
    @AuraEnabled(Cacheable=true)
    public static List<Map<String,Object>> getPickListValuesApex(String objectName, String fieldName) {
        // Get entries from object and field names
        List<Schema.PicklistEntry> allEntries;
        try {
            Schema.DescribeSobjectResult[] objDescriptions = Schema.describeSObjects(new String[]{objectName});
            Schema.SObjectField field = objDescriptions[0].fields.getMap().get(fieldName);
            if (field == null) {
                throw new LMS_GeneralServiceException('No such field.');
            }
            Schema.DescribeFieldResult fieldDescription = field.getDescribe();
            allEntries = fieldDescription.getPicklistValues();
        } catch (Exception e) {
            throw new LMS_GeneralServiceException('Failed to retrieve entries for picklist '+ objectName +'.'+ fieldName +': '+ e.getMessage());
       // LMS_Logger.logException('LMS_GeneralServiceController', 'getPickListValuesApex', '', lineNumber)
        }
        
        // Filter active entries and convert output (AuraEnabled methods cannot return List<Schema.PicklistEntry>)
        List<Map<String,Object>> activeEntries = new List<Map<String,Object>>();
        for(Schema.PicklistEntry entry : allEntries) {
            if (entry.isActive()) {
                Map<String,Object> entryData = new Map<String,Object>();
                entryData.put('value', entry.getValue());
                entryData.put('label', entry.getLabel());
                entryData.put('isDefaultValue', entry.isDefaultValue());
                activeEntries.add(entryData);
            }
        }
        return activeEntries;
    }
    
    
    //common function to search Records on the basis of Fieldsets and ObjectName
    	/**
	* @description common function to search Records on the basis of Fieldsets and ObjectName.
	* @return List<Library_Item__c>
	*/
     @auraEnabled
    public static List<Library_Item__c> searchRecords(String objectName,String fieldsetName,List<LMS_SearchService.LMS_FilterCriteria> filterCriteria, Decimal page, Decimal pageSize, String sortCol, String sortDir)
    {
        
        LMS_SearchService searchObj=new LMS_SearchService(filterCriteria,page,pageSize,sortCol,sortDir);
        searchObj.objectName=objectName;
        searchObj.objectFieldSetName=fieldsetName;
        
        List<Library_Item__c> libItemsList=new List<Library_Item__c>();
        libItemsList= searchObj.searchRecords();
        
        return libItemsList;
        
    }
    
    
}
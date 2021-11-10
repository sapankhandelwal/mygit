/*--
* @File Name          : lms_issuereturn.cmp (Aura Component)
* @Summary            : Component to get Library issued Item
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Controller         : LMS_IssueItemController
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/
global  Without Sharing class LMS_IssueItemController {
   
    // function to search Records on the basis of Fieldsets and ObjectName
    @AuraEnabled
    public static Library_Item__c searchRecords(List<LMS_SearchService.LMS_FilterCriteria> filterCriteria)
    {
        List<Library_Item__c> libItem=null;
        
        LMS_SearchService searchObj=new LMS_SearchService(filterCriteria,1,1,'Name','Asc');
        searchObj.objectName=Constants.LMS_LIBITEM_OBJECTNAME;
        searchObj.objectFieldSetName=Constants.LMS_LBITEM_SEARCHFIELDSET;
        libItem= searchObj.searchRecords();
        if(libItem!=null && !libItem.isEmpty())
        return libItem[0];
        else
        throw new AuraException('Record not found');
        
    }
    //used to Return issued Items
    @AuraEnabled
    public static List<Library_Issue_Ret_Item__c> returnLibItems(List<Library_Issue_Ret_Item__c> lstTransaction)
    {
        List<Library_Issue_Ret_Item__c> lstUpdatedTransaction=new List<Library_Issue_Ret_Item__c>();
        system.debug('Library_Issue_Ret_Item__c'+lstTransaction);
        for(Library_Issue_Ret_Item__c irt :lstTransaction)
        {
            if(irt.Actual_Return_Date__c!=null)
            {
                irt.Status__c='Returned';
                lstUpdatedTransaction.add(irt);
            }
        }
        update  lstUpdatedTransaction;
        return lstUpdatedTransaction;
    }
    
    
    // function to save  Records
    @AuraEnabled
    public static String saveItemTransaction(List<Library_Issue_Ret_Item__c> lstTransaction)
    {
        system.debug('Library_Issue_Ret_Item__c'+lstTransaction);
        String status='succes';
        insert  lstTransaction;
        return status;
    }
    
    
    //used to save ratings for a Item
    @AuraEnabled
    public static String saveRatings(Integer itemRatings,Library_Issue_Ret_Item__c item)
    {
        Library_Item_Rating__c rating=new Library_Item_Rating__c();
        system.debug('Library_Issue_Ret_Item__c'+itemRatings);
        List<Library_Item_Rating__c> oldRatings=[select id from Library_Item_Rating__c
                                                 where Library_Item__c=:item.Library_Item__r.id 
                                                 and Issued_To__c=:item.Issued_To__c limit 1];
        system.debug('oldRatings'+oldRatings);
        rating.Rate_Points__c=String.valueOf(itemRatings);
        
        if(oldRatings!=null && !oldRatings.isEmpty())
        {
            rating.id=oldRatings[0].id; 
        }else{
            rating.Issued_To__c=item.Issued_To__c;
            rating.Library_Item__c=item.Library_Item__c;
        }
        String status='success';
        upsert  rating;
        return status;
    }
    
    // Used to return items issued by User
   //common function to search issued Records for Logged in Users
    	/**
	* @description common function to search Records on the basis of Fieldsets and ObjectName.
	* @return List<LMS_IssueItemController.IssueItemGridCard>
	*/
    
    @AuraEnabled
    public static List<LMS_IssueItemController.IssueItemGridCard> getMyIssuedLibItems(List<LMS_SearchService.LMS_FilterCriteria> filterCriteria)
    {
        List<Library_Issue_Ret_Item__c> searchList=new List<Library_Issue_Ret_Item__c>();
        Map<id,Library_Item_Rating__c> itemRatingMap=new Map<id,Library_Item_Rating__c>();
        List<LMS_IssueItemController.IssueItemGridCard> gridList=new List<LMS_IssueItemController.IssueItemGridCard>();
        
        
        LMS_SearchService searchObj=new LMS_SearchService(filterCriteria,1,200,'Name','Asc');
        searchObj.objectName=Constants.LMS_LIBISSUERETURN_OBJECTNAME;
        searchObj.objectFieldSetName=Constants.LMS_LIBISSUERETURN_SEARCHFIELDSET;
        searchList= searchObj.searchRecords();
        //if search list is not null then Return ratings for it also
        if(searchList!=null)
            
        {
            List<id> itemIds=new List<Id>();
            for(Library_Issue_Ret_Item__c item:searchList)
            {
                itemIds.add(item.Library_Item__c);   
                
            }//get all items 
            //get the rating
            List<Library_Item_Rating__c> rl=new List<Library_Item_Rating__c>([select id,Rate_Points__c,Library_Item__c from Library_Item_Rating__c where Library_Item__c in:itemIds and issued_To__c=: searchList[0].issued_To__c ]);
            if(rl!=null && !rl.isEmpty() )  
            {
                for(Library_Item_Rating__c ir:rl)
                {
                    itemRatingMap.put(ir.Library_Item__c,ir);
                }
            }          
            
            for(Library_Issue_Ret_Item__c lir: searchList)
            {
                IssueItemGridCard gr=new IssueItemGridCard();
                
                gr.issuedItem=lir;
                if(itemRatingMap.containskey(lir.Library_Item__c))
                    gr.ratings=itemRatingMap.get(lir.Library_Item__c);
                gr.id=lir.id;
                gridList.add(gr);
            }
        }
        return gridList;
    }
    //used in lms_Returnitem aura component ,used to return item issued for a item
    @AuraEnabled
    public static List<Library_Issue_Ret_Item__c> getIssuedLibItems(List<LMS_SearchService.LMS_FilterCriteria> filterCriteria)
    {
        List<Library_Issue_Ret_Item__c> searchList=new List<Library_Issue_Ret_Item__c>();
        LMS_SearchService searchObj=new LMS_SearchService(filterCriteria,1,200,'Name','Asc');
        searchObj.objectName=Constants.LMS_LIBISSUERETURN_OBJECTNAME;
        searchObj.objectFieldSetName=Constants.LMS_LIBISSUERETURN_SEARCHFIELDSET;
        searchList= searchObj.searchRecords();
        return searchList;
    }
    
    //used in grid card aura
    global class IssueItemGridCard  {
        @AuraEnabled
        public String id{get;set;}
        
        @AuraEnabled
        public  Library_Issue_Ret_Item__c issuedItem{get;set;}
        
        @AuraEnabled
        public Library_Item_Rating__c ratings {get;set;}
        
    }
}
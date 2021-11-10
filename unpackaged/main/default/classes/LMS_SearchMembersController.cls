/*--
* @File Name          : lms_SearchMembers.cmp (Aura Component)
* @Summary            : Component to search Members
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Controller         : LMS_SearchMembersController
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/
public class LMS_SearchMembersController {
    @auraEnabled
    public static List<LMS_SearchMembersController.MemberGridCard> searchRecords(List<LMS_SearchService.LMS_FilterCriteria> filterCriteria, Decimal page, Decimal pageSize, String sortCol, String sortDir)
    {
        system.debug('filterCriteria'+filterCriteria);
        List<LMS_SearchMembersController.MemberGridCard> searchMembersList=new List<LMS_SearchMembersController.MemberGridCard>();
        List<User> searchList=new List<User>();
        List<id> userContactIds=new List<id>();
        Map<id,Integer> userItemCount=new Map<id,Integer>();
        
        LMS_SearchService searchObj=new LMS_SearchService(filterCriteria,1,200,'Name','Asc');
        searchObj.objectName=Constants.LMS_USER_OBJECTNAME;
        searchObj.objectFieldSetName=Constants.LMS_USER_SEARCHFIELDSET;
        searchList= searchObj.searchRecords();
        //get total issued Items of user
         for(User u :searchList)
         {
             
          userContactIds.add(u.ContactId);   
         }
        if(userContactIds!=null && !userContactIds.isEmpty())
        {
            
            for(AggregateResult a :[select count(id) totalcount,Issued_To__c  from Library_Issue_Ret_Item__c where Issued_To__c in:userContactIds group by Issued_To__c ]) {  
            Integer count=(Integer)a.get('totalcount');
      		userItemCount.put((Id)a.get('Issued_To__c'),count);
        }
            
        }
         for(User u :searchList)
                {
                    MemberGridCard memb = new MemberGridCard();
                    memb.id = String.valueOf(u.contactId);
                    memb.contact =u.contact;
                    memb.user = u;
                    memb.profilePhotoUrl = memb.user.SmallPhotoUrl;
                    searchMembersList.add(memb);
                    memb.currentIssuedItems=userItemCount.get(u.contactId)==null?0:userItemCount.get(u.contactId);
                }         
        system.debug('searchMembersList'+searchMembersList);
             return searchMembersList;
       
        
             
    } 
     public class MemberGridCard  {
        @AuraEnabled
        public String id{get;set;}
        
        @AuraEnabled
        public Contact contact{get;set;}
        
        @AuraEnabled
        public User user{get;set;}
        
         @AuraEnabled
        public Integer currentIssuedItems{get;set;}
       
         @AuraEnabled
        public String profilePhotoUrl{get;set;}
    }
}
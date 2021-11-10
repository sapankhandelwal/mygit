trigger LMS_IssueRet_Trigger on Library_Issue_Ret_Item__c (before insert, after insert,before update,
                                                    after update, before delete, after delete) {

   
     LMS_TriggerFactory.execute(LMS_IssueRet_TriggerHandler.class);
    
        
         
                                                    
}
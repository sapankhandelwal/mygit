/*--
* @File Name          : LMS_IssueRet_TriggerHandler.cls
* @Summary            : handler for Trigger LMS_IssueRet_Trigger for object Library_Issue_Ret_Item__c
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/
public class LMS_IssueRet_TriggerHandler implements ITriggerHandler {
  
    //Use this variable to disable this trigger from transaction
    public static Boolean TriggerDisabled = false;
     
    //check if the trigger is disabled from transaction
    public Boolean isDisabled(){
        return TriggerDisabled;
    }
     
    public void beforeInsert(List<sObject> newList) {
     LMS_IssueRet_TriggerHelper.checkIssuedItemCount(newList, null);
         
    }
     
    public void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
         
    }
     
    public void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap) {
	if(!LMS_IssueRet_TriggerHelper.isRecursive)    
 	LMS_IssueRet_TriggerHelper.checkIssuedItemCount(newList, oldMap);
        
    }
     
    public void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap) {
    
    }
     
    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
     
    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
     
    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {
         
    }


}
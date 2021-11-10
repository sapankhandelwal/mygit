/*--
* @File Name          : LMS_ItemRating_TriggerHandler.cls
* @Summary            : handler for Trigger LMS_ItemRating_Trigger for object Library_Item_Rating__c
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/

public class LMS_ItemRating_TriggerHandler implements ITriggerHandler{
     
    //Use this variable to disable this trigger from transaction
    public static Boolean TriggerDisabled = false;
     
    //check if the trigger is disabled from transaction
    public Boolean isDisabled(){
        return TriggerDisabled;
    }
     
    public void beforeInsert(List<sObject> newList) {
         
    }
     
    public void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
              LMS_ItemRating_TriggerHelper.rollUpRatingOnItem(newList);
        
    }
     
    public void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap) {
         
    }
     
    public void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap) {
              LMS_ItemRating_TriggerHelper.rollUpRatingOnItem(newList);
    
    }
     
    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
     
    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
     
    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {
         
    }


   
}
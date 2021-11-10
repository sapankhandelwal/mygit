/*--
* @File Name          : LMS_ItemRatingTrigger
* @Summary            : Trigger for Library_Item_Rating__c Object
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/

trigger LMS_ItemRatingTrigger on Library_Item_Rating__c (before insert, after insert, before update, after update, before delete, after delete, after unDelete) {

LMS_TriggerFactory.execute(LMS_ItemRating_TriggerHandler.class);
    
}
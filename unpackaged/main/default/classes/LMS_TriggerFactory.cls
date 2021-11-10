/*--
* @File Name          : LMS_TriggerFactory.cls
* @Summary            : used to identify handler for all Triggers and disable/enabled Triggers from customsettings
* @Created On         : 01 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================*/
public class LMS_TriggerFactory {
    
    
      private static ITriggerHandler getHandler(Type t) {
        // Instantiate the type
        Object o = t.newInstance();
 
        // if its not an instance of ITrigger return null
        if (!(o instanceOf ITriggerHandler)) {
            return null;
        }
 
        return (ITriggerHandler)o;
    }
 public static void execute(Type t){
        
        // Get a handler appropriate to the object being processed
        ITriggerHandler handler = getHandler(t);
         
        // Make sure we have a handler registered, new handlers must be registered in the getHandler method.
        if (handler == null) {
            throw new TriggerException('No Trigger Handler found named: ' + t.getName());
        }
    	 //Check if the trigger is disabled
        if (handler.IsDisabled()){
            return;
        }
         
        //Get the trigger active information from custom settings by trigger name
          Library_Trigger_Settings__c  triggerSettings= Library_Trigger_Settings__c.getInstance();

        if(!triggerSettings.disableTrigger__c){
            //Check trigger context from trigger operation type
            switch on Trigger.operationType {
                 
                when BEFORE_INSERT {
                    //Invoke before insert trigger handler
                    handler.beforeInsert(trigger.new);
                }
                when AFTER_INSERT {
                    //Invoke after insert trigger handler
                    handler.afterInsert(trigger.new, trigger.newMap);
                }
                when BEFORE_UPDATE {
                    //Invoke before update trigger handler
                    handler.beforeUpdate(trigger.new, trigger.newMap, trigger.old, trigger.oldMap);
                }
                when AFTER_UPDATE {
                    //Invoke after update trigger handler
                    handler.afterUpdate(trigger.new, trigger.newMap, trigger.old, trigger.oldMap);
                }
               
            }
        }
    }
      public class TriggerException extends Exception {}
}
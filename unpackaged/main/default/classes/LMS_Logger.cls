/*--
* @File Name          : LMS_Logger
* @Summary            : classs for Logging purpose
* @Created On         : 10 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/


public class LMS_Logger
{
    //Save information log
    public static void logInformation(String className, String methodName, String description){
        LibraryItem_Log__c log = new LibraryItem_Log__c();
        log.Class__c = className;
        log.Method__c = methodName;
        log.Description__c = description;
        log.Type__c = 'Information';
        Insert log;
    }
     
    //Save success log
    public static void logSuccessData(String className, String methodName, String description){
        LibraryItem_Log__c log = new LibraryItem_Log__c();
        log.Class__c = className;
        log.Method__c = methodName;
        log.Description__c = description;
        log.Type__c = 'Success';
        Insert log;
    }
     
    //Save exception log
    public static void logException(String className, String methodName, String description, Integer lineNumber){
        LibraryItem_Log__c log = new LibraryItem_Log__c();
        log.Class__c = className;
        log.Method__c = methodName;
        log.Description__c = description;
        log.Type__c = 'Error';
        Insert log;
    }
     
    //Save HTTP response log
}
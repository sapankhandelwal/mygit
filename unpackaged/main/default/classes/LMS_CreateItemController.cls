public class LMS_CreateItemController {
    
    //used to get Record type values for object Library Item
    @AuraEnabled
    public static Map<String,String> getRecordTypesMap()
    {
        Map<String,String> recordTypeMap = new Map<String,String>();
        Schema.DescribeSObjectResult R = Library_Item__c.SObjectType.getDescribe();
        List<Schema.RecordTypeInfo> recordTypeInfo = R.getRecordTypeInfos();
        
        
        for(Schema.RecordTypeInfo info : recordTypeInfo){
            if(info.getName()!='Master')
            recordTypeMap.put(info.getName(),info.getRecordTypeId());
        }
        
        
        return recordTypeMap;
    }   
}
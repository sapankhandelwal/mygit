/*--
* @File Name          : LMS_IssueRet_TriggerHelper
* @Summary            : Helper for LMS_IssueRet_TriggerHandler
* @Created On         : 01 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/
public without sharing class  LMS_IssueRet_TriggerHelper {
    
    public static  Boolean  isRecursive=false;
    
    //used to check total item issued by user and display error if maximum count reached
    public static void checkIssuedItemCount(List<Library_Issue_Ret_Item__c> newList,Map<Id, sObject> oldMapSObject)
    {
        Map<id,Library_Issue_Ret_Item__c> oldMap=null;
        
        
        Library_General_Settings__c  triggerSettings= Library_General_Settings__c.getInstance();
        Integer totalItemLimit=(Integer)triggerSettings.Item_Issue_Limit__c;
        Map<String,Integer> membertotalitemCount=new Map<String,Integer>();//used to check total item issued by a member
        Map<Id,Contact> contactMap=null;//used to check total item issued by a member
        
        Set<Id> itemList=new Set<id>();//
        Set<Id> contactList=new set<id>();//
        
        Map<String,Integer> memberitemConcatMap=new Map<String,Integer>();//used to check count os single item issued by a member
        
        List<Library_Issue_Ret_Item__c> filterList=new List<Library_Issue_Ret_Item__c>();
        
        if(oldMapSObject!=null)
        {
            oldMap=new Map<id,Library_Issue_Ret_Item__c>();
            for(Id key : oldMapSObject.keySet())
            {
                oldMap.put(key, (Library_Issue_Ret_Item__c)oldMapSObject.get(key));
            }
        }
           //get all the new item issued in Map with contacid and library Item
     
        for(Library_Issue_Ret_Item__c issueItem: newList)
        {
            if(issueItem.Status__c=='Issued' && (oldMap==null ||oldMap.get(issueItem.id).status__c!=issueItem.Status__c))
            {
                filterList.add(issueItem);
                itemList.add(issueItem.Library_Item__c);
                contactList.add(issueItem.Issued_To__c);
            }  
            
        }
        if(!filterList.isEmpty())
        {
            List<Library_Issue_Ret_Item__c> existingList=  [select   id,library_Item__c,Issued_To__c  from Library_Issue_Ret_Item__c 
                                                            where Issued_To__c in :contactList 
                                                            and status__c='Issued'];
            
            contactMap=  new Map<id,contact>([select id,name from Contact where id in:contactList]);
            
            if(existingList==null || existingList.isEmpty()){
                
                existingList=new List<Library_Issue_Ret_Item__c>();
                
            }
            existingList.addAll(filterList);
            system.debug('existingList'+existingList);
            //check the existing issued Item
            if(membertotalitemCount!=null && membertotalitemCount.isEmpty())
            {
                for(Library_Issue_Ret_Item__c issueItem:existingList  )
                {
                    if(!membertotalitemCount.containsKey(issueItem.Issued_To__c))
                    {
                        membertotalitemCount.put(issueItem.Issued_To__c,0);   
                    }
                    membertotalitemCount.put(issueItem.Issued_To__c , membertotalitemCount.get(issueItem.Issued_To__c)+1);
                    //now create a concat key
                    
                    String key=issueItem.Issued_To__c+'-'+issueItem.Library_Item__c;
                    if(!memberitemConcatMap.containsKey(key))
                    {
                        memberitemConcatMap.put(key,0);   
                    }
                    memberitemConcatMap.put(key , memberitemConcatMap.get(key)+1);
                    
                }
                
                
                system.debug('membertotalitemCount'+membertotalitemCount);
                system.debug('memberitemConcatMap'+memberitemConcatMap);
                
                //now loop filteredlist and check for count and throw error
                for(Library_Issue_Ret_Item__c issueItem:filterList)
                {
                    String key=issueItem.Issued_To__c+'-'+issueItem.Library_Item__c;
                    if(memberitemConcatMap.containsKey(key) && memberitemConcatMap.get(key)>1)
                    {
                        issueItem.addError(issueItem.Library_Item_Name__c+' '+ Constants.MEMBER_SINGLEITEMISSUETHRESHOLD_MESSAGE+' '+(contactMap.get(issueItem.Issued_To__c)!=null?contactMap.get(issueItem.Issued_To__c).Name:'')); 
                        
                        
                    }
                    if(membertotalitemCount.containsKey(issueItem.Issued_To__c) && membertotalitemCount.get(issueItem.Issued_To__c)>totalItemLimit)
                    {
                        issueItem.addError(Constants.MEMBER_ISSUEDTHRESHOLD_MESSAGE+' '+contactMap.get(issueItem.Issued_To__c).Name); 
                        
                        
                    }
                    
                }
            }
            
        }
        isRecursive=true;
    }
    
    
}
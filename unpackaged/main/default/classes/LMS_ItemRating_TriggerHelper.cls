/*--
* @File Name          : LMS_ItemRating_TriggerHelper.cls
* @Summary            : handler for Trigger LMS_ItemRating_TriggerHandler
* @Created On         : 09 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
sapan 9 Oct 2020			 added method rollUpRatingOnItem to rollup rating 
========================================================================*/

public class LMS_ItemRating_TriggerHelper {
    
    
    //this method rolls up rating on Library_Item,could hve been done from rollup but avg cannot be calculated on master
    public static void rollUpRatingOnItem(List<Library_Item_Rating__c> newList)
    {
        List<AggregateResult> result=new  List<AggregateResult>();
        Map<id,Library_Item__c> libItemMap=new Map<Id,Library_Item__c>();
        for(Library_Item_Rating__c ir: newList)
        {
            if(!libItemMap.containsKey(ir.Library_Item__c))
            {
                libItemMap.put(ir.Library_Item__c,new Library_Item__c(id=ir.Library_Item__c,Avg_Rating__c=0)); 
            }   
            
        }
        result=[select Library_Item__c,avg(Ratings__c) AVGRatings
                from Library_Item_Rating__c
                where Library_Item__c in:libItemMap.keySet() group by Library_Item__c];
        for(AggregateResult a : Result) {  
            Decimal rating=(Decimal)a.get('AVGRatings');
            if(rating==null){rating=0;}
            libItemMap.get((Id)a.get('Library_Item__c')).Avg_Rating__c=rating.setScale(0);
        }
        if(libItemMap!=null && !libItemMap.isEmpty())
        {
            update libItemMap.values();
            
        }
    }  
}
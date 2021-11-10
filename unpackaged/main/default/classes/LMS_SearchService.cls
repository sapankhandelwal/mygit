/*--
* @File Name          : LMS_SearchService.apxc
* @Summary            : LMS_SearchService is used  to search records using search criteria
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Controller         : LMS_SearchService
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/
public  class LMS_SearchService {
    List<LMS_SearchService.LMS_FilterCriteria> filterCriteria{get;set;}
    Decimal pageNo{get;
                   set;}
                  
    
  public  Decimal pageSize{get;
                     set;
                    }
    public String sortCol{get;
                   set;}
   public String sortDir{get;set;}
   public String objectName{get;set;}
    public String objectFieldSetName{get;set;}          
    public LMS_SearchService(List <LMS_SearchService.LMS_FilterCriteria> filterCriteria,Decimal pageNo,Decimal pageSize,String sortCol,String sortDir)
    {
        this.filterCriteria=filterCriteria;
        this.pageNo=pageNo;
        this.pageSize=pageSize;
        this.sortCol=sortCol;
        this.sortDir=sortDir;
    }
    
    public  Integer getTotalRecordsCount()
    {
     
         String selectClause='select count() from ';
        String whereClause= LMS_Utility.getWhereClause(filterCriteria);
       
          if(whereClause.trim().equalsIgnoreCase('Where')){
            
            whereClause=''; 
        }
        String query = selectClause+' '+objectName+' ' + whereClause;
   				return Database.countQuery(query);
        
    }
    
    public  List<Sobject> searchRecords()
    {
        Integer skipRecords = Integer.valueOf( ( pageNo - 1 ) * pageSize );
        Integer maxRecords = Integer.valueOf( pageSize );
        String selectClause='select Id'+LMS_Utility.buildQuery(objectFieldSetName,objectName)+' from';
        String whereClause= LMS_Utility.getWhereClause(filterCriteria);
        List<Sobject> searchList=new List<Sobject>();
        
        if(whereClause.trim().equalsIgnoreCase('Where')){
            
            whereClause=''; 
        }
        String query = selectClause+' '+objectName+' ' + whereClause;
        if ( String.isNotBlank( sortCol ) ) {
            query += ' ORDER BY ' + String.escapeSingleQuotes( sortCol ) + ' ' + String.escapeSingleQuotes( sortDir );
        }
        query += ' LIMIT '+maxRecords+' ' ;
        query += ' OFFSET '+skipRecords ;
        system.debug('query'+query);
        
        searchList= Database.query(query);
        return searchList;
        
        
    }
    
    public class LMS_FilterCriteria {
        @AuraEnabled
        public String property{get;set;}
        @AuraEnabled
        public String operator{get;set;}  //equals,notEquals,lessThan,lessThanEqualTo,greaterThan,greaterThanEqualTo,contains (string only)
        @AuraEnabled
        public String value{get;set;} //String representation of value
        @AuraEnabled
        public String valueType{get;set;} //String,Integer,Date,DateTime,Decimal,Double,Long,etc. valid primitive type
        @AuraEnabled
        public String nextLogicalOperator{get;set;} //String,Integer,Date,DateTime,Decimal,Double,Long,etc. valid primitive type
        @AuraEnabled
        public Boolean ifOpeningBracketRequired{get;set;} //String,Integer,Date,DateTime,Decimal,Double,Long,etc. valid primitive type
        @AuraEnabled
        public Boolean ifClosingBracketRequired{get;set;} //String,Integer,Date,DateTime,Decimal,Double,Long,etc. valid primitive type
        
        
    }
}
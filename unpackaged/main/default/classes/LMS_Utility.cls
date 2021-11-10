public class LMS_Utility {

    
    //used to build query from field
    public static String buildQuery(String fieldSetName,String objectName)
    {
        String queryString='';
          List<Schema.FieldSetMember> fieldSetMemberList=readFieldSet(fieldSetName,objectName);
     
        for(Schema.FieldSetMember fld :fieldSetMemberList) 
        {
            
         queryString += ', ' + fld.getFieldPath();
        } 
        
        return queryString;
    }
    /**
*@description Global static method returning a where clause statment corresponding to Filter Criteria
*@example String  = LMS_Utility.getWhereClause(FilteCriteria)
*/
  public static String getWhereClause(List<LMS_SearchService.LMS_FilterCriteria> criteria) {
        String whereClause = ' where ';
      INTEGER i=0;
        if(criteria != null && criteria.size() > 0) {
            for(LMS_SearchService.LMS_FilterCriteria crt:criteria){
                
               
                
                if(String.isNotBlank(crt.valueType)){
                    if(crt.nextLogicalOperator==null || crt.nextLogicalOperator=='')
                {
                 crt.nextLogicalOperator='and';   
                }
                if(crt.ifOpeningBracketRequired!=null && crt.ifOpeningBracketRequired)
                {
                 whereClause+=' (';   
                }

                    if(crt.valueType == 'Number'){
                        Double rightValInt = Double.valueof(crt.value);
                        if(crt.operator == 'equals'){
                            whereClause = whereClause+crt.property + ' = '+ rightValInt +' ' ;
                        }else if(crt.operator == 'notEqual'){
                            whereClause = whereClause+crt.property + ' != ' + rightValInt +' ' ;
                        }else if(crt.operator == 'lessThan'){
                            whereClause = whereClause+crt.property + ' < ' + rightValInt  ;
                        }else if(crt.operator == 'greaterThan'){
                            whereClause = whereClause+crt.property + ' > ' + rightValInt  ;
                        }else if(crt.operator == 'lessOrEqual'){
                            whereClause = whereClause+crt.property + ' <= ' + rightValInt  ;
                        }else if(crt.operator == 'greaterOrEqual'){
                            whereClause = whereClause+crt.property + ' >=' +  rightValInt +' ' ;
                        }

                    }else if(crt.valueType == 'Date'){
                        Date rightValDate = Date.valueof(crt.value);
                        if(crt.operator == 'equals'){
                            whereClause = whereClause+crt.property + ' = ' + rightValDate  ;
                        }else if(crt.operator == 'notEqual'){
                            whereClause = whereClause+crt.property + ' != ' + rightValDate  ;
                        }else if(crt.operator == 'lessThan'){
                            whereClause = whereClause+crt.property + ' <= ' + rightValDate  ;
                        }else if(crt.operator == 'greaterThan'){
                            whereClause = whereClause+crt.property + ' > ' + rightValDate  ;
                        }else if(crt.operator == 'lessOrEqual'){
                            whereClause = whereClause+crt.property + ' <= ' + rightValDate  ;
                        }else if(crt.operator == 'greaterOrEqual'){
                            whereClause = whereClause+crt.property + ' >= ' + rightValDate  ;
                        }

                    }else if(crt.valueType == 'String'){
                        String leftValStr = crt.property;
                        String rightValStr = String.escapeSingleQuotes(crt.value);
                        rightValStr=rightValStr.trim();
                        if(crt.operator == 'equals'){
                            whereClause = whereClause+crt.property + ' = \'' + rightValStr +'\''  ;
                        }else if(crt.operator == 'notEqual'){
                            whereClause = whereClause + crt.property + ' != \'' + rightValStr +'\''  ;
                        }else if(crt.operator == 'contains'){
                            whereClause = whereClause+crt.property + ' like '+ '\'%' +rightValStr + '%\''  ;
                        }else if(crt.operator == 'notContain'){
                            whereClause = whereClause+'(not '+crt.property + ' like '+ '\'%' +rightValStr + '%\')'  ;
                        }else if(crt.operator == 'startsWith'){
                            whereClause = whereClause+crt.property + ' like \'' +rightValStr + '%\''  ;
                        }
                    }

                    else if(crt.valueType.equalsIgnoreCase('Boolean')){
                        String rightVal = crt.value;
                        if(crt.operator == 'equals'){
                            whereClause = whereClause+crt.property + ' = '+ String.valueOf(rightVal)  ;
                        }else{
                            whereClause = whereClause + crt.property + ' != ' + String.valueOf(rightVal)  ;

                        }

                    }

                    else if(crt.valueType.equalsIgnoreCase('Picklist')){
                        String leftValStr = crt.property;
                        String rightValStr = String.escapeSingleQuotes(crt.value);
                        if(crt.operator == 'equals'){
                            whereClause = whereClause+crt.property + ' = \'' + rightValStr +'\''  ;
                        }
                        //This is for multiselect as we need to handle includes ('values 1', 'value 2', 'value 3') like this in query
                        else if(crt.operator == 'includes'){
                            rightValStr = crt.value;
                            whereClause = whereClause + crt.property + ' includes (' + rightValStr + ') ' ;
                        }
                    }
                    if(crt.ifClosingBracketRequired!=null && crt.ifClosingBracketRequired)
                {
                 whereClause+=') ';   
                }
                    if(i!=criteria.size()-1)
                    whereClause+=' '+crt.nextLogicalOperator+' ';
                    
                }
                i++;
            }
        }

        return whereClause;
    }
    public static List<Schema.FieldSetMember> readFieldSet(String fieldSetName, String ObjectName)
{
    Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
    Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
    Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();

    //system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));

    Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);

    //List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();
    //system.debug('fieldSetMemberList ====>' + fieldSetMemberList);  
    return fieldSetObj.getFields(); 
}  
}
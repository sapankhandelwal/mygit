/*--
* @File Name          : Constants.cls
* @Summary            : Constant class for all classes,stores label,picklist valuesa and messages
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/
public class Constants {
//user Object fields
public static final String LMS_USER_OBJECTNAME='User';
public static final String LMS_USER_SEARCHFIELDSET='LMS_Search_User_Fields';

//Library Item Object fields
public static final String LMS_LIBITEM_OBJECTNAME='Library_Item__c';
public static final String LMS_LBITEM_SEARCHFIELDSET='LMS_LibraryItem_SearchFields';
    
//Library Issue Return Item Object fields
public static String LMS_LIBISSUERETURN_OBJECTNAME='Library_Issue_Ret_Item__c';
public static final String LMS_LIBISSUERETURN_SEARCHFIELDSET='LMS_Search_IssueReturn_Fields';
  
public static final String MEMBER_ISSUEDTHRESHOLD_MESSAGE='Cannot issue item,Maximum count reached for Member';

public static final String MEMBER_SINGLEITEMISSUETHRESHOLD_MESSAGE='Item already issued to Member';
        
    
    
    
}
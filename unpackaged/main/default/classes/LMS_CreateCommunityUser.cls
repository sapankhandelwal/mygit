public class LMS_CreateCommunityUser {

    public static String NEWCOMMUNITYUSERPROFILE='LMS Community User';
    public static String ERROR_MESSAGE_UserExist='User already Exist';    
    public static String ERROR_MESSAGE_NOT_COMMUNITYUSER='Logged in User is not a community user';    
    public static Id contactRecodTypeID = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('LMS_Contact').getRecordTypeId();    	//create lms community user and contact

    //create lms community user and contact that would issue items
	@auraEnabled
    public Static User insertContact(String contactJSON,String userNameSuffix){
        Contact con=(Contact)JSON.deserialize(contactJSON,Contact.class);
        con.RecordtypeId=contactRecodTypeID;
        User loggedInUser = new User();
        User u = new User();
        List<Contact> conExistList= new List<contact>();
        conExistList = [SELECT id FROM Contact WHERE Email=:con.Email Limit 1];
        if(!conExistList.isEmpty()){
            throw new AuraHandledException(ERROR_MESSAGE_UserExist);
        }
		//get community Account for Library
        con.If_LMS_User__c=true;
        try{
            insert con;
        }
        catch(Exception e)
        {
            throw new AuraHandledException(e.getMessage());

        }
        Profile p = [SELECT Id FROM Profile where name=:NEWCOMMUNITYUSERPROFILE];
        String alias = con.firstName + con.lastName;
        //Alias must be 8 characters or less
        if(alias.length() > 8) {
            alias = alias.substring(0, 8);
        }
         u.username = con.email+userNameSuffix ;
        u.lastName=con.LastName;
        u.Email=con.email;
        u.FirstName=con.FirstName;
        u.alias = alias;
        u.languagelocalekey = UserInfo.getLocale();
        u.localesidkey = UserInfo.getLocale();
        u.emailEncodingKey = 'UTF-8';
        u.timeZoneSidKey = 'America/Denver';
        u.profileId = p.Id;
        u.contactId = con.Id; 
  try{   
            insert u;
            // return u;
        }
        catch(Exception e)
        {
            throw new AuraHandledException(e.getMessage());
            
        }
        return u;
    }
}
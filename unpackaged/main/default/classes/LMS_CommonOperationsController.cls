public class LMS_CommonOperationsController {

    
    @AuraEnabled
    
    public static User getLoggedInUserDetails()
    {   
    User loggedInUser = [SELECT id,name ,ContactId,AccountId,LastLoginDate,profile.Name
                        FROM User
                        WHERE Id =: Userinfo.getUserId() LIMIT 1];
        
    return loggedInUser;
    }
}
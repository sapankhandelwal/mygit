@istest
public class LMS_CreateCommunityUser_Test {
    
@isTest static void testMethod1(){
	//Create Account and Contact
     List<Account> accList=LMS_TestUtility.createAccount(1, true);
	 List<Contact> conList=LMS_TestUtility.createContact(accList[0], 'test', 2, false);
     String contactJSON = JSON.serialize(conList[0]);
	//create lms community user and contact
    LMS_CreateCommunityUser.insertContact(contactJSON,'TODLMS');
    
    Contact con=[select id,name from Contact limit 1];
    
    system.assert(con!=null && con.Id!=null);
}
}
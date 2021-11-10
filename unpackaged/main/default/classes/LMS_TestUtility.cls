/*--
* @File Name          : LMS_TestUtility.cls
* @Summary            :  utility class for all test class forcreating data
* @Created On         : 02 Oct 2020
* @Created By         : sapan Khandelwal
* @Modification Log   : (Name  -  Date  -  Issue  -  Change Summary)
========================================================================
========================================================================
--*/
@isTest
public class LMS_TestUtility {
    
     public static List<Library_Item_Rating__c> createRatings(Contact con,Library_Item__c item,Integer noOfrecords,Boolean isInsert)
    {
        List<Library_Item_Rating__c> itemRating=new List<Library_Item_Rating__c>();
        
        for(Integer i=0;i<noOfrecords;i++)
        {
            itemRating.add(new Library_Item_Rating__c( Library_Item__c=item.id,Issued_To__c=con.id,Rate_Points__c='5'));
            
            
            
        }
        if(isInsert)
        {
            insert itemRating;
        }    
        return itemRating;
    }
    public static List<Library_Item__c> createLibraryItems(Integer noOfrecords,boolean isInsert)
    {
        List<Library_Item__c> itemList=new List<Library_Item__c>();
        
        for(Integer i=0;i<noOfrecords;i++)
        {
            itemList.add(new Library_Item__c( name='Test Book'+i,ISBN_No__c='123456789012'+i,Type__c='Book',Publishing_Date__c=System.Today()-i,Total_Copies__c=10,category__c='Fiction',Item_Price__c=100));
            
            
            
        }
        if(isInsert)
        {
            insert itemList;
        }    
        return itemList;
    }
    public static List<Library_Issue_Ret_Item__c> createLibrary_Issue_Items(Library_Item__c item,Contact con,Integer noOfrecords,boolean isInsert)
    {
        List<Library_Issue_Ret_Item__c> newList=new List<Library_Issue_Ret_Item__c>();
        
        for(Integer i=0;i<noOfrecords;i++)
        {
            
            Library_Issue_Ret_Item__c newRecord=new Library_Issue_Ret_Item__c();
            newRecord.is_Issued__c=true;
            newRecord.Issue_Date__c=system.today();
            newRecord.Library_Item__c=item.Id;
            newRecord.Issued_To__c=con.id;
            newRecord.Status__c='Issued';
            
            newRecord.Issued_By__c=Userinfo.getUserId();
            
            newRecord.Expected_Return_Date__c=system.today()+3;
            newList.add(newRecord);
            
            
            
        }
        if(isInsert)
        {
            insert newList;
        }    
        return newList;
    }
      public static List<Library_Issue_Ret_Item__c> createLibrary_Issue_Items(List<Library_Item__c> item,Contact con,Integer noOfrecords,boolean isInsert)
    {
        List<Library_Issue_Ret_Item__c> newList=new List<Library_Issue_Ret_Item__c>();
        
        for(Integer i=0;i<noOfrecords;i++)
        {
            
            Library_Issue_Ret_Item__c newRecord=new Library_Issue_Ret_Item__c();
            newRecord.is_Issued__c=true;
            newRecord.Issue_Date__c=system.today();
            newRecord.Library_Item__c=item[i].Id;
            newRecord.Issued_To__c=con.id;
            newRecord.Status__c='Issued';
            
            newRecord.Issued_By__c=Userinfo.getUserId();
            
            newRecord.Expected_Return_Date__c=system.today()+3;
            newList.add(newRecord);
            
            
            
        }
        if(isInsert)
        {
            insert newList;
        }    
        return newList;
    }
    public static List<Account> createAccount(Integer noOfrecords,boolean isInsert)
    {
        List<Account> accList=new List<Account>();
        for(Integer i=0;i<noOfrecords;i++)
        {
            account acc= new Account();
            acc.BillingStreet='Test'+i;
            acc.BillingCity='New York City';
            acc.BillingCountry='United States';
            acc.BillingPostalCode='10021';
            acc.BillingState='New York';
            acc.Name='Testing'+i;
            accList.add(acc);
            
        } 
        if(isInsert)
        {
            insert accList;
        }
        return accList;
    }
    public static List<User> createCommunityUser(String userName,Profile p,Contact con,Integer noOfrecords,boolean isInsert)
    {
        List<User> userList=new List<User>();
        for(Integer i=0;i<noOfrecords;i++)
        {
            
            String str = string.valueof(Math.abs(Crypto.getRandomLong()));
            String randomNumber = str.substring(0, 5);
            User us= new User(alias = 'test123', email=userName+i+'@noemail.com',
                              emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                              localesidkey='en_US', profileid = p.Id, country='United States',IsActive =true,contactId=con.id,
                              timezonesidkey='America/Los_Angeles', username=userName+i+randomNumber+'@noemail.com');
            userList.add(us);
            
        } 
        if(isInsert)
        {
            insert userList;
        }
        return userList;
    }    
    public static List<User> createUser(String userName,Profile p,UserRole r,Integer noOfrecords,boolean isInsert)
    {
        List<User> userList=new List<User>();
        for(Integer i=0;i<noOfrecords;i++)
        {
            String str = string.valueof(Math.abs(Crypto.getRandomLong()));
            String randomNumber = str.substring(0, 5);
            
            User us= new User(alias = 'test123', email=userName+'_'+i+'@noemail.com',
                              emailencodingkey='UTF-8', lastname='TestingTOD'+i, languagelocalekey='en_US',
                              localesidkey='en_US', profileid = p.id, country='United States',IsActive =true,
                              timezonesidkey='America/Los_Angeles',userRoleid=r.id, username=userName+i+randomNumber+'@noemail.com');
            userList.add(us);
            
        } 
        if(isInsert)
        {
            insert userList;
        }
        return userList;
    }
    public static List<Contact> createContact(Account acc,String lastName,Integer noOfrecords,boolean isInsert)
    {
        List<Contact> contactList=new List<Contact>();
        for(Integer i=0;i<noOfrecords;i++)
        {
            Contact con=new Contact();
            con.Firstname='Test'+i;
            con.LastName=lastName+i;
            con.AccountId=acc.Id;
            con.MailingStreet='Test'+i;
            con.MailingCity='New York City';
            con.MailingCountry='United States';
            con.MailingPostalCode='10021';
            con.MailingState='New York';
            con.Email=con.Firstname+'@tod.com';
            con.If_LMS_User__c=true;
            contactList.add(con);
            
        } 
        if(isInsert)
        {
            insert contactList;
        }
        return contactList;
    }
    
    
}
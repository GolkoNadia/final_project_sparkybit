@isTest
public class CreateUserControllerTest {
    
    @isTest
    static void createUserTest(){
        testSetUp.createData();               
        List<Region__c> region=[SELECT Id, Name, Rate__c from Region__c limit 1];        
        User__c new_user=new User__c (Name='testManag', First_name__c = 'testManag', Password__c='abc', 
                                      region__c=region[0].name,  token__c='d', regionId__c=region[0].id, 
                                      city__c=region[0].name, Gas__c=0,Water__c=0, Electricity__c=0, isManager__c=false, 
                                      regionRate__c=1, isBring__c=false, Available_money__c=10);
        
        CreateUserController contrl=new CreateUserController();
        contrl.user=new_user;
        contrl.createUser(false);
        System.assertEquals(0, new_user.Debt__c);        
    }
    
    @isTest
    static void SaveUserTest(){
        testSetUp.createData();               
        List<Region__c> region=[SELECT Id, Name, Rate__c from Region__c limit 1];        
        User__c new_user=new User__c (Name='testManag', First_name__c = 'testManag', Password__c='abc', 
                                      region__c=region[0].name,  token__c='d', regionId__c=region[0].id, 
                                      city__c=region[0].name, Gas__c=0,Water__c=0, Electricity__c=0, isManager__c=false, 
                                      regionRate__c=1, isBring__c=false, Available_money__c=10);
        
        CreateUserController contrl=new CreateUserController();
        contrl.SaveUser();        
        contrl.user=new_user;
        contrl.SaveUser();
        System.assertEquals(0,new_user.Debt__c);
    }
    
    @isTest
    static void SaveManagerTest(){
        testSetUp.createData();               
        List<Region__c> reg=[SELECT Id, Name, Rate__c from Region__c limit 1];        
        User__c new_user=new User__c (Name='testManag', First_name__c = 'testManag', Password__c='abc', 
                                      region__c=reg[0].name,  token__c='d', regionId__c=reg[0].id, 
                                      city__c=reg[0].name, Gas__c=0,Water__c=0, Electricity__c=0, 
                                      regionRate__c=1, isBring__c=false, Available_money__c=10);
        
        CreateUserController contrl=new CreateUserController();
        contrl.SaveManager();        
        contrl.user=new_user;
        contrl.SaveManager();
        System.assertEquals(true,new_user.isManager__c);
    }    
}
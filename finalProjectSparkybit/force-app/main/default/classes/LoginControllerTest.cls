@isTest
public class LoginControllerTest {
    
    @isTest
    static void ShowUser_test() {
        testSetUp.createData();       
        List<Region__c> reg=[SELECT Id, Name, Rate__c from Region__c limit 1];        
        ChangeString changeStr=new ChangeString();        
        List<User__c> new_users=new List <User__c>();
        new_users.add(new User__c(Name='user', First_name__c = 'test', Password__c=changeStr.hashing('abc'), 
                                  region__c=reg[0].name,  token__c='d', regionId__c=reg[0].id, 
                                  city__c=reg[0].name, Gas__c=0,Water__c=0, Electricity__c=0, isManager__c=false, 
                                  regionRate__c=1, isBring__c=false, Available_money__c=10));
        new_users.add(new User__c(Name='manager', First_name__c = 'test', Password__c=changeStr.hashing('abc'), 
                                  region__c=reg[0].name,  token__c='d', regionId__c=reg[0].id, 
                                  city__c=reg[0].name, Gas__c=0,Water__c=0, Electricity__c=0, isManager__c=true, 
                                  regionRate__c=1, isBring__c=false, Available_money__c=10));        
        insert new_users;
        
        Test.setCurrentPage(Page.LoginPage);        
        LoginController ctrl=new LoginController ();        
        ctrl.InputPassword='';
        ctrl.inputName='';
        ctrl.showUser();
        
        ctrl.InputPassword='abc';
        ctrl.inputName=new_users[0].name;
        ctrl.showUser();
        string nextPage=ctrl.ShowUser().getUrl();
        System.assertEquals('/apex/CabinetUserPage?id='+new_users[0].Id, nextPage);
        
        ctrl.InputPassword='abc';
        ctrl.inputName=new_users[1].name;
        ctrl.showUser();
        string nextPage1=ctrl.ShowUser().getUrl();
        System.assertEquals('/apex/CabinetManagerPage?id='+new_users[1].Id, nextPage1);
    }    
}
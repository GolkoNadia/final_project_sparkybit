@isTest
public class InfoAboutUserControllerTest {
    
    @isTest
    static void getUserInfo_test() {
        testSetUp.createData();       
        List<User__c> users=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                             Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                             FROM User__c limit 1];
        
        Test.setCurrentPage(Page.UserInfoPage);
        ApexPages.currentPage().getParameters().put('user_id',users[0].id);
        
        InfoAboutUserController ctrl=new InfoAboutUserController();
        ctrl.getUserInfo();
        System.assertEquals('testUser0', users[0].name);
    }
    
    @isTest
    static void saveNewDebt_test() {
        testSetUp.createData();       
        List<User__c> users=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                             Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                             FROM User__c ];

        Test.setCurrentPage(Page.UserInfoPage);
        ApexPages.currentPage().getParameters().put('user_id',users[0].id);
        
        InfoAboutUserController ctrl=new InfoAboutUserController();
        ctrl.input_new_doubt=3;
        ctrl.saveNewDebt();
        users[0].debt__c=ctrl.input_new_doubt;

        System.assertEquals(users[0].debt__c,3);        
    }
    
    @isTest
    static void getAllPayments_test() {
        testSetUp.createData();       
        List<User__c> users=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                             Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                             FROM User__c ];        
        List<Payment__c> lst_payments=[SELECT Id, Name, Amount__c, Debt__c FROM Payment__c];

        Test.setCurrentPage(Page.cabinetUserPage);
        ApexPages.currentPage().getParameters().put('id',users[0].id);
                
        InfoAboutUserController contrl=new InfoAboutUserController();
        Cookie cook = new Cookie('myuser_token', 'bla', null, -1, false);
        ApexPages.currentPage().setCookies(new Cookie[] {cook});
        contrl.getAllPayments();
        
        ChangeString changeStr=new ChangeString();
        String encryptToken=changeStr.encriptString(users[0].Token__c);   
        cook = new Cookie('myuser_token', encryptToken, null, -1, false);
        ApexPages.currentPage().setCookies(new Cookie[] {cook});        
        contrl.getAllPayments();        
        
        System.assertEquals(lst_payments[0].amount__c,10);
        
        ApexPages.currentPage().getParameters().put('user_id',users[1].id);
        contrl.getAllPayments();        

        System.assertEquals(lst_payments[1].amount__c,20);        
    }
    
    @isTest
    static void returnToCabinet_test() {
        testSetUp.createData();        
        List<User__c> users=[select id, isManager__c, name from User__c];
        
        InfoAboutUserController ctrl=new InfoAboutUserController();
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        string nextPage=ctrl.returnToCabinet().getUrl();
        
        System.assertEquals('/apex/cabinetUserPage?id='+users[0].id, nextPage);
        
        ApexPages.currentPage().getParameters().put('id',users[3].id);
        string nextPage1=ctrl.returnToCabinet().getUrl();
        
        System.assertEquals('/apex/cabinetManagerPage?id='+users[3].id, nextPage1);
    }    
}
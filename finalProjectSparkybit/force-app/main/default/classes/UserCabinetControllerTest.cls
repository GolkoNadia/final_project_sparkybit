@isTest
public class UserCabinetControllerTest {
    
    @isTest
    static void PaymentCommunal_test() {
        testSetUp.createData();        
        List<User__c> users=[select id, isManager__c, name from User__c];
        
        UserCabinetController ctrl=new UserCabinetController ();
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        string nextPage=ctrl.PaymentCommunal().getUrl();
        System.assertEquals('/apex/paymentPage?id='+users[0].id, nextPage);        
    }
    
    @isTest
    static void send_message_to_manager_test() {
        testSetUp.createData();        
        List<User__c> users=[select id, isManager__c, name from User__c];
        
        UserCabinetController ctrl=new UserCabinetController ();
        ApexPages.currentPage() .getParameters().put('id',users[0].id);
        string nextPage=ctrl.sendMessageToManager().getUrl();
        System.assertEquals('/apex/sentMessagePage?id='+users[0].id, nextPage);
    }
    
    @isTest
    static void bringMeters_test() {
        testSetUp.createData();        
        List<User__c> users=[select id, isManager__c, name from User__c];
        
        UserCabinetController ctrl=new UserCabinetController ();
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        string nextPage=ctrl.bringMeters().getUrl();
        System.assertEquals('/apex/bringMeterPage?id='+users[0].id, nextPage);
    }
    
    @isTest
    static void getUserCabinet_test() {
        testSetUp.createData();       
        List<User__c> users=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                             Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                             FROM User__c limit 1];
        
        Test.setCurrentPage(Page.cabinetUserPage);
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        
        UserCabinetController contrl=new UserCabinetController ();        
        Cookie cook = new Cookie('myuser_token', 'bla', null, -1, false);
        ApexPages.currentPage().setCookies(new Cookie[] {cook});
        contrl.getUserCabinet();
        
        ChangeString changeStr=new ChangeString();
        String encryptToken=changeStr.encriptString(users[0].Token__c);   
        cook = new Cookie('myuser_token', encryptToken, null, -1, false);
        ApexPages.currentPage().setCookies(new Cookie[] {cook});        
        contrl.getUserCabinet();        
        
        System.assertEquals(users[0].name,'testUser0');
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
        
        UserCabinetController contrl=new UserCabinetController ();
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
    static void changeAddress_test() {
        testSetUp.createData();       
        List<User__c> users=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                             Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                             FROM User__c];
        
        Test.setCurrentPage(Page.CabinetUserPage);
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        
        UserCabinetController ctrl=new UserCabinetController();
        ctrl.user=users[1];
        ctrl.changeAddress();        

        System.assertEquals('Lviv', users[0].region__c);
        
        ApexPages.currentPage().getParameters().put('id',users[1].id);        
        ctrl.user=users[0];
        ctrl.changeAddress();

        System.assertEquals('Kyiv', users[1].region__c);        
    }
    
    @isTest
    static void exit_test() {
        UserCabinetController ctrl=new UserCabinetController();        
        string nextPage=ctrl.exit().getUrl();
        System.assertEquals('/apex/WelcomePage', nextPage);
    }
}
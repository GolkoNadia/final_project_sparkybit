@isTest
public class PaymentForMeterReadingsControllerTest {

    @isTest
    static void payDebt_Test(){
        testSetUp.createData();               
        List<Region__c> reg=[SELECT Id, Name, Rate__c from Region__c limit 1];        
        User__c new_user=new User__c (Name='testManag', First_name__c = 'testManag', Password__c='abc', 
                                      region__c=reg[0].name,  token__c='d', regionId__c=reg[0].id, 
                                      city__c=reg[0].name, Gas__c=0,Water__c=0, Electricity__c=0, 
                                      regionRate__c=1, isBring__c=false, Available_money__c=10, Debt__c=0);        
        insert new_user;
        
        Test.setCurrentPage(Page.paymentPage);
        ApexPages.currentPage().getParameters().put('id',new_user.id);
        
        PaymentForMeterReadingsController ctrl=new PaymentForMeterReadingsController();
        ctrl.inputAmount=15;
        ctrl.payDebt();        
        ctrl.inputAmount=5;
        ctrl.payDebt();
        
        Payment__c pays=[select id, name, userid__c,  amount__c from Payment__c where userId__c=:new_user.id];        
        System.assertEquals(5, pays.amount__c);        
    }
    
    @isTest
    static void returnToCabinet_test() {
        testSetUp.createData();        
        List<User__c> users=[select id, isManager__c, name from User__c];
        
        PaymentForMeterReadingsController ctrl=new PaymentForMeterReadingsController();        
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        string nextPage=ctrl.returnToCabinet().getUrl();
        System.assertEquals('/apex/cabinetUserPage?id='+users[0].id, nextPage);
        
        ApexPages.currentPage().getParameters().put('id',users[3].id);
        string nextPage1=ctrl.returnToCabinet().getUrl();
        System.assertEquals('/apex/cabinetManagerPage?id='+users[3].id, nextPage1);
    }
    
    @isTest
    static void getUserCabinet_test() {
        testSetUp.createData();       
        List<User__c> users=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                             Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                             FROM User__c limit 1];
        
        Test.setCurrentPage(Page.cabinetUserPage);
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        
        PaymentForMeterReadingsController contrl=new PaymentForMeterReadingsController();
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
}
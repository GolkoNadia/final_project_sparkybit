@isTest
public class BringMettersControllerTest {
    
    @isTest
    static void saveMetersTest(){
        testSetUp.createData();       
        List<User__c> users=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                             Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                             FROM User__c ];
        
        Test.setCurrentPage(Page.bringMeterPage);
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        
        BringMettersController ctrl=new BringMettersController();
        ctrl.inputElectricity=2;
        ctrl.inputGas=1;
        ctrl.inputWater=2;
        ctrl.saveMeters();
        
        string nextPage=ctrl.saveMeters().getUrl();
        System.assertEquals('/apex/CabinetUserPage?id='+users[0].id, nextPage);        
    }
    
    @isTest
    static void returnToCabinet_test() {
        testSetUp.createData();        
        List<User__c> users=[select id, isManager__c, name from User__c];
        
        BringMettersController ctrl=new BringMettersController();
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        string nextPage=ctrl.returnToCabinet().getUrl();
        System.assertEquals('/apex/cabinetUserPage?id='+users[0].id, nextPage);
        
        ApexPages.currentPage().getParameters().put('id',users[3].id);
        string nextPage1=ctrl.returnToCabinet().getUrl();
        System.assertEquals('/apex/cabinetManagerPage?id='+users[3].id, nextPage1);
    }
}
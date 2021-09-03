@isTest
public class MessageToManagerControllerTest {
    
    @isTest
    static void sendMessage_test() {
        testSetUp.createData();        
        List<User__c> users=[select id, isManager__c, name from User__c];
        
        MessageToManagerController ctrl=new MessageToManagerController();
        ctrl.inputMessage='abc';
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        string nextPage=ctrl.sendMessage().getUrl();

        System.assertEquals('/apex/cabinetUserPage?id='+users[0].id, nextPage);
    }
}
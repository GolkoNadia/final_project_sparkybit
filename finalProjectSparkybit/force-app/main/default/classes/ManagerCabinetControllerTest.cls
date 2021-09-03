@isTest
public class ManagerCabinetControllerTest {
    
    @isTest
    static void getUserCabinet_test() {
        testSetUp.createData();       
        List<User__c> users=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                             Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                             FROM User__c limit 1];
        
        Test.setCurrentPage(Page.cabinetUserPage);
        ApexPages.currentPage().getParameters().put('id',users[0].id);
        
        ManagerCabinetController contrl=new ManagerCabinetController ();        
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
    static void changeRate_test() {
        testSetUp.createData();       
        User__c manager= [SELECT Id, Name, Region__c, regionId__c, regionRate__c, isManager__c
                          FROM User__c  limit 1];                  
        Region__c region=[SELECT Id, Name, Rate__c from Region__c limit 1];        
        List<User__c> allUser=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                               Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                               FROM User__c ];        
        
        Test.setCurrentPage(Page.CabinetManagerPage);
        ApexPages.currentPage().getParameters().put('id',manager.id);
        
        ManagerCabinetController ctrl=new ManagerCabinetController ();        
        ctrl.changeRate();        
    }    
    
    @isTest
    static void getAllUser_test() {
        testSetUp.createData();       
        List<User__c> manager=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                               Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                               FROM User__c ];
        List<User__c> users=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                             Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                             FROM User__c ];
        
        Test.setCurrentPage(Page.cabinetManagerPage);
        
        ManagerCabinetController contrl=new ManagerCabinetController ();
        ApexPages.currentPage().getParameters().put('id',manager[2].id);
        Cookie cook = new Cookie('myuser_token', 'bla', null, -1, false);
        ApexPages.currentPage().setCookies(new Cookie[] {cook});
        contrl.getAllUser();
        
        ChangeString changeStr=new ChangeString();
        String encryptToken=changeStr.encriptString(manager[0].Token__c);   
        cook = new Cookie('myuser_token', encryptToken, null, -1, false);
        ApexPages.currentPage().setCookies(new Cookie[] {cook});
        contrl.getAllUser();  
        
        ApexPages.currentPage().getParameters().put('id',manager[2].id);
        contrl.inputLName=users[0].name;
        contrl.inputFName=users[0].first_name__c;
        contrl.getAllUser();            
    }
    
    @isTest
    static void showInfoAboutUser_test() {
        testSetUp.createData();       
        List<User__c> users=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                             Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                             FROM User__c ];
        
        Test.setCurrentPage(Page.infoAboutUserPage);
        ApexPages.currentPage().getParameters().put('id',users[3].id);
        ApexPages.currentPage().getParameters().put('user_id',users[1].id);
        
        ManagerCabinetController ctrl=new ManagerCabinetController ();
        ctrl.showInfoAboutUser();        
        
        ctrl.inputFName=users[1].first_name__c;
        ctrl.inputLName=users[1].name;        
        ctrl.showInfoAboutUser();
        string nextPage=ctrl.showInfoAboutUser().getUrl();
        
        System.assertEquals('/apex/infoAboutUserPage?id='+users[3].id+'&user_id='+users[1].Id, nextPage);
    }
    
    @isTest
    static void exit_test() {
        ManagerCabinetController ctrl=new ManagerCabinetController ();        
        string nextPage=ctrl.exit().getUrl();
        
        System.assertEquals('/apex/WelcomePage', nextPage);        
    }
    
    @isTest
    static void showAllUserOfRegion_test() {
        ManagerCabinetController ctrl=new ManagerCabinetController ();
        ctrl.showAllUserOfRegion();        
    }    
}
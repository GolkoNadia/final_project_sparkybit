@isTest
public class WelcomeControllerTest {
    
    @isTest
    static void login_test() {
        WelcomeController ctrl=new WelcomeController();
        String nextPage=ctrl.Login().getUrl();        
        System.assertEquals('/apex/LoginPage',nextPage);
    }
    
    @isTest
    static void signUpAsUser_test() {
        WelcomeController ctrl=new WelcomeController();
        String nextPage=ctrl.signUpAsUser().getUrl();
        System.assertEquals('/apex/RegistrationUserPage',nextPage);
    }
    
    @isTest
    static void signUpAsManager_test() {
        PageReference p=Page.RegistrationUserPage;
        Test.setCurrentPage(p);
        WelcomeController ctrl=new WelcomeController();
        String nextPage=ctrl.signUpAsManager().getUrl();        
        System.assertEquals('/apex/RegistrationManagerPage',nextPage);
    }
}
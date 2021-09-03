public class WelcomeController {
    
    public PageReference Login()
    {
        PageReference pgref = new PageReference('/apex/LoginPage');
        pgref.setRedirect(true);       
        return pgref;
    }
    
    public PageReference signUpAsUser()
    {
        PageReference pgref = new PageReference('/apex/RegistrationUserPage');
        pgref.setRedirect(true);       
        return pgref;
    }
    
    public PageReference signUpAsManager()
    {
        PageReference pgref = new PageReference('/apex/RegistrationManagerPage');
        pgref.setRedirect(true);       
        return pgref;
    }   
}
public class LoginController {
    
    public String inputName {get;set;}
    public String inputPassword {get;set;}
    public List<User__c> myUsers{get;set;}   
    
    public LoginController(){
        myUsers=new List<User__c>();        
    }
    
    public PageReference showUser(){
        ChangeString changeStr=new ChangeString();            
        string hashInputPassword=changeStr.hashing(inputPassword);
        myUsers=[SELECT Id, Name, First_name__c, Password__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                 Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c 
                 FROM User__c 
                 WHERE Name=: inputName AND Password__c =: hashInputPassword limit 1];   
        
        if(myUsers.size()>0){
            PageReference pgref=new PageReference('');
            if(myUsers[0].isManager__c==true){
                pgref = new PageReference('/apex/CabinetManagerPage?id='+myUsers[0].Id);                              
            }
            else{
                pgref = new PageReference('/apex/CabinetUserPage?id='+myUsers[0].Id);                                
            }
            pgref.setRedirect(true);           
            String encryptToken=changeStr.encriptString(myUsers[0].Token__c);   
            Cookie cook = new Cookie('myuser_token', encryptToken, null, -1, false);
            pgref.setCookies(new Cookie[] {cook});            
            return pgref;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Sorry, but user doesn\'t exist'));
            return null;
        }
    }    
}
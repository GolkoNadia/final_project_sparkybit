public class CreateUserController {
    
    public User__c user {get;set;}
    
    public CreateUserController(){
        user=new User__c();
    }
    
    public User__c createUser(boolean isManager){    
        ChangeString changeStr=new ChangeString();
        user.Token__c=user.Name+user.First_name__c+'123';
        user.Password__c=changeStr.Hashing(user.Password__c);
        user.isManager__c=isManager;
        
        Region__c reg=[SELECT Name, Rate__c FROM Region__c where name =: user.Region__c limit 1];
        user.RegionId__c=reg.Id;
        user.regionRate__c=reg.Rate__c;
        
        if(isManager==false){
            user.Debt__c=0;
            user.Gas__c=0;
            user.Water__c=0;
            user.Electricity__c=0;
            user.isBring__c=false;
        }        
        insert user;
        return user;
    }
    
    public PageReference SaveUser(){        
        if(user.Name==null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please input Name of user'));
            return null;
        }
        else{
            user=createUser(false);
            
            /*            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
message.toAddresses = new String[] { 'nadia.golko@sparkybit.com'};
message.subject = 'NEW USER';
message.plainTextBody = 'You have new user';
Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

*/            
            PageReference pgref = new PageReference('/apex/CabinetUserPage?id='+user.Id);       
            pgref.setRedirect(true);   
            ChangeString changeStr=new ChangeString();
            
            String encryptToken=changeStr.encriptString(user.Token__c);   
            Cookie cook = new Cookie('myuser_token', encryptToken, null, -1, false);
            pgref.setCookies(new Cookie[] {cook});
            return pgref;            
        }
    }
    
    public PageReference SaveManager(){        
        if(user.Name==null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please input Name of user'));
            return null;
        }
        else{           
            user=createUser(true);            
            //            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Your request was sent. You get email with result.'));
            PageReference pgref = new PageReference('/apex/CabinetManagerPage?id='+user.Id);       
            pgref.setRedirect(true);   
            
            ChangeString changeStr=new ChangeString();            
            String encryptToken=changeStr.encriptString(user.Token__c);   
            Cookie cook = new Cookie('myuser_token', encryptToken, null, -1, false);
            pgref.setCookies(new Cookie[] {cook});
            return pgref;                        
        }
    }
}
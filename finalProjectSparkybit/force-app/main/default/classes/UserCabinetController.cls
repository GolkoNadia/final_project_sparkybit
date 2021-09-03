public class UserCabinetController {
    
    public User__c user {get;set;}
    public String userId {get;set;}
    public String data {get;set;}
    
    public UserCabinetController(){
        user=new User__c();
    }
    
    public User__c getUserCabinet() {
        userid = ApexPages.currentPage().getParameters().get('Id');
        data = apexpages.currentPage().getCookies().get('myuser_token').getValue();
        User__c user= [SELECT Id, Name, First_name__c, Password__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                    Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, regionRate__c, isBring__c 
                    FROM User__c  
                    WHERE id=:userid];                
        
        ChangeString changeStr=new ChangeString();            
        if(changeStr.decryptString(data)==user.Token__c){             
            return user;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Not correct url'));
            return null;            
        }
    }
    
    public PageReference bringMeters(){    
        userid = ApexPages.currentPage().getParameters().get('Id');        
        PageReference pgref=new PageReference('/apex/bringMeterPage?id='+userId);     
        pgref.setRedirect(true);           
        return pgref;
    }
    
    public PageReference paymentCommunal(){
        userid = ApexPages.currentPage().getParameters().get('Id');        
        PageReference pgref=new PageReference('/apex/paymentPage?id='+userId);     
        pgref.setRedirect(true);           
        return pgref;
    }
    
    public PageReference sendMessageToManager(){
        userid = ApexPages.currentPage().getParameters().get('Id');
        
        PageReference pgref=new PageReference('/apex/sentMessagePage?id='+userId);           
        pgref.setRedirect(true);         
        return pgref;        
    }    
    
    public void changeAddress(){
        userid = ApexPages.currentPage().getParameters().get('Id');
        User__c us= [SELECT Id, Name, Region__c,  regionId__c, City__c, regionRate__c, debt__c
                     FROM User__c  
                     WHERE id=:userid];   
       
        if(us.Debt__c==0){
            us.Region__c=user.Region__c;
            us.City__c=user.City__c;
            region__c reg=[SELECT id, Name, Rate__c FROM Region__c where name=:user.Region__c];
            us.RegionId__c=reg.Id;
            us.regionRate__c=reg.Rate__c;
            update us;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'If you want change address, you will pay debt!'));
        }  
    }
    
    public List<Payment__c> getAllPayments() {
        string useridfromurl = ApexPages.currentPage().getParameters().get('Id');
        string useridfromurl2 = ApexPages.currentPage().getParameters().get('user_Id');
        data = apexpages.currentPage().getCookies().get('myuser_token').getValue();
        user__c user=[select id, name, token__c from User__c where id=: useridfromurl];
        ChangeString changeStr=new ChangeString();            
        
        if(changeStr.decryptString(data)==user.Token__c){           
            if(useridfromurl2==null){
                List<Payment__c> lst_payments= [SELECT Id, Name, Debt__c, Amount__c, userid__c
                                                FROM Payment__c  
                                                WHERE userId__c=:useridfromurl
                                                order by createdDate DESC];       
                return lst_payments;
            }
            else{
                List<Payment__c> lst_payments= [SELECT Id, Name, Debt__c, Amount__c, userid__c
                                                FROM Payment__c  
                                                WHERE userId__c=:useridfromurl2
                                                order by createdDate DESC];       
                return lst_payments;   
            }
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Not correct url'));
            return null;            
        }
    }
    
    public pageReference exit(){
        PageReference pgref=new PageReference('/apex/WelcomePage');
        pgref.setRedirect(true); 
        return pgref;
    }
}
public class PaymentForMeterReadingsController {
    
    public String userId {get;set;}
    public String data {get;set;}
    public Integer inputAmount {get;set;}
    
    public User__c getUserCabinet() {
        userid = ApexPages.currentPage().getParameters().get('Id');
        data = apexpages.currentPage().getCookies().get('myuser_token').getValue();
        User__c u= [SELECT Id, Name, First_name__c, Password__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                    Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, regionRate__c, isBring__c 
                    FROM User__c  
                    WHERE id=:userid];                
        
        ChangeString changeStr=new ChangeString();            
        if(changeStr.decryptString(data)==u.Token__c){             
            return u;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Not correct url'));
            return null;            
        }
    }
    
    public PageReference payDebt() {
        userid = ApexPages.currentPage().getParameters().get('Id');
        User__c user= [SELECT Id, Name, First_name__c, Password__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c 
                       FROM User__c  
                       WHERE id=:userid]; 
        
        if(inputAmount<user.Available_money__c){
            DateTime todaysDate = System.today();
            String todaysDateStr = todaysDate.format('yyyy-MM-dd');            
            Payment__c p=new Payment__c();
            p.Name='payment'+todaysDateStr;
            p.Debt__c=user.Debt__c;
            p.UserId__c=user.Id;
            p.Amount__c=inputAmount;            
            insert p;
            
            user.Debt__c=user.Debt__c-inputAmount;
            user.Available_money__c=user.Available_money__c-inputAmount;
            update user;            
            
            PageReference pgref=new PageReference('/apex/CabinetUserPage?id='+userId);   
            pgref.setRedirect(true); 
            
            return pgref;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Not enough money'));
            return null;                        
        }
    }
    
    public pageReference returnToCabinet(){
        userid = ApexPages.currentPage().getParameters().get('Id');
        User__c user=[select id, isManager__c from User__c where id=:userid];
        PageReference pgref=new PageReference('');
        
        if(user.isManager__c==false){
            pgref=new PageReference('/apex/cabinetUserPage?id='+userId);   
        }
        else{
            pgref=new PageReference('/apex/cabinetManagerPage?id='+userId);               
        }
        pgref.setRedirect(true); 
        
        return pgref;        
    }       
}
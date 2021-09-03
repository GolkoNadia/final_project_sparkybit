public class BringMettersController {
    
    public String userId {get;set;}
    public Integer inputGas {get;set;}
    public Integer inputElectricity {get;set;}
    public Integer inputWater {get;set;}
        
    public PageReference saveMeters() {
        userid = ApexPages.currentPage().getParameters().get('Id');
        User__c user= [SELECT Id, Name, First_name__c, Password__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                    Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, RegionRate__c 
                    FROM User__c  
                    WHERE id=:userid]; 
        
        user.Gas__c=inputGas;
        user.Electricity__c=inputElectricity;
        user.Water__c=inputWater;        
        user.debt__c = user.Debt__c+(inputGas+ inputElectricity+inputWater) *user.RegionRate__c* 10;
        user.isBring__c=true;
        
        update user;
        
        PageReference pgref=new PageReference('/apex/CabinetUserPage?id='+userid);           
        pgref.setRedirect(true); 
        
        return pgref;        
    }
    
    public pageReference returnToCabinet(){
        userid = ApexPages.currentPage().getParameters().get('Id');
        User__c user=[SELECT id, isManager__c FROM User__c WHERE id=:userid];
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
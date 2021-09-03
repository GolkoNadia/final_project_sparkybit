public class ManagerCabinetController {
    
    public List<User__c> myUsers{get;set;}       
    public String userId {get;set;}
    public String data {get;set;}
    public String inputFName {get;set;}
    public String inputLName {get;set;}
    public Double inputRegionRate {get;set;}
    public Boolean showUsers {get;set;}

    
    public ManagerCabinetController(){
        myUsers=new List<User__c>();        
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
    
    public void changeRate(){
        userid = ApexPages.currentPage().getParameters().get('Id');        
        User__c manager= [SELECT Id, Name, Region__c, Token__c, regionId__c
                        FROM User__c  
                        WHERE id=:userid];          
        Region__c region=[SELECT Id, Name, Rate__c from Region__c where id=:manager.RegionId__c];        
        region.Rate__c=inputRegionRate;
        update region;
        manager.regionRate__c=inputRegionRate;
        update manager;
        
        List<User__c> allUsers= [SELECT Id, Name, Region__c, regionId__c, regionRate__c
                                FROM User__c  
                                WHERE regionId__c=:region.Id];
        
        for(User__c u: allUsers){
            u.regionRate__c=inputRegionRate;
        }
        update allUsers;
    }

    public void showAllUserOfRegion(){
        showUsers=true;
    }    
    
    public List<User__c> getAllUser() {
        userid = ApexPages.currentPage().getParameters().get('Id');
        data = apexpages.currentPage().getCookies().get('myuser_token').getValue();
        User__c manager= [SELECT Id, Name, Region__c, Token__c
                        FROM User__c  
                        WHERE id=:userid];          
        ChangeString changeStr=new ChangeString();            
        
        if(changeStr.decryptString(data)==manager.Token__c){           
            if(inputFname==null || inputLname==null){
                List<User__c> lst_u= [SELECT Id, Name, First_name__c, Region__c, City__c, RegionId__c,  Debt__c, Gas__c, Water__c, Electricity__c, regionRate__c, isBring__c 
                                      FROM User__c  
                                      WHERE region__c=:manager.region__c ANd isManager__c=:false];       
                return lst_u;                
            }else{
                List<User__c> lst_u= [SELECT Id, Name, First_name__c, Region__c, City__c, RegionId__c,  Debt__c, Gas__c, Water__c, Electricity__c, regionRate__c, isBring__c 
                                      FROM User__c  
                                      WHERE region__c=:manager.region__c ANd isManager__c=:false and Name=:inputLname And First_name__c=:inputFname limit 1];
                return lst_u;
            }
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Not correct url'));
            return null;            
        }
    }
        
    public PageReference showInfoAboutUser(){
        userid = ApexPages.currentPage().getParameters().get('Id');        
        myUsers=[SELECT Id, Name, First_name__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, 
                 Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c, isBring__c, RegionRate__c 
                 FROM User__c 
                 WHERE Name=: inputLName AND First_name__c=:inputFName limit 1];        

        if(myUsers.size()>0){
            PageReference pgref=new PageReference('/apex/infoAboutUserPage?id='+userId+'&user_id='+myUsers[0].Id);     
            pgref.setRedirect(true);           
            return pgref;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Sorry, but user doesn\'t exist'));
            return null;
        }        
    }
    
    public pageReference exit(){
        PageReference pgref=new PageReference('/apex/WelcomePage');
        pgref.setRedirect(true); 
        return pgref;        
    }
}
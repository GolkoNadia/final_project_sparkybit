public class InfoAboutUserController {
    
    public String userId {get;set;}
    public String data {get;set;}    
    public Integer input_new_doubt {get;set;}
        
    public User__c getUserInfo() {
        userid = ApexPages.currentPage().getParameters().get('user_Id');
        User__c u= [SELECT Id, Name, First_name__c,  Token__c, Region__c, City__c, RegionId__c, isManager__c, Available_money__c, 
                    Debt__c, Gas__c, Water__c, Electricity__c, regionRate__c, isBring__c 
                    FROM User__c  
                    WHERE id=:userid];              
        return u;        
    }
    
    public void saveNewDebt(){
        userid = ApexPages.currentPage().getParameters().get('user_Id');
        User__c u= [SELECT Id, Name, First_name__c, Password__c, Token__c, Region__c, City__c, RegionId__c, isManager__c, Available_money__c, Debt__c, Gas__c, Water__c, Electricity__c 
                    FROM User__c  
                    WHERE id=:userid]; 
        
        if(input_new_doubt!=null){            
            u.Debt__c=input_new_doubt;
            update u;            
        }
    }
    
    public List<Payment__c> getAllPayments() {
        string useridfromurl = ApexPages.currentPage().getParameters().get('Id');
        string useridfromurl2 = ApexPages.currentPage().getParameters().get('user_Id');
        data = apexpages.currentPage().getCookies().get('myuser_token').getValue();
        
        user__c u=[select id, name, token__c from User__c where id=: useridfromurl];
        ChangeString changeStr=new ChangeString();            
        if(changeStr.decryptString(data)==u.Token__c){           
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
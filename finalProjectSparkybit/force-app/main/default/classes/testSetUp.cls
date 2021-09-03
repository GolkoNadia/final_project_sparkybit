@isTest
public class testSetUp {
    
    @testSetUp
    public static void createData(){
        List<User__c> lst_users=new List<User__c>();       
        List<Payment__c> lst_payments=new List<Payment__c>();
        List<Region__c> lst_regions=new List<Region__c>();
        
        Region__c region1=new Region__c(Name='Lviv', rate__c=1.2);
        Region__c region2=new Region__c(Name='Kyiv', rate__c=1.3);
        lst_regions.add(region1);
        lst_regions.add(region2);

        insert lst_regions;
        
        for(Integer j=0;j<4;j++){
            if(j==0){
                User__c user=new User__c (Name='testUser'+j, First_name__c = 'testUser'+j, Password__c='abc', 
                                          region__c=lst_regions[j].name, debt__c=0,token__c='d', regionId__c=lst_regions[j].id, 
                                          city__c=lst_regions[j].name, Gas__c=1,Water__c=2, Electricity__c=3, isManager__c=false, 
                                          regionRate__c=1, isBring__C=false, Available_money__c=10);
                lst_users.add(user);
            }
            else if(j==1){
                User__c user=new User__c (Name='testUser'+j, First_name__c = 'testUser'+j, Password__c='abc', 
                                          region__c=lst_regions[j].name, debt__c=6,token__c='d', regionId__c=lst_regions[j].id, 
                                          city__c=lst_regions[j].name, Gas__c=1,Water__c=2, Electricity__c=3, isManager__c=false, 
                                          regionRate__c=1, isBring__C=true, Available_money__c=10);
                lst_users.add(user);
            }            
            else {
                User__c manager=new User__c (Name='testManag'+j, First_name__c = 'testManag'+j, Password__c='abc', 
                                             region__c=lst_regions[j-2].name, debt__c=0, token__c='d', regionId__c=lst_regions[j-2].id, 
                                             city__c=lst_regions[j-2].name, Gas__c=0,Water__c=0, Electricity__c=0, isManager__c=true, 
                                             regionRate__c=1, isBring__c=false, Available_money__c=10);
                lst_users.add(manager);
            }
        }
        insert lst_users;
        
        for(Integer z=0;z<2;z++){
            Payment__c payment1=new Payment__c (Name='payment1'+z, userId__c=lst_users[z].id, amount__c=10, debt__c=lst_users[z].debt__c);
            Payment__c payment2=new Payment__c (Name='payment2'+z, userId__c=lst_users[z].id, amount__c=20, debt__c=lst_users[z].debt__c);
            lst_payments.add(payment1);
            lst_payments.add(payment2);
        }
        insert lst_payments;        
    }
}
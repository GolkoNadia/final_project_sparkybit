public class myCustomController {
    
    public String inputName {get;set;}
    public String inputPassword {get;set;}
    public myUser__c user {get;set;}
    public String myUserId {get;set;}
    public List<myUser__c> myUsers{get;set;}   
    public String tempURLID{get;set;}
    //public String tempUserID{get;set;}    
    
    public string data { get; set;}
    
    public myCustomController() {
        user=new myUser__c();
        myUsers=new List<myUser__c>();        
        tempURLID='';        
    }
    
    public PageReference showUser(){
        string hashInputPassword=hashing(inputPassword);
        myUsers=[SELECT Name, id, userPassword__c, hobby__c, age__c,userToken__c from myUser__c WHERE Name=: inputName AND userPassword__c =: hashInputPassword limit 1];        
        if(myUsers.size()>0){
            //String encryptToken=encriptString(myUsers[0].userToken__c);            
            PageReference pgref = new PageReference('/apex/UserInfoPage?id='+myUsers[0].Id);
            //pgref.getParameters().put('utoken',encryptToken);
            pgref.setRedirect(true);           
            String encryptToken=encriptString(myUsers[0].userToken__c);   
            Cookie cook = new Cookie('myuser_token', encryptToken, null, -1, false);
            pgref.setCookies(new Cookie[] {cook});
            
            return pgref;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Sorry, but user doesn\'t exist'));
            return null;
        }
    }
    
    public myUser__c getUserInfo() {
        myuserid = ApexPages.currentPage().getParameters().get('Id');
        //tempURLID=ApexPages.currentPage().getParameters().get('utoken');
        data = apexpages.currentPage().getCookies().get('myuser_token').getValue();
        myUser__c ac= [SELECT Id, Name, age__c, userPassword__c, hobby__c,userToken__c FROM myUser__c  WHERE id=:myuserid];
        /*tempUserID=ac.userToken__c;
if(decryptString(tempURLID)==tempUserID){
return ac;
}
else{
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Not correct url'));
return null;            
}      */
        if(decryptString(data)==ac.userToken__c){
            return ac;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Not correct url'));
            return null;            
        }
    }
    
    public PageReference Save(){
        if(user.Name==null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please input Name of user'));
            return null;
        }
        else{
            user.userToken__c=user.Name+'123';
            user.userPassword__c=Hashing(user.userPassword__c);
            insert user;
            PageReference pgref = new PageReference('/apex/UserInfoPage?id='+user.Id);
            //String encryptToken=encriptString(user.userToken__c);
            //pgref.getParameters().put('utoken',encryptToken);            
            pgref.setRedirect(true);            
            String encryptToken=encriptString(user.userToken__c);   
            Cookie cook = new Cookie('myuser_token', encryptToken, null, -1, false);
            pgref.setCookies(new Cookie[] {cook});
            return pgref;            
        }
    }
    
    public PageReference signIn()
    {
        PageReference pgref = new PageReference('/apex/SignInPage');
        pgref.setRedirect(true);       
        return pgref;
    }
    
    public PageReference signUp()
    {
        PageReference pgref = new PageReference('/apex/signUpPage');
        pgref.setRedirect(true);       
        return pgref;
    }   
    
    public  String encriptString( String data){        
        Blob beforeblob = Blob.valueOf(data);
        string paramvalue = EncodingUtil.base64Encode(beforeblob);
        return paramvalue;
    }
    public String decryptString( String decryptString){        
        Blob afterblob = EncodingUtil.base64Decode(decryptString);        
        return afterblob.toString();        
    }    
    
    
    public String Hashing(string str){
        Blob targetBlob = Blob.valueOf(str);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);
        String res=EncodingUtil.base64Encode(hash);
        System.debug('res'+res);
        return res;
        
    }
    
    public PageReference cancel()
    {
        PageReference pgref = new PageReference('/apex/choicePage');
        pgref.setRedirect(true);       
        return pgref;
    }   
    
}
public class MessageToManagerController {
    
    public String userId {get;set;}
    public String inputMessage {get;set;}    
    
    public PageReference sendMessage(){
        userid = ApexPages.currentPage().getParameters().get('Id');
        
        /*        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
message.toAddresses = new String[] { 'nadia.golko@sparkybit.com'};
message.subject = 'user write to managers';
message.plainTextBody = inputMessage;
Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
*/
        PageReference pgref=new PageReference('/apex/cabinetUserPage?id='+userId);           
        pgref.setRedirect(true);         
        return pgref;        
    }
}
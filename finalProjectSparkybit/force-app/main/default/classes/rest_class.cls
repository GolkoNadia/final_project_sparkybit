public with sharing class rest_class {
    
    public void method() {
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
        
         req.setBody('grant_type=' +'password'+ 
                    '&client_id='+'3MVG9SOw8KERNN08lYFQuYUi5sSnKRxxk54KZdW8pfCDoi_sxx1psncZLofe2l120z.KLqjgQ6IdtCnnbklnS' + 
                    '&client_secret='+'D9A8B19FB6D0FBA3F6714A340B20D94DBD8B9F5353EE166374201BFE35814136' + 
                    '&username='+'nadia@golko.com' + 
                    '&password='+'golko220200'+'k6BcyS6nFR44oLnrVr8wxtUNe');
         
        Http http=new Http();
        try{
            HttpResponse res=http.send(req);
            System.debug(res.toString());
            System.debug(res.getBody());
            System.debug('STATUS: '+res.getStatus());
            System.debug('STATUS_CODE: '+res.getStatusCode());

        } catch(System.CalloutException e)
        {
            System.debug('It is error!'+e.getMessage());
        }
    }

    

        public static List<Object> httpMethod()
        {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://nadiagolkosparkybitcom-dev-ed.my.salesforce.com/services/data/v35.0/sobjects/Account/0010900000UBMlEAAX');

            req.setMethod('GET');
            String sessionID = 'Bearer'+' '+UserInfo.getSessionId();
            System.debug(sessionID+'dfs');
            req.setHeader('Authorization',sessionID);
    
            Http http=new Http();
            try{
                HttpResponse res=http.send(req);
                System.debug(res.getStatusCode());
                
                if(res.getStatusCode()==200){
                System.debug(res.toString());
                System.debug(res.getBody());
                System.debug('STATUS: '+res.getStatus());
                System.debug('STATUS_CODE: '+res.getStatusCode());
                
                System.debug(res.getBody());
                String jsonInput = '{\n' +
                    ' "product" : '+res.getBody()+'\n' +
                    '}';
    
                Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(jsonInput);
                System.debug(m);
                    
                    
               /* List<Object> a = (List<Object>)m.get('product');     
                    
                for(Object i : a){
                    System.debug(i);
                }           
                    
                    
                return a;*/
                    return null;

                }else{
                    System.debug('Error!');
                    return null;
                }
    
            } catch(System.CalloutException e)
            {
                System.debug('It is error!');
                return null;
            }
        }
        
    
}




    
    /*

    public static HttpResponse makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            List<Object> animals = (List<Object>) results.get('animals');
            System.debug('Received the following animals:');
            for(Object animal: animals) {
                System.debug(animal);
            }
        }
        return response;
    }
    */
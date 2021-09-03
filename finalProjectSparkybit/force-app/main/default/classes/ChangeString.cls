public class ChangeString {
    
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
}
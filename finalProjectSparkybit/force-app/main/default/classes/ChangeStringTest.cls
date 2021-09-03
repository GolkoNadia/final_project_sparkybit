@isTest
public class ChangeStringTest {
    
    @isTest
    static void encrypt_test() {
        ChangeString changeStr=new ChangeString();
        String encrypt_text=changeStr.encriptString('data');
        string decrypt_text=changeStr.decryptString(encrypt_text);
        System.assertEquals(decrypt_text,'data');        
    }
    
    @isTest
    static void decrypt_test() {
        ChangeString changeStr=new ChangeString();
        String encrypt_text=changeStr.encriptString('data');
        string decrypt_text=changeStr.decryptString(encrypt_text);
        System.assertEquals(decrypt_text,'data');                
    }
    
    @isTest    
    Static void Hashing(){
        ChangeString changeStr=new ChangeString();
        changeStr.Hashing('data');        
    }    
}
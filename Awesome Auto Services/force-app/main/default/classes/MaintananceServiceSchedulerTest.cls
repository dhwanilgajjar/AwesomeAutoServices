@isTest
public class MaintananceServiceSchedulerTest 
{
    public static testMethod  void testMethod1()
    {
        Account acc = testClassHelper.insertAccount('testAccount');
        
        Contact testContact = testClassHelper.insertContact('testContact','testContact@test.com',acc.Id);
        
        Vehicle__c vehicle =  testClassHelper.insertVehicle('BMW','6 Series','2020',0,null,testContact.Id);
        
        system.debug('vehicle:'+vehicle.Id);
        Test.startTest();
        
        MaintananceServiceScheduler obj = new MaintananceServiceScheduler();
        DataBase.executeBatch(obj); 
        
        Test.stopTest();
    }
    
    public static testMethod  void testMethod2()
    {
        Account acc = testClassHelper.insertAccount('testAccount');
        
        Contact testContact = testClassHelper.insertContact('testContact','testContact@test.com',acc.Id);
        
        Date lastServiceDate = Date.newInstance(2020, 4, 24);
        Vehicle__c vehicle =  testClassHelper.insertVehicle('BMW','6 Series','2020',5000,lastServiceDate,testContact.Id);
        
        system.debug('vehicle:'+vehicle.Id);
        Test.startTest();
        
        MaintananceServiceScheduler obj = new MaintananceServiceScheduler();
       	DataBase.executeBatch(obj); 
        
        Test.stopTest();
    }
    
    public static testMethod  void testMethod3()
    {
        Account acc = testClassHelper.insertAccount('testAccount');
        
        Contact testContact = testClassHelper.insertContact('testContact','testContact@test.com',acc.Id);
        
        Date lastServiceDate = Date.newInstance(2020, 4, 24);
        Vehicle__c vehicle =  testClassHelper.insertVehicle('BMW','6 Series','2020',5000,lastServiceDate,testContact.Id);
        
        system.debug('vehicle:'+vehicle.Id);
        Test.startTest();
      
        testClassHelper.insertMainReq('Not Confirmed',Date.today(),vehicle.Id);
        
        try
        {
            testClassHelper.insertMainReq('Not Confirmed',Date.today(),vehicle.Id);
        }
        catch(Exception ex )
        {
            System.assert(ex != null,ex.getMessage());
        }
        
        Test.stopTest();
    }
}
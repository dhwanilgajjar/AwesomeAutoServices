public class testClassHelper 
{
    public static Account insertAccount(String name)
    {
        Account acc = new Account();
        acc.Name = name;
        insert acc;
        return acc;
    }

    public static Contact insertContact(String lastName,String email,Id accountId)
    {
        Contact testContact = new Contact();
        testContact.lastName =lastName;
        testContact.Email =email;
        testContact.AccountId = accountId;
        insert testContact;
        
        return testContact;
    }
    
    public static Vehicle__c insertVehicle(String make,String model,String year,integer lastOmeterReading,Date lastSerivceDate,Id contactId)
    {
        
        Vehicle__c vehicle = new Vehicle__c();
        vehicle.Make__c = make;
        vehicle.Model__c = model;
        vehicle.Year__c = year;
        vehicle.Last_Known_Odometer_Reading__c = lastOmeterReading;
        vehicle.Last_Service_Date__c = lastSerivceDate;
        vehicle.Contact__c = contactId;
         
        insert vehicle;
        return vehicle;
    }
    public static Maintenance_Request__c insertMainReq(String status,Date mainDate,Id vehicleId)
    {
        Vehicle__c vehicle =[select id,name,Last_Known_Odometer_Reading__c,Contact__r.Email from Vehicle__c where id=:vehicleId];
        
        Maintenance_Request__c mainReq = new Maintenance_Request__c();
        mainReq.Status__c = status;
        mainReq.Maintenance_Date__c = mainDate;
        mainReq.Odometer_Reading__c =  vehicle.Last_Known_Odometer_Reading__c;
        mainReq.Vehicle_Owner_Email__c = vehicle.Contact__r.Email;
        mainReq.Vehicle__c = vehicleId;
        
        insert mainReq;
        return mainReq;
    }
}
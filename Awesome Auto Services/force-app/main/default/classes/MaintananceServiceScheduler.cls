global class MaintananceServiceScheduler implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext bc) 
    {
        String query = 'select id,name,Color__c,Contact__c,Last_Serviced_Odometer_Reading__c,Contact__r.Email,Last_Known_Odometer_Reading__c,Last_Service_Date__c,Make__c,Model__c,Year__c from Vehicle__c';
    	return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Vehicle__c> vehicles)
    {
        List<Id> vehicleIds = new List<Id>();
        List<Vehicle__c> vehicleReqMain = new List<Vehicle__c>();
        for(Vehicle__c vehicle : vehicles)
        {
            vehicleIds.add(vehicle.Id);
        }
        
        Map<Id,Maintenance_Request__c> mapMainReq = UtilHelperClass.checkForExistingMainReq(vehicleIds);
        List<Maintenance_Request__c> newMaintenanceReq = new List<Maintenance_Request__c>();
        for(Vehicle__c vehicle : vehicles)
        {
            Maintenance_Request__c mainReq = mapMainReq.get(vehicle.id);
            if(mainReq == null)
            {
                Date nextServiceDate = vehicle.Last_Service_Date__c== null?null : vehicle.Last_Service_Date__c.addMonths(11);
                Decimal nextServiceKm = (vehicle.Last_Serviced_Odometer_Reading__c==null?0:vehicle.Last_Serviced_Odometer_Reading__c) + 9500;
                if((nextServiceDate != null && nextServiceDate == Date.today()) ||
                   		(vehicle.Last_Known_Odometer_Reading__c!= 0 && nextServiceKm >= vehicle.Last_Known_Odometer_Reading__c))
                {
                    vehicleReqMain.add(vehicle);  
                    mainReq = new Maintenance_Request__c();
                    mainReq.Vehicle__c = vehicle.Id;
                    mainReq.Status__c = 'Not Confirmed';
                    mainReq.Maintenance_Date__c = Date.today();
                    mainReq.Odometer_Reading__c =  vehicle.Last_Known_Odometer_Reading__c;
                    mainReq.Vehicle_Owner_Email__c = vehicle.Contact__r.Email;
                    newMaintenanceReq.add(mainReq);
                }
            }
        }
        insert newMaintenanceReq;
       
    }
    
    global void finish(Database.BatchableContext bc)
    {
        if(!test.isRunningTest()){ System.scheduleBatch(new MaintananceServiceScheduler(), 'MaintananceServiceScheduler' , 3);}
    }
}
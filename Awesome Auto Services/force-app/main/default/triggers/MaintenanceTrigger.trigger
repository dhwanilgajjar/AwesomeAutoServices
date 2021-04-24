trigger MaintenanceTrigger on Maintenance_Request__c (before insert) 
{
    if(Trigger.isInsert && Trigger.IsBefore)
    {
        List<Id> vehicleIds = new List<Id>();
        for(Maintenance_Request__c  mainReq : Trigger.New)
        {
            vehicleIds.add(mainReq.vehicle__c);
        }
    	system.debug('vehicleIds:'+vehicleIds);
        Map<Id,Maintenance_Request__c> mapMainReq = UtilHelperClass.checkForExistingMainReq(vehicleIds);
        system.debug('mapMainReq : '+mapMainReq);
        for(Maintenance_Request__c  mainReq : Trigger.New)
        {
            if(mapMainReq.get(mainReq.vehicle__c)!= null)
            {
                mainReq.addError('Maintenance Request can\'t be created as there is already one in progress.');
            }
        }
    }
}
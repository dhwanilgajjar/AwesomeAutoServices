public class UtilHelperClass 
{
    public static Map<Id,Maintenance_Request__c> checkForExistingMainReq(List<Id> vehicleIds)
    {
        List<Maintenance_Request__c> existingMainReq = [select id,name,Vehicle__c from Maintenance_Request__c where Vehicle__c =:vehicleIds 
                                                        and status__c in ('Not Confirmed','Confirmed','In Progress')];
        Map<Id,Maintenance_Request__c> mapMainReq = new  Map<Id,Maintenance_Request__c>();
        for(Maintenance_Request__c mReq : existingMainReq)
        {
            mapMainReq.put(mReq.Vehicle__c,mReq);
        }
        return mapMainReq;
    }
}
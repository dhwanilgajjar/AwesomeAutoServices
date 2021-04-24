@RestResource(urlMapping='/SendReading')
global class IOTDeviceReceiver 
{
    @HttpPut
    global static void setReading()
    {
        RestRequest request = RestContext.request;
        Map<String,String> header = request.headers;
        Id vehicleId = (Id)header.get('vehicleId');
        Integer oMeterReading = Integer.valueof(header.get('OmeterReading'));
     	Vehicle__c tempV = new Vehicle__c();
        tempV.id =   vehicleId;      
        tempV.Last_Known_Odometer_Reading__c =   oMeterReading;      
        update tempV;
    }

}
public class TestIntegration {
    
    public static void getData(String city) {
        Http httpVar = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://api.weatherapi.com/v1/current.json?q=Paris?key=98fba4ba337e4244a3743800242406');
        req.setMethod('GET');
        HttpResponse res = httpVar.send(req);
        System.debug('status code here '+ res.getStatusCode());
        if(res.getStatusCode() == 200) {
            System.debug('response '+ res.getBody());
        }
    }

}
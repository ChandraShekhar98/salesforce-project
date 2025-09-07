public class Alphavantage {
    public static String Alpha(){
        HTTP h=new Http();
        HTTPRequest req=new HttpRequest();
        req.setEndpoint('https://www.alphavantage.co/query?function=OVERVIEW&symbol=CRM&apikey=L3B97IEB32LR6QQB');
        req.setMethod('GET');
        HTTPResponse res= h.send(req);
        String body=res.getBody();
        return body;
    }
}
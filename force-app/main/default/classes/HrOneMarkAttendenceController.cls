public class HrOneMarkAttendenceController {
    
    public static String accessToken = '';
    public static Boolean isleave= false;
    
    @future(callout=true) 
    public static void punchAttendance() {
        
        Boolean isTokengenerated = generateToken();
        
        if(isTokengenerated == true) {
            checkLeave();
        }
        
        if(!isleave) {
          markAttendance();
        }
    }
    
    public static Boolean generateToken() {
        Boolean isSucess = false;
        String endpoint = 'https://auth.hrone.cloud/oauth2/token';
        String username = Label.HROne_UserName; 
        String password = Label.HROne_Password;
        String payload ='username='+ EncodingUtil.urlEncode(username, 'UTF-8') +'&password=' + EncodingUtil.urlEncode(password, 'UTF-8') +'&grant_type=password&loginType=1&validSource=Y';
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody(payload);
        HttpResponse response = new Http().send(request);
        if(response.getStatusCode()==200) {
            isSucess = true;
            responseWrapper reswrap =  (responseWrapper) JSON.deserialize(response.getBody(), responseWrapper.class);
            accessToken = reswrap.access_token;
            system.debug('accessToken :'+accessToken);
        }
        return isSucess;
    }
    
    public static void checkLeave() {
        DateTime CurrentDay = system.now();
        String currentDate = CurrentDay.format('yyyy-MM-dd');
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.hrone.cloud/api/timeoffice/attendance/Daywise/8/'+currentDate);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept', 'application/json');
        HttpResponse res = new Http().send(req);
        List<responseWrapper> wraplst =  (List<responseWrapper>) JSON.deserialize(res.getBody(), List<responseWrapper>.class);
        if (wraplst[0].isleave == 1) {
            isleave = true;
        }
    }
    
    public static void markAttendance() {
        DateTime CurrentDay = system.now();
        String punchTime = CurrentDay.format('yyyy-MM-dd\'T\'HH:mm');
        Integer employeeId = Integer.valueOf(Label.HROne_EmployeeId);
        String punchPayload ='{"requestType":"A","employeeId":'+employeeId+',"latitude":"","longitude":"","geoAccuracy":"","geoLocation":"","punchTime":"'+punchTime+'","uploadedPhotoOneName":"","uploadedPhotoOnePath":"","uploadedPhotoTwoName":"","uploadedPhotoTwoPath":"","attendanceSource":"W","attendanceType":"Online","ipAddress":""}';
        system.debug('punchTime :'+punchTime);
        httprequest req = new httprequest();
        Http htp = new Http();
        req.setEndpoint('https://api.hrone.cloud/api/timeoffice/mobile/checkin/Attendance/Request');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');     
        req.setHeader('Authorization', 'Bearer '+ accessToken);
        req.setBody(punchPayload);
        HttpResponse res = htp.send(req);
        string result = res.getBody();
        
    }
    
    public class responseWrapper{
        public String access_token;
        Public Integer isleave;
    }
    
}
public class Test3 {
    public static Integer main() {
        List<sObject> s = [SELECT Id, LastName FROM Contact LIMIT 5];
        for(sObject so:s){
            System.debug(so.get('LastName'));
        }
        return 1;
    }
}
public class FlowClass {

    @InvocableMethod
    public static void inputMethod(List<Account> accRec) {
        System.debug('account record from flow '+accRec[0]);
    }
}
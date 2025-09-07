public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext scxt) {
        List<Lead> leads = [SELECT Id FROM Lead WHERE LeadSource = '' LIMIT 200];
        for(Lead ld: leads) {
            ld.LeadSource = 'Dreamforce';
        }
        update leads;
    }
}
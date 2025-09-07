trigger OppTrigger on Opportunity (after insert) {
    Map<String,Object> params = new Map<String,Object>{'OppId'=>Trigger.new[0].Id};
    Flow.Interview.Opp_Flow_From_Apex flowExc= new Flow.Interview.Opp_Flow_From_Apex(params);
    flowExc.start();
    String var = (String)flowExc.getVariableValue('StageNameVar');
    System.debug('output from flow '+var);
}
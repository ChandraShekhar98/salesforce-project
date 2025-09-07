global class AttendencePuncher implements Schedulable {
   
   global void execute(SchedulableContext ctx) {
       Boolean isHoliday = false;
       List<pcs__HROne_Holidays__mdt> holidays = pcs__HROne_Holidays__mdt.getAll().values();
        List<Date> dayslst = new List<Date>();
        for(pcs__HROne_Holidays__mdt dt :holidays) {
            dayslst.add(dt.pcs__Holiday_Date__c);
        }
        system.debug('dayslst :'+dayslst);
        Date currentDate = system.today();
        if(dayslst.contains(currentDate)) {
           isHoliday = true;
        }
       
       DateTime dt = system.today(); 
       String currentDayName = dt.format('EEEE');
     
       if(!(currentDayName == 'Saturday' || currentDayName == 'Sunday') && !isHoliday) { // Also need to take holidays into account
          HrOneMarkAttendenceController.punchAttendance();
       }
       
    
   }   
      
}
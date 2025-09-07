trigger UpdateContactEmailTrigger on Contact (after insert) {
    for (Contact con : Trigger.New) {
        con.Email = 'Test@mailiantor.com';
    }
}

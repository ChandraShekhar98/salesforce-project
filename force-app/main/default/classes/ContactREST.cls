@RestResource(urlMapping='/ContactRest/*')
global class ContactREST {
	@HttpPost
    global static String createContact(String firstname,String lastname,String email,String phone) {
        Contact newContact=new Contact(
        	FirstName=firstname,
            LastName=lastname,
            Email=email,
            Phone=phone
        );
        Database.SaveResult insertContactResult=Database.insert(newContact);
        if(insertContactResult.isSuccess()){
            return String.valueOf(insertContactResult.getId());
        }
        return null;
    }
    @HttpGet
    global static Contact searchContactById(){
        //get handle of req
        RestRequest request=RestContext.request;
        //parse id to search from req url
        Id searchContactId=request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        Contact searchContact=[SELECT Id,FirstName,LastName,Phone,Email from Contact WHERE Id=:searchContactId];
        return searchContact;
    }
    @HttpDelete
    global static void deleteContactById(){
        RestRequest request=RestContext.request;
        String contactId=request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        try{
        	Contact contact=[SELECT Id from Contact WHERE Id=:contactId];
        	delete contact;
			RestContext.response.responseBody=Blob.valueOf('Success: Record deleted.');                
        } catch(Exception e) {
            RestContext.response.responseBody=Blob.valueOf('Error: Record not deleted.');
        }
    }
    @HttpPut
    global static void upsertContactById(String firstname,String lastname,String email,String phone){
        RestRequest request=RestContext.request;
        String contactId=request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        try{
        	Contact contact=[SELECT Id from Contact WHERE Id=:contactId];
        	contact.FirstName=firstname;
        	contact.LastName=lastname;
        	contact.Email=email;
        	contact.Phone=phone;
            update contact;
            RestContext.response.responseBody=Blob.valueOf('Success: Record Updated.');
        } catch(Exception e) {
			Contact newContact=new Contact(
        		FirstName=firstname,
            	LastName=lastname,
            	Email=email,
            	Phone=phone
            );
            upsert newContact;
            RestContext.response.responseBody=Blob.valueOf('Success: Record Upserted.'); 
        }
    }
}
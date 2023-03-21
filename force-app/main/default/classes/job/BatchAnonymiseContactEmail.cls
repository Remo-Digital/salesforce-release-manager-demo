public with sharing class BatchAnonymiseContactEmail implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Email FROM Contact WITH SECURITY_ENFORCED');
    }

    public void execute(Database.BatchableContext bc, List<Contact> contacts){
        List<Contact> contactsToUpdate = new List<Contact>{};
        for (Contact contact : contacts) {
            contact.Email = 'test@test.com';
            contactsToUpdate.add(contact);
        }
        update(contactsToUpdate);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('all email addresses anonymised.');
    }
}
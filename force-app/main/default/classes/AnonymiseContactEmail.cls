public with sharing class AnonymiseContactEmail implements rdigital.PostReleaseStep {
    
    public Boolean isApplicable(rdigital.ReleaseStepContextModel context) {
        AggregateResult result = [SELECT COUNT(Id) contactCount FROM Contact];
        return ((Integer) result.get('contactCount')) > 0;
    }

    public rdigital.ResultModel execute(rdigital.ReleaseStepContextModel context) {
        String log = '';
        List<Contact> allContacts = [SELECT Id, Name, Email FROM Contact];
        log += 'found ' + allContacts.size() + ' contact records to update';
        for(Contact c : allContacts) {
            c.Email = 'test@test.com';
        }
        log += '\nchanged emails';
        update allContacts;
        log += '\nupdate statement done';
        rdigital.ResultModel result = new rdigital.ResultModel();
        result.log = 'updated ' + allContacts.size() + ' contacts';
        result.resultText = 'successfully updated' + allContacts.size() + ' contacts';
        return result;
    }

    public String getDescription() {
        return 'anonymise emails from all contacts';
    }

    public String getName() {
        return AnonymiseContactEmail.class.getName();
    }
}

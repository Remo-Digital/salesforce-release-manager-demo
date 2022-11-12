public with sharing class AnonymiseContactEmail implements PostReleaseStep {
    
    public Boolean isApplicable(ReleaseStepContextModel context) {
        AggregateResult result = [SELECT COUNT(Id) contactCount FROM Contact];
        return ((Integer) result.get('contactCount')) > 0;
    }

    public ResultModel execute(ReleaseStepContextModel context) {
        String log = '';
        List<Contact> allContacts = [SELECT Id, Name, Email FROM Contact];
        log += 'found ' + allContacts.size() + ' contact records to update';
        for(Contact c : allContacts) {
            c.Email = 'test@test.com';
        }
        log += '\nchanged emails';
        update allContacts;
        log += '\nupdate statement done';
        ResultModel result = new ResultModel();
        result.log = 'updated ' + allContacts.size() + ' contacts';
        result.resultText = 'successfully updated' + allContacts.size() + ' contacts';
        return result;
    }

    public String getDescription() {
        return 'anonymise emails from all contacts';
    }
}

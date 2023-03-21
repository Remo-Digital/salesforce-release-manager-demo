/**
 * If you have to update a lot of records during post release step, it is better to do it in a batch, to no hit governor limits.
 * Additionally, here is an example of how to execute something only on sandboxes.
 */
public with sharing class AnonymiseContactEmail implements rdigital.PostReleaseStep {
    
    public Boolean isApplicable(rdigital.ReleaseStepContextModel context) {
        Boolean isSandbox = [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
        return isSandbox;
    }

    public rdigital.ResultModel execute(rdigital.ReleaseStepContextModel context) {
        BatchAnonymiseContactEmail batch = new BatchAnonymiseContactEmail();
        Id batchId = Database.executeBatch(batch);

        rdigital.ResultModel result = new rdigital.ResultModel();
        result.log = 'batch started (id: ' + batchid + ')';
        result.resultText = 'batch running';
        return result;
    }

    public String getDescription() {
        return 'anonymise emails from all contacts';
    }

    public String getName() {
        return AnonymiseContactEmail.class.getName();
    }
}
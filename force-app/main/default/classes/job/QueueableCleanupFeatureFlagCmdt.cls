public with sharing class QueueableCleanupFeatureFlagCmdt implements Queueable, Metadata.DeployCallback {
    List<String> featureFlagNames;

    public QueueableCleanupFeatureFlagCmdt() {}

    public QueueableCleanupFeatureFlagCmdt(List<String> featureFlagNames) {
        this.featureFlagNames = featureFlagNames;
    }

    public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.debug('test success : '+ result);
        } else {
            System.debug('test fail : '+ result);
        }
    }

    public void execute(QueueableContext context) {
        if(Test.isRunningTest() || this.featureFlagNames == null) {
            return;
        }

        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        for (String ffName : featureFlagNames) {
            Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
            customMetadata.fullName = 'CMDT_Feature_Flag.' + ffName;
            customMetadata.label = ffName;
            Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
            customField.field = 'Active__c';
            customField.value = false;
            customMetadata.values.add(customField);
            mdContainer.addMetadata(customMetadata);
        }
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, new QueueableCleanupFeatureFlagCmdt());
    }
}

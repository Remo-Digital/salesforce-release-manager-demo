/**
 * If you have post release steps, that should run dependent on each other but you still want to keep separation of concern
 * or generally avoid hitting limits, you can use a queueable to have control over the order.
 */
public class DependentPostRealeaseSteps implements rdigital.PostReleaseStep {
    public Boolean isApplicable(rdigital.ReleaseStepContextModel context) {
        return true;
    }

    public rdigital.ResultModel execute(rdigital.ReleaseStepContextModel context) {
        List<String> names = new List<String>();
        names.add('Disable_Knowledge');
        QueueableCleanupFeatureFlagCmdt job = new QueueableCleanupFeatureFlagCmdt(names);
        Id jobID = System.enqueueJob(job);
        rdigital.ResultModel result = new rdigital.ResultModel();
        result.log = 'queueable started (id: ' + jobID + ')';
        result.resultText = 'queueable in queue';
        return result;
    }

    public String getDescription() {
        return 'cleanup not needed feature flag custom metadata';
    }

    public String getName() {
        return DependentPostRealeaseSteps.class.getName();
    }
}
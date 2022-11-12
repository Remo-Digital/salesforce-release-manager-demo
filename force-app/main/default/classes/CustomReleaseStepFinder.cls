public with sharing class CustomReleaseStepFinder implements ReleaseStepFinder {
    public List<String> findPostReleaseSteps() {
        return new List<String>{
            'AnonymiseContactEmail'
        };
    }
}

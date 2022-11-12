public with sharing class CustomReleaseStepFinder implements rdigital.ReleaseStepFinder {

    public List<rdigital.PostReleaseStep> findPostReleaseSteps() {
        return new List<rdigital.PostReleaseStep>{
            new AnonymiseContactEmail()
        };
    }
}

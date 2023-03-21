public with sharing class MarkAsVipAccount implements rdigital.PostReleaseStep {
    public Boolean isApplicable(rdigital.ReleaseStepContextModel context) {
        AggregateResult result = [SELECT COUNT(Id) vipAccountCount FROM Account WHERE AnnualRevenue > 1000];
        return ((Integer) result.get('vipAccountCount')) > 0;
    }

    public rdigital.ResultModel execute(rdigital.ReleaseStepContextModel context) {
        String log = '';
        List<Account> vipAccounts = [SELECT Id, Name FROM Account WHERE AnnualRevenue > 1000];
        log += 'found ' + vipAccounts.size() + ' vip accounts';
        for(Account a : vipAccounts) {
            a.VIP__c = true;
        }
        log += '\nchanged vip status';
        update vipAccounts;
        log += '\nupdate statement done';
        rdigital.ResultModel result = new rdigital.ResultModel();
        result.log = 'updated ' + vipAccounts.size() + ' accounts';
        result.resultText = 'successfully updated ' + vipAccounts.size() + ' accounts';
        return result;
    }

    public String getDescription() {
        return 'mark VIP accounts';
    }

    public String getName() {
        return MarkAsVipAccount.class.getName();
    }
}
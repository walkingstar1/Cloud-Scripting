
#Date: May 06, 2021
#Author: Venkatesh Setty
#Solution - Works
#Execute below script on Azure Cloud shell from the browser

$subscriptionName = 'SubscriptionName'
$resourceGroup = 'ResourceGroupName'
$logicAppsName = 'LogicAppName OR workflowName'

$subscription = Get-AzSubscription -SubscriptionName $subscriptionName

$context = $subscription | Set-AzContext

$logicApps = Get-AzResource -ResourceType Microsoft.Logic/workflows -ResourceGroupName $resourceGroup -Name $logicAppsName

Foreach ($la in $logicApps) {
    $runs = Get-AzLogicAppRunHistory -ResourceGroupName $la.ResourceGroupName -Name $la.name -FollowNextPageLink | where { $_.Status -eq 'Running' }
    Foreach($run in $runs) {
        Stop-AzLogicAppRun -ResourceGroupName $la.ResourceGroupName -Name $la.name -RunName $run.name -Force
    }
}
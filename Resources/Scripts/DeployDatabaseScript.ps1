$packagePath = $OctopusParameters["Octopus.Action.Package[Database.Deploy.Package].ExtractedPath"]
$whatIfDeploy = $OctopusParameters["Database.Deploy.WhatIf"]
$connectionString = $OctopusParameters["Database.Deploy.ConnectionString"]
$environmentName = $OctopusParameters["Octopus.Environment.Name"]
$projectName = $OctopusParameters["Octopus.Project.Name"]
$reportPath = $OctopusParameters["Database.Deploy.ReportPath"]
$executablePath = $OctopusParameters["Database.Deploy.PathToDBUpExe"]

cd $packagePath
$appToRun = "$executablePath"

if ($whatIfDeploy -eq $true)
{
	$generatedReport = "$reportPath\UpgradeReport.html"

	& $appToRun --ConnectionString="$connectionString" --PreviewReportPath="$reportPath"

	New-OctopusArtifact -Path "$generatedReport" -Name "$projectName.$environmentName.UpgradeReport.html"
}
else
{
	& $appToRun --ConnectionString="$connectionString"
}
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $MainBranchName = "main"
)

git diff --word-diff $MainBranchName | Select-String '\[-.+?-]\{\+.+?\+\}' | ForEach-Object { Write-Output $_.Matches.Value }

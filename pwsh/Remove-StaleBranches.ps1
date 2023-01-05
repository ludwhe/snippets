[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $MainBranchName = "main"
)

git checkout $MainBranchName >$null *>&1
git pull >$null *>&1
git remote prune origin >$null *>&1
    
$branches = git for-each-ref refs/heads/ "--format=%(refname:short)"
foreach ($branch in $branches) {
    $luca = git merge-base $MainBranchName $branch
    # ignore orphan branches
    if ($null -eq $luca) {
        continue;
    }

    $tree = git rev-parse "$($branch)^{tree}"
    $temp = git commit-tree $tree -p $luca -m _
    if ((git cherry $MainBranchName $temp).StartsWith('-')) {
        git branch -D $branch
    }
}

git gc

git diff --word-diff master | Select-String '\[-.+?-]\{\+.+?\+\}' | ForEach-Object { Write-Output $_.Matches.Value }

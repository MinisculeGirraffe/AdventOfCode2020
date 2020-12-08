#Part1
(((Get-Content .\PuzzleInput.txt -Raw) -split "`r`n`r`n") | % { ([char[]]($_ -replace "`r`n") | select -Unique).count }) | measure -Sum
#part2
(((Get-Content .\PuzzleInput.txt -Raw) -split "`r`n`r`n") | % {
        $groupArr = ($_ -split "`r`n")
        $cArr = [char[]]($groupArr -join '')
         (((($groupArr | % { [char[]]$_ }) | select -Unique) | % {
                $b = $_
                ((0..($cArr.Count - 1)) | ? { $cArr[$_] -eq $b }).count -eq $groupArr.Count 
            }) | ? {$_ -eq $true}).count
    }) | measure -Sum

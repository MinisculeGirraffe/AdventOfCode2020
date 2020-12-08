```Powershell
[int[]]$nums = Get-Content .\puzzleInput.txt

#Part 1
$l, $r = $nums[(($nums | % { $nums.IndexOf( 2020 - $_) }) | ? { $_ -ne -1 })]
$l * $r

#Part 2
function Get-NumberFactorIndex ($numbers, [int]$factor) {
    return $nums[(($nums | % { $nums.IndexOf( ($factor - $_)) }) | ? { $_ -ne -1 })]
}

foreach ($num in $nums) {
    try { $factorable = Get-NumberFactorIndex -numbers $nums -factor (2020 - $num) } 
    catch { continue }    
}

$l,$r = $factorable
(2020 - [Linq.Enumerable]::Sum([int[]]$factorable)) * $l * $R


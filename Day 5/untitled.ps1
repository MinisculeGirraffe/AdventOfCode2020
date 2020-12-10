$boardingPasses = Get-Content .\puzzleInput.txt | % { , [char[]]$_ }
#Part 1
function Get-UpperSplit ($array) {
    return $array[(($array.count / 2))..($array.count - 1)]
}
function Get-LowerSplit ($array) {
    return $array[0..(($array.count / 2) - 1)]
}
$passinfo = [System.Collections.ArrayList]::new()
foreach ($pass in $boardingPasses) {
    $rows = 0..127
    $cols = 0..7

    for ($i = 0; $i -lt $pass.Count; $i++) {
        switch ($pass[$i]) {
            { $_ -eq "F" } { $rows = Get-LowerSplit($rows) ; break }
            { $_ -eq "B" } { $rows = Get-UpperSplit($rows) ; break }
            { $_ -eq "L" } { $cols = Get-LowerSplit($cols) ; break }
            { $_ -eq "R" } { $cols = Get-UpperSplit($cols) ; break }
            default { throw }
        }
    }
    [void]$passinfo.Add( [PSCustomObject]@{
            Row    = $rows
            Column = $cols
            seatID = ($rows * 8) + $cols 
        })
}
$passinfo = $passinfo | sort seatID 

$passinfo[-1].seatID

#Part 2
Compare-Object -ReferenceObject $passinfo.seatID -DifferenceObject ($passinfo[0].seatID..$passinfo[($passinfo.Count - 1)].seatID)



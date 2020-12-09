#Part 1
for ($($i = 1; $j = 3); $i -lt $text.Count; $($i += 1; $j += 3)) {
    if ($j -gt ($text[$i].length - 1 ) ) {
        $offset = 3
        if ($j -= $text[$i].length + $offset -lt 0) { $offset = 0 }
        $j -= $text[$i].length + $offset
    }
    switch ($text[$i][$j]) {
        { $_ -eq '.' } { $text[$i][$j] = 'O'; break }
        { $_ -eq "#" } { $text[$i][$j] = 'X' ; break }
    }
}
$text | % { $_ | group } | ? { $_.name -eq "X" } | measure

#Part 2
function New-SlopeString ($slope, $land) {
    $text = $land
    for ($($i = $slope[1]; $j = $slope[0]); $i -lt $text.Count; $($i += $slope[1]; $j += $slope[0])) {
        if ($j -gt ($text[$i].length - 1 ) ) {
            $offset = 3
            if ($j -= $text[$i].length + $offset -lt 0) { $offset = 0 }
            $j -= $text[$i].length + $offset
        }
        switch ($text[$i][$j]) {
            { $_ -eq '.' } { $text[$i][$j] = 'O'; break }
            { $_ -eq "#" } { $text[$i][$j] = 'X' ; break }
        }
    }
    return $land
}

$slopes = (@(@(1, 1), @(3, 1), @(5, 1), @(7, 1), @(1, 2)) | % { , (New-SlopeString -slope $_ -land (Get-Content .\puzzleInput.txt | % { , [char[]]$_ })) }) 
$slopeCounts = $slopes | % { % { , [int[]]($_  | % { ($_ | ? { $_ -eq "X" }).count }) } }
($slopeCounts | % {($_ | measure -sum).sum}) -join " * " | iex
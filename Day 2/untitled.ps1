$passwords = Get-Content .\puzzleInput.txt
#Part 1
$valid = $passwords | % {
    $a = $_ -split " "
    $b = $a[0] -split "-"
    $c = $a[1] -replace ":", ""
    $d = [char[]]$a[2] | group
    $d | ? { ($_.name -eq $c) -and ($b[0]..$b[1]).Contains($_.Count) }
} 

#Part 2
$valid = $passwords | % {
    $a = $_ -split " "
    $b = $a[0] -split "-"
    $c = $a[1] -replace ":", ""
    $d = [char[]]$a[2] 
    $a[2] | ? { 
        (($d[$b[0] - 1] -eq $c) -and ($d[($b[1]) - 1 ] -ne $c)) -or 
        (($d[$b[0] - 1] -ne $c) -and ($d[($b[1]) - 1 ] -eq $c))
    }
}


#Part 1
$passports = (((Get-Content .\puzzleInput.txt -Raw) -split "`r`n`r`n") | % { , @(((($_ -split "`r`n") -join " ") -split " ") -split ":") }) 

$objArray = [System.Collections.ArrayList]::new()

for ($i = 0; $i -lt $passports.Count; $i++) {
    $obj = [PSCustomObject]::new()
    (0..($passports[$i].count - 1)) | ? { $_ % 2 -eq 0 } | % {
        Add-Member -InputObject $obj -MemberType NoteProperty -Name $passports[$i][$_] -Value $passports[$i][$_ + 1] -TypeName string
    }
    [void]$objArray.Add($obj)
}

($objArray | select * -ExcludeProperty cid | % { , ($_ | get-member | ? { $_.MemberType -eq "NoteProperty" }) }) | % {
    $_.count | ? { $_ -eq 7 }
} | measure

#Part 2
$v = $objArray | select * -ExcludeProperty cid | % {
    $_ | ? { (
            #Birth Year
            ($_.byr.length -eq 4) -and (@(1920..2002).Contains([int]$_.byr)) -and
            #Issue Year
            (($_.iyr.length -eq 4) -and (@(2010..2020).Contains([int]$_.iyr))) -and
            #Expiration Year
            (($_.eyr.length -eq 4) -and (@(2020..2030).Contains([int]$_.eyr))) -and
            #Height
            ( 
                (
                    #Text at the end of the array is CM
                    (($_.hgt -split '(?<=\d)')[-1] -eq "cm") -and 
                    #And numbers at the start of the array are between 150 - 193
                    (@(150..193).Contains( [int](($_.hgt -split '(?<=\d)')[0..($_.hgt.length - 3)] -join '')) )
                ) -or
                (
                    #Text at the end of the array is IN
                    (($_.hgt -split '(?<=\d)')[-1] -eq "in") -and 
                    #And numbers at the start of the array are between 59 - 78
                    (@(59..78).Contains( [int](($_.hgt -split '(?<=\d)')[0..($_.hgt.length - 3)] -join '')) )
                ) 
            ) -and
            #Hair Color
            (
                #Validate length is 7 and the first char is #
                (($_.hcl.length -eq 7) -and (([char[]]$_.hcl)[0] -eq "#")) -and 
                #Convert string to hex and validate it's an int
                (([int]($_.hcl -replace "#", "0x")).GetType() -eq [int])
            ) -and

            #Eye Color
            (@("amb", "blu", "brn", "gry", "grn", "hzl", "oth").Contains($_.ecl)) -and
            #Passport ID
            (
                #Validate it's a real number
                (([int]$_.pid).getType() -eq [int]) -and
                #Validate all leading 
                ([string][int]$_.pid.Length -le 9) -and
                #Validate The length of the number is 9
                ( $_.pid.length -eq 9)
            )

        ) }
}






$bags = Get-Content ./puzzleinput.txt
$parsedBags = $bags | ForEach-Object { 
    $formatString = $_ -replace "bags", ""
    $formatString = $formatString -replace "bag", ""
    $formatString = $formatString -replace '\.', ""

    $split = $formatString -split "contain"

    $color = (($split[0] -split " ") | Where-Object { $_ -ne '' } ) -join " "
    $children = $split[1] -split ","

    $parsedChildren = $children | ForEach-Object {
        $string = $_ 
        $count = $string | Where-Object { $_ -match '^\d+$' }
        $childColor = ($string[($string.IndexOf($count) + 1)..$string.length] -join "") -split " "
        $childColorString = ($childColor | Where-Object { $_ -ne '' }) -join " "
        [PSCustomObject]@{
            number = [int][string]$count
            color  = $childColorString
        }
    }
    [PSCustomObject]@{
        color    = $color
        children = $parsedChildren
    }
}

$parsedBags | ForEach-Object {
    $color = $_.color
    $parents = $parsedBags | Where-Object { $_.children.color -eq $color }
    return $_ | Add-Member -MemberType NoteProperty -Name parents  -Value $parents
}

$problemBag = $parsedBags | Where-Object { $_.color -eq "Shiny Gold" }

$parentColors = @()
$obj = $problemBag.parents
while ($null -ne $obj) {
    $obj.color | ForEach-Object { $parentColors += $_ }
    $obj = $obj.parents
}
$parentColors | Select-Object -Unique | Measure-Object

#part 2

$childarray = @()
$bottomBags = $parsedBags | ? { $_.children.number -eq 0 }
$childarray += $problemBag.children

$obj = $problemBag.children
while($obj) {

}
$color = $obj.color
$levelDown = $parsedBags | ? { $_.parents.color -eq $color }
$nonNullChildren = $levelDown.children | ? {$_.children.number -ne 0}
$childarray += $nonNullChildren.children
$obj = $nonNullChildren.children
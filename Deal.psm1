Function Read-SpecsaverLensesDeals {
<#
 .SYNOPSIS 
    Read-SpecsaverLensesDeals is a PowerShell function that displays the daily deals on contact lenses.
 .EXAMPLE
    Read-SpecsaverLensesDeals
#>
    Write-Host "Today's Specsaver Contact Lenses Deals are..."
    
    $specsavers = "https://www.specsavers.co.nz/special-offers/spend-and-save-on-contact-lenses"
    
    $req = Invoke-WebRequest -URI $specsavers -UseBasicParsing

    $req.Images.alt | Where-Object { $_ -like '*off*'  }
}

Export-ModuleMember -Function Read-SpecsaverLensesDeals -Alias 'Lenses'




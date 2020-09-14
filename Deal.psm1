Function Read-SpecsaverLensesDeals {
<#
 .SYNOPSIS 
    Save-InstagramPictures is a PowerShell function that displays the daily deals on contact lenses.
 .EXAMPLE
    Save-InstagramPicture -URI github -Index 1
#>
    Write-Host "Today's Specsaver Contact Lenses Deals are..."
    
    $specsavers = "https://www.specsavers.co.nz/special-offers/spend-and-save-on-contact-lenses"
    
    $req = Invoke-WebRequest -URI $specsavers -UseBasicParsing

    $req.Images.alt | Where { $_ -like '*off*'  }
}

Export-ModuleMember -Function Read-SpecsaverLensesDeals -Alias 'Lenses'




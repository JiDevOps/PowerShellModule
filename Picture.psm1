Function Save-InstagramPicture {
<#
 .SYNOPSIS 
    Save-InstagramPictures is a PowerShell function that saves pictures from Instagram onto the file system. 
 .PARAMETER URI
    The URI to the instagram photo
 .PARAMETER File
    Name of the downloaded picture. If this parameter is not set, a random file name will be generated.
 .EXAMPLE
    Save-InstagramPicture -URI https://www.instagram.com/p/B8DoMiAhkPL/
#>
    param (
        [parameter (Mandatory=$true)]
        [string]$URI, 
        [parameter (Mandatory=$false)]
        [string]$File = [System.IO.Path]::GetRandomFileName() + '.jpg'
    )

    Write-Host 'Welcome to the instagram picture downloader!'

    $WebContent = Invoke-WebRequest -Uri $URI  -UseBasicParsing
    $WebContentString = $WebContent.ToString()

    [string]$start = '<meta property="og:image" content="'
    [string]$end = '<meta property="og:description"'

    [int]$startIndex = ($WebContentString | Select-String -Pattern $start -AllMatches).Matches.Index + $start.Length
    [int]$endIndex = ($WebContentString | Select-String -Pattern $end -AllMatches).Matches.Index

    $image = ($WebContentString.Substring($startIndex, ($endIndex - $startIndex)) -replace '" />' -replace '').Trim()
    $directory = 'C:\Users\' + $Env:UserName + '\Pictures\'
    
    if(!(Test-Path -Path $directory )){
        Write-Error 'The Pictures directory does not exist!' $directory
        exit
    }

    Invoke-WebRequest -Uri $image -OutFile $directory$File

    Write-Host 'Image has been successfully saved to the Pictures folder with the name' $File  
    
    ii $directory
}

Export-ModuleMember -Function Save-InstagramPicture -Alias 'Insta'




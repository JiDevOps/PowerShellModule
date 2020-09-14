Function Save-InstagramPicture {
<#
 .SYNOPSIS 
    Save-InstagramPictures is a PowerShell function that saves pictures displayed on the Instgram Profile from Instagram onto the file system.
 .PARAMETER ID
    The Instagram ID e.g. github 
 .PARAMETER Index
    Index of the photo displayed on the Instagram Profile Page
 .PARAMETER File
    Name of the downloaded picture. If this parameter is not set, a random file name will be generated.
 .EXAMPLE
    Save-InstagramPicture -URI github -Index 1
#>
    param (
        [parameter (Mandatory=$true)]
        [string]$ID, 
        [parameter (Mandatory=$false)]
        [int]$Index = 0,
        [parameter (Mandatory=$false)]
        [string]$File = [System.IO.Path]::GetRandomFileName() + '.jpg'
    )

    Write-Host 'Welcome to the instagram picture downloader!'
    
    $WebContent = Invoke-RestMethod  -Uri "https://www.instagram.com/$($ID)/?__a=1"
    
    $imageURI = $WebContent.graphql.user.edge_owner_to_timeline_media.edges[$index].node.display_url

    # Download Picture
    $directory = 'C:\Users\' + $Env:UserName + '\Pictures\'
    
    if(!(Test-Path -Path $directory )){
        Write-Error 'The Pictures directory does not exist!' $directory
        exit
    }

    Invoke-WebRequest -Uri $imageURI -OutFile $directory$File

    Write-Host 'Image has been successfully saved to the Pictures folder with the name' $File  
    
    Invoke-Item $directory
}

Export-ModuleMember -Function Save-InstagramPicture -Alias 'Insta'




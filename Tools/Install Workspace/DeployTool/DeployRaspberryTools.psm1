#region Private

#endregion Private
#region Public
function Update-PiStore {
    [cmdletsbinding()]
    param ()
    $raspberrysettings = Get-Content .\RaspberrySettings.json | ConvertFrom-Json
    Copy-Item -path "..\..\Code" -Destination $("\\" + $($raspberrysettings.deviceAddress) + $raspberrysettings.DeploymentDir) -Recurse
}

function Update-PiConnectionSettings {
    
    [cmdletsbinding()]
    param (
        [Parameter(Mandatory=$false)]    
        [string]$userName,
    
        [Parameter(Mandatory=$false)]
        [securestring]$Password,

        [Parameter(Mandatory=$false)]
        [string]$DeviceAddress,

        [Parameter(Mandatory=$false)]
        [string]$DestinationAddress,

        [Parameter(Mandatory=$false)]
        [string]$SourceAddress
    )

    Begin
    {
        $ModuleCurrent = Get-Module -Name 'DeployRaspberryTools'
        $RaspberrySettingsfile = "$($ModuleCurrent.Path + "\RaspberrySettings.json")"
        $test = Test-Path -Path $RaspberrySettingsfile
    }

    Process
    {
        if(!$test)
        {
            $EmptyTemplate = '{"ModuleVersion":"1.0.0.0","DeviceData":"{"deviceAddress":"","UserName":"pi","Password":"raspberry","DeploymentDir":"","SourceAddress":".\"}"}'
            New-Item -Path $RaspberrySettingsfile -Value $EmptyTemplate
        }
    
        $RaspberrySettings = $(Get-Content -Path $RaspberrySettingsfile | ConvertFrom-Json).DeviceData
        
        if($userName)
        {
            $RaspberrySettings.UserName = $userName
        }

        if($Password)
        {
            $RaspberrySettings.Password = $Password
        }

        if($DeviceAddress)
        {
            $RaspberrySettings.deviceAddress = $DeviceAddress
        }

        if($DestinationAddress)
        {
            $RaspberrySettings.DeploymentDir = $DestinationAddress
        }

        if($SourceAddress)
        {
            $RaspberrySettings.SourceAddress = $SourceAddress
        }

        Set-Item -Path $RaspberrySettingsfile -Value $RaspberrySettings
    }
    
}
#endregion Public
#region Private

#endregion Private
#region Public
function Update-PiStore {
    [cmdletbinding()]
    param ()
    $raspberrysettings = Get-Content .\RaspberrySettings.json | ConvertFrom-Json
    Copy-Item -path "..\..\Code" -Destination $("\\" + $($raspberrysettings.deviceAddress) + $raspberrysettings.DeploymentDir) -Recurse
}

function Update-PiConnectionSettings {
    
    [cmdletbinding()]
    param (
        [Parameter(Mandatory=$false)]    
        [string]$userName,
    
        [Parameter(Mandatory=$false)]
        [string]$Password,

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
        $RaspberrySettingsfile = "$($ModuleCurrent.ModuleBase + "\RaspberrySettings.json")"
        $test = Test-Path -Path $RaspberrySettingsfile
    }

    Process
    {
        if(!$test)
        {
            $EmptyTemplate = '{"ModuleVersion":"1.0.0.0","DeviceData":{"deviceAddress":"","UserName":"pi","Password":"raspberry","DeploymentDir":"","SourceAddress":""}}'
            New-Item -Path $RaspberrySettingsfile -Value $EmptyTemplate
        }
        
        $RaspberrySettingsFull = Get-Content -Path $RaspberrySettingsfile | ConvertFrom-Json
        $RaspberrySettings = $RaspberrySettingsFull.DeviceData
        
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

        $RaspberrySettingsFull.DeviceData = $RaspberrySettings 
        $RaspberrySettingsFullJson = ConvertTo-Json -InputObject $RaspberrySettingsFull -Depth 3 -Compress
        Set-Content -Path $RaspberrySettingsfile -Value $RaspberrySettingsFullJson -Force
    }
    
}
#endregion Public
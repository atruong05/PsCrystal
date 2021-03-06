<#
.SYNOPSIS
PowerShell interface to CrystalReports SDK.

.DESCRIPTION
PowerShell interface to CrystalReports SDK.

.NOTES
Author       : Craig Buchanan <https://github.com/craibuc>
Contributers : Steve Romanow <https://github.com/slestak>
Homepage     : https://github.com/craibuc/PsCrystal
#>

function Get-Directory {
    param (
        [string]$path
    )
	return Convert-Path $path
}

#
# load (dot-source) *.PS1 files, excluding unit-test scripts (*.Tests.*), and disabled scripts (__*)
#

@("$PSScriptRoot\Public\*.ps1","$PSScriptRoot\Private\*.ps1") | Get-ChildItem |
    Where-Object { $_.Name -like '*.ps1' -and $_.Name -notlike '__*' -and $_.Name -notlike '*.Tests*' } |
    % {

        # dot-source script
        Write-Debug "Loading $($_.BaseName)"
        . $_

        # export functions in the `Public` folder
        if ( (Split-Path( $_.Directory) -Leaf) -Eq 'Public' ) {
            Write-Debug "Exporting $($_.BaseName)"
            Export-ModuleMember $_.BaseName
        }

    }

#
# manually export aliases specified in a PS1 file (can this be done automatically?)
#

# Export-ModuleMember Open-Report
# Set-Alias cr-or Open-Report
# Export-ModuleMember -Alias cr-or

# Export-ModuleMember Close-Report
# Set-Alias cr-cr Close-Report
# Export-ModuleMember -Alias cr-cr

# Export-ModuleMember Export-Report
# Set-Alias cr-er Export-Report
# Export-ModuleMember -Alias cr-er

# Export-ModuleMember Save-Report
# Set-Alias cr-sr Save-Report
# Export-ModuleMember -Alias cr-sr

# Export-ModuleMember Invoke-Report
# set-Alias cr-ir Invoke-Report
# Export-ModuleMember -Alias cr-ir

# Export-ModuleMember Set-Credentials
# set-Alias cr-sc Set-Credentials
# Export-ModuleMember -Alias cr-sc

# Export-ModuleMember Get-Directory
# set-Alias gd Get-Directory
# Export-ModuleMember -Alias gd

# Export-ModuleMember Import-Lov
# Set-Alias cr-il Import-Lov
# Export-ModuleMember -Alias cr-il
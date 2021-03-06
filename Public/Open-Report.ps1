<#
.SYNOPSIS
    Open the report from the specified location

.DESCRIPTION
.NOTES
.LINK
.EXAMPLE
.INPUTTYPE
.RETURNVALUE
.COMPONENT
.ROLE
.FUNCTIONALITY
.PARAMETER
#>
function Open-Report {

	[cmdletbinding()]
    param (
        [Parameter(Position=0,Mandatory=$true,ValueFromPipelinebyPropertyName=$true,ValueFromPipeline=$true)]
        [Alias('FullName')]
        [string[]]$files
    )

    begin {
        Write-Debug "$($MyInvocation.MyCommand.Name)::Begin"
        $reportDocument = New-Object CrystalDecisions.CrystalReports.Engine.ReportDocument
    }

    process {
        Write-Debug "$($MyInvocation.MyCommand.Name)::Process"

        foreach ($file In $files){
            Write-Verbose "Opening $file"
            try {
                $reportDocument.Load($file)
                return $reportDocument
            }
            catch [CrystalDecisions.Shared.CrystalReportsException] {
                switch ($_.Exception.InnerException.ErrorCode) {
                    0x80004005 {
                        #The system cannot find the path specified [0x80004005]
                        # throw [System.Io.FileNotFoundException] ("File not found: {0}" -f $path)
                        Write-Error  ("File not found: {0}" -f $path)
                    }
                    0x8000020D {
                        # Unable to load report [0x8000020D]
                        # throw [System.FormatException] ("Invalid file: {0}" -f $path)
                        Write-Error  ("Invalid file: {0}" -f $path)
                    }
                    default {
                        throw [System.Exception] ($error)
                    }
                }
            }
            catch {
                Write-Error $_.Exception
            }
        }

    } # /process

    end {
        Write-Debug "$($MyInvocation.MyCommand.Name)::End"
    }

}

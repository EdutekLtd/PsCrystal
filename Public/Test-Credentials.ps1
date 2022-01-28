<#
    .SYNOPSIS
        Sets database credentials
    .DESCRIPTION
        Sets database credentials (i.e. account, password, database, server)
    .PARAMETER acct
        account
    .PARAMETER pass
        password
    .PARAMETER db
        datbase
    .PARAMETER svr
        server
    .EXAMPLE
        Set-Credentials "account", "password", "server", "database"

	.EXAMPLE
		'splatting' syntax
		$credential = @{
			acct = "account"
			pass = "password"
			svr = "server"
		}

		Set-Credentials @credential

    .INPUTS
        A short summary of pipeline input(s) supported by this command. For each input type, PowerShell’s built-in help follows this convention:

    .OUTPUTS
        A short summary of items generated by this command. For each output type, PowerShell’s built-in help follows this convention:
        System.ServiceProcess.ServiceController Get-Service returns objects that represent the services on the computer.
    .NOTES
        Some notes
#>

function Test-Credentials {

	[cmdletbinding()]
    param (
        [Parameter(ValueFromPipeline=$true,Position=0,Mandatory=$true)][CrystalDecisions.CrystalReports.Engine.ReportDocument]$reportDocument
    )

    begin {Write-Verbose "$($MyInvocation.MyCommand.Name)::Begin"}

    process {

            Write-Verbose "Testing Database Credentials..."

            foreach ($table in $reportDocument.database.tables) {
                if ( $table.testConnectivity() -eq $false ) {
                    throw "Invalid database credentials" 
                }
            }
            $reportDocument.VerifyDatabase()
    }

    end {Write-Verbose "$($MyInvocation.MyCommand.Name)::End"}


}
function Update-ReportsDatabaseConnection {

	[cmdletbinding()]
    param (
        
        [string]$folder,
        [string]$svr,
        [string]$dtb,
        [string]$acct,
        [string]$pass

    )

    Import-Module PsCrystal -Force
	
    Get-ChildItem $folder -Filter *.rpt | ForEach-Object {
	    try {
	
		    $rptPath = $_.FullName
		
		    # open report
		    $rpt = Get-ChildItem $rptPath | Open-Report
		
		    # other stuff
		    $rpt.SummaryInfo.ReportComments += $("`r`nModified: {0}" -f (Get-Date))
		
		    # set DB credentials
		    Set-Credentials -reportDocument $rpt -svr "$svr" -dtb "$dtb" -acct "$acct" -pass "$pass"
		    # set parameter values
		
		    # generated PDF
		
		    #save report
		    Out-Report $rpt -Replace

	    }
        catch [Exception] {
            write-host $_.Exception.message
        }
	    finally {
		    if ($rpt) {
			    # close report to release resources
			    Close-Report $rpt
		    }
	    }
    }
}
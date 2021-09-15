
#Connect-PnPOnline -url https://pgsgeo.sharepoint.com/sites/CorpStructure -UseWebLogin
#Connect-PnPOnline -url https://pgsgeo.sharepoint.com/sites/RollupTesting -UseWebLogin
#$listItems = (Get-PnPListItem -List "Master Legal Entities List" -Fields "URL")

#$items = @()
#foreach ($item in $listItems) {
#        $items += $item["URL"].Url
#}


#$items = @('https://pgsgeo.sharepoint.com/sites/RollupTesting/Andaman', 'https://pgsgeo.sharepoint.com/sites/RollupTesting/PGS%20Seismic%20Services%20Limited', 'https://pgsgeo.sharepoint.com/sites/RollupTesting/Arrow%20Seismic%20Invest%20I%20Limited')
$items = @('https://pgsgeo.sharepoint.com/sites/CorpStructure/Petroleum%20Geo-ServicesAsiaPacificPteLtd/')

foreach ($url in $items) {
        Write-Host "============================================="
        Write-Host $url
        Write-Host "============================================="
        #Get URL to the site
        #$url = ""
        #Connect to the Site
        Connect-PnPOnline -url $url -UseWebLogin
    


        #Add a Page
        $page = Add-PnPPage -Name "default" -ErrorAction SilentlyContinue
        if ($null -ne $page) {

                #Update Title of the page
                #Set-PnPPage -Identity $page -Title "Home"
                
                #Make it home page
                Set-PnPHomePage -RootFolderRelativeUrl "SitePages/default.aspx"

                #Add sections to the page
                Add-PnPPageSection -Page $page -SectionTemplate OneColumnVerticalSection

                #Add Webpart1
                $CIWP = @"
{
"description":"Company Information","masterItemId":"0","customDashboardConfig":"Company Information","listName":"Master Legal Entities List","camlQuery":"<View><Query><Where><Eq><FieldRef Name='URL'/><Value Type='URL'>{RelativeUrl}</Value></Eq></Where></Query><RowLimit>3</RowLimit></View>"
}
"@

                Add-PnPClientSideWebPart -Page "default" -Component "Rollup" -WebPartProperties $CIWP -Section 1 -Column 1 -Order 1

                $SRWP = @"
{
"description":"Signing Rights","camlQuery":"<View><Query><Where><Eq><FieldRef Name='URL'/><Value Type='URL'>{RelativeUrl}</Value></Eq></Where></Query><RowLimit>3</RowLimit></View>","customDashboardConfig":"Signing Rights","masterItemId":"0","listName":"Master Legal Entities List"
}
"@
    
                Add-PnPClientSideWebPart -Page "default" -Component "Rollup" -WebPartProperties $SRWP -Section 1 -Column 1 -Order 2

                $ESWP = @"
{
"description":"Entity Status","listName":"Master Legal Entities List","masterItemId":"0","camlQuery":"<View><Query><Where><Eq><FieldRef Name='URL'/><Value Type='URL'>{RelativeUrl}</Value></Eq></Where></Query><RowLimit>3</RowLimit></View>","customDashboardConfig":"Entity Status"
}
"@

                Add-PnPClientSideWebPart -Page "default" -Component "Rollup" -WebPartProperties $ESWP -Section 1 -Column 1 -Order 3

    
                $AIWP = @"
{
"description":"Additional Information","listName":"Master Legal Entities List","masterItemId":"0","camlQuery":"<View><Query><Where><Eq><FieldRef Name='URL'/><Value Type='URL'>{RelativeUrl}</Value></Eq></Where></Query><RowLimit>3</RowLimit></View>","customDashboardConfig":"Additional Information"
}
"@

                Add-PnPClientSideWebPart -Page "default" -Component "Rollup" -WebPartProperties $AIWP -Section 1 -Column 1 -Order 4

    
                $REWP = @"
{
"description":"Responsibility","masterItemId":"0","customDashboardConfig":"Responsibility","listName":"Master Legal Entities List","camlQuery":"<View><Query><Where><Eq><FieldRef Name='URL'/><Value Type='URL'>{RelativeUrl}</Value></Eq></Where></Query><RowLimit>3</RowLimit></View>"
}
"@

                Add-PnPClientSideWebPart -Page "default" -Component "Rollup" -WebPartProperties $REWP -Section 1 -Column 2 -Order 1


    
                $COWP = @"
{
"description":"Contact","listName":"Master Legal Entities List","masterItemId":"0","editUrl":"","customDashboardConfig":"Contact","camlQuery":"<View><Query><Where><Eq><FieldRef Name='URL'/><Value Type='URL'>{RelativeUrl}</Value></Eq></Where></Query><RowLimit>3</RowLimit></View>"
}
"@

                Add-PnPClientSideWebPart -Page "default" -Component "Rollup" -WebPartProperties $COWP -Section 1 -Column 2 -Order 2
        }
    
        
        Set-PnPClientSidePage -Identity default.aspx -HeaderType None -CommentsEnabled:$false -LayOutType Home -Title "Home"

        Disconnect-PnPOnline
}
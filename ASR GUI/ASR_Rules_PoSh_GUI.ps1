#XAML Code kann zwischen @" und "@ ersetzt werden:
[xml]$XAML = @"
<Window x:Class="ASR_GUI_Radio.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:ASR_GUI_Radio"
        mc:Ignorable="d"
        Title="ASR Rules PoSh GUI" Width="800" Height="580" MaxHeight="580" MaxWidth="800" MinHeight="580" MinWidth="800">
    <StackPanel>
        <Menu  IsMainMenu="true">
            <MenuItem Header="_File">
                <MenuItem x:name="btnReport" Header="Report" ToolTip="A Report will be created in same Directory as File."/>
            </MenuItem>
            <MenuItem Header="_Edit">
                <MenuItem x:Name="btnClear" Header="Remove all configured ASR Rules from Device" ToolTip="CAUTION! Any ASR Rule Configuration will be set to &quot;Not configured&quot;."/>
            </MenuItem>
            <MenuItem x:Name="btnHelp" Header="_Help">
                <MenuItem x:Name="btnDocs" Header="Documentation of ASR Rules"/>
                <MenuItem x:Name="btnInfo" Header="Info"/>
            </MenuItem>
        </Menu>
        <Grid Height="50">
            <Label Content="Attack Surface Reduction Rules" VerticalAlignment="Center" HorizontalAlignment="Left" FontSize="16" FontWeight="Bold"/>
        </Grid>
        <Grid x:Name="OfficeAppsChildProcess">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block all Office applications from creating child processes"  Grid.Column="0" />
            <RadioButton x:Name="OAppChildProcD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="OAppChildProcA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="OAppChildProcB" Content="Enabled" VerticalAlignment="Center"  Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block execution of potentially obfuscated scripts" Grid.Column="0" />
            <RadioButton x:Name="ObfusScriptD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="ObfusScriptA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="ObfusScriptB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block Win32 API calls from Office macro" Grid.Column="0" />
            <RadioButton x:Name="MacroAPID" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="MacroAPIA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="MacroAPIB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block Office applications from creating executable content" Grid.Column="0" />
            <RadioButton x:Name="OfficeCreateExeD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="OfficeCreateExeA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="OfficeCreateExeB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block Office applications from injecting code into other processes" Grid.Column="0" />
            <RadioButton x:Name="OfficeCodeInjD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="OfficeCodeInjA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="OfficeCodeInjB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block JavaScript or VBScript from launching downloaded executable content" Grid.Column="0" />
            <RadioButton x:Name="ScriptDwnlExeD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="ScriptDwnlExeA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="ScriptDwnlExeB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block executable content from email client and webmail" Grid.Column="0" />
            <RadioButton x:Name="MailExeD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="MailExeA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="MailExeB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block executable files from running unless they meet a prevalence, age, or trusted list criteria" Grid.Column="0" />
            <RadioButton x:Name="FileCriteriaD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="FileCriteriaA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="FileCriteriaB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Use advanced protection against ransomware" Grid.Column="0" />
            <RadioButton x:Name="RansomwareD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="RansomwareA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="RansomwareB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block credential stealing from the Windows local security authority subsystem (lsass.exe)" Grid.Column="0" />
            <RadioButton x:Name="lsassD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="lsassA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="lsassB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block process creations originating from PSExec and WMI commands" Grid.Column="0" />
            <RadioButton x:Name="prcCreateD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="prcCreateA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="prcCreateB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block untrusted and unsigned processes that run from USB" Grid.Column="0" />
            <RadioButton x:Name="USBD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="USBA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="USBB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block Office communication applications from creating child processes" Grid.Column="0" />
            <RadioButton x:Name="OCommChildProcD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="OCommChildProcA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="OCommChildProcB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block Adobe Reader from creating child processes" Grid.Column="0" />
            <RadioButton x:Name="PDFChildProcD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="PDFChildProcA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="PDFChildProcB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label Content="Block persistence through WMI event subscription" Grid.Column="0" />
            <RadioButton x:Name="WMIPersD" Content="Disabled" VerticalAlignment="Center"  Grid.Column="1" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="WMIPersA" Content="Audit" VerticalAlignment="Center"  Grid.Column="2" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
            <RadioButton x:Name="WMIPersB" Content="Enabled" VerticalAlignment="Center" Grid.Column="3" HorizontalAlignment="Left" Grid.IsSharedSizeScope="True" Panel.ZIndex="2" />
        </Grid>
        <Grid Height="40" VerticalAlignment="Center">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="5*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Label x:Name="lblTotal" Content="Total Numbers:" Grid.Column="0" VerticalAlignment="Center" />
            <Label x:Name="lblTotalDisabled" Content="0 Disabled" Grid.Column="1" VerticalAlignment="Center"/>
            <Label x:Name="lblTotalAudit" Content="0 Audit" Grid.Column="2" VerticalAlignment="Center"/>
            <Label x:Name="lblTotalEnabled" Content="0 Enabled" Grid.Column="3" VerticalAlignment="Center"/>
        </Grid>
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="3*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition/>
            </Grid.ColumnDefinitions>
            <Button x:Name="btnSave" Content="Save Changes" Grid.Column="2" Padding="1,3,1,3" Margin="10,10,10,10" ToolTip="This will set the new configuration based on the selection."/>
            <Button x:Name="btnReset" Content="Reset" Grid.Column="4" Margin="10,10,10,10" ToolTip="This will reset the selection to the current configuration."/>
        </Grid>
    </StackPanel>
</Window>



"@ -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window' #-replace wird benötigt, wenn XAML aus Visual Studio kopiert wird.
#XAML laden
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
try{
   $Form=[Windows.Markup.XamlReader]::Load( (New-Object System.Xml.XmlNodeReader $XAML) )
} catch {
   Write-Host "Windows.Markup.XamlReader konnte nicht geladen werden. Mögliche Ursache: ungültige Syntax oder fehlendes .net"
}

#Write-Host ====================================== ASR RUles Powershell GUI Live Log ======================================

$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "ASR$($_.Name)" -Value $Form.FindName($_.Name)}

########## GUI Reset Function ###########
function ASRReset {
    $RulesIds = Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionRules_Ids
    $RulesActions = Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionRules_Actions
    $RulesExclusions = Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionOnlyExclusions

    $RulesIdsArray = @()
    $RulesIdsArray += $RulesIds

    ##Uncheck RadioButtons
    $RadioArray = "OAppChildProc", "ObfusScript", "MacroAPI", "OfficeCreateExe", "OfficeCodeInj", "ScriptDwnlExe", "MailExe", "FileCriteria", "Ransomware", "lsass", "prcCreate", "USB", "OCommChildProc", "PDFChildProc", "WMIPers"
    for ($i=0; $i -lt $RadioArray.Length; $i++){
        $RadioCheckA = $RadioArray[$i]+"A"
        $RadioCheckD = $RadioArray[$i]+"D"
        $RadioCheckB = $RadioArray[$i]+"B"

        $Form.FindName($RadioCheckA).isChecked = 0
        $Form.FindName($RadioCheckD).isChecked = 0
        $Form.FindName($RadioCheckB).isChecked = 0
    }
    
    ##Total Counter
    $counter = 0
    $TotalDisabled = 0
    $TotalAudit = 0
    $TotalEnabled = 0

    ForEach ($i in $RulesActions){
        If ($RulesActions[$counter] -eq 0){$TotalDisabled++}
        ElseIf ($RulesActions[$counter] -eq 2){$TotalAudit++}
        ElseIf ($RulesActions[$counter] -eq 1){$TotalEnabled++}
        $counter++
    }
    $Form.FindName("lblTotalDisabled").Content =  $TotalDisabled
    $Form.FindName("lblTotalAudit").Content = $TotalAudit
    $Form.FindName("lblTotalEnabled").Content = $TotalEnabled

    $counter = 0

    ForEach ($j in $RulesIds){
        ## Converting GUID to RadioButtonGroup
        If ($RulesIdsArray[$counter] -eq "D4F940AB-401B-4EFC-AADC-AD5F3C50688A"){$ASR = "OAppChildProc"}
        ElseIf ($RulesIdsArray[$counter] -eq "5BEB7EFE-FD9A-4556-801D-275E5FFC04CC"){$ASR = "ObfusScript"}
        ElseIf ($RulesIdsArray[$counter] -eq "92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B"){$ASR = "MacroAPI"}
        ElseIf ($RulesIdsArray[$counter] -eq "3B576869-A4EC-4529-8536-B80A7769E899"){$ASR = "OfficeCreateExe"}
        ElseIf ($RulesIdsArray[$counter] -eq "75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84"){$ASR = "OfficeCodeInj"}
        ElseIf ($RulesIdsArray[$counter] -eq "D3E037E1-3EB8-44C8-A917-57927947596D"){$ASR = "ScriptDwnlExe"}
        ElseIf ($RulesIdsArray[$counter] -eq "BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550"){$ASR = "MailExe"}
        ElseIf ($RulesIdsArray[$counter] -eq "01443614-cd74-433a-b99e-2ecdc07bfc25"){$ASR = "FileCriteria"}
        ElseIf ($RulesIdsArray[$counter] -eq "c1db55ab-c21a-4637-bb3f-a12568109d35"){$ASR = "Ransomware"}
        ElseIf ($RulesIdsArray[$counter] -eq "9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2"){$ASR = "lsass"}
        ElseIf ($RulesIdsArray[$counter] -eq "d1e49aac-8f56-4280-b9ba-993a6d77406c"){$ASR = "prcCreate"}
        ElseIf ($RulesIdsArray[$counter] -eq "b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4"){$ASR = "USB"}
        ElseIf ($RulesIdsArray[$counter] -eq "26190899-1602-49e8-8b27-eb1d0a1ce869"){$ASR = "OCommChildProc"}
        ElseIf ($RulesIdsArray[$counter] -eq "7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c"){$ASR = "PDFChildProc"}
        ElseIf ($RulesIdsArray[$counter] -eq "e6db77e5-3df2-4cf1-b95a-636979351e5b"){$ASR = "WMIPers"}
        ## Checking the Action Mode/Radio Button
        If ($RulesActions[$counter] -eq 0){$Radio = $ASR+"D" }
        ElseIf ($RulesActions[$counter] -eq 1){ $Radio = $ASR+"B"}
        ElseIf ($RulesActions[$counter] -eq 2){$Radio = $ASR+"A"}
        $Form.FindName($Radio).isChecked = 1
        $counter++        
    }
}


ASRReset
#Write-Host "Loading Successful"




######## Resetting GUI ##############
$btnReset = $Form.FindName("btnReset")
$btnReset.Add_Click({
    ASRReset    
})



############ Set New ASR Rules ###########
$btnSave = $Form.FindName("btnSave")
$btnSave.Add_Click({

    #Write-Host ====================================== Set ASR Rules ======================================
    #Write-Host 
    $RadioArray = "OAppChildProc", "ObfusScript", "MacroAPI", "OfficeCreateExe", "OfficeCodeInj", "ScriptDwnlExe", "MailExe", "FileCriteria", "Ransomware", "lsass", "prcCreate", "USB", "OCommChildProc", "PDFChildProc", "WMIPers"
    $ASRGUIDArray = "D4F940AB-401B-4EFC-AADC-AD5F3C50688A", "5BEB7EFE-FD9A-4556-801D-275E5FFC04CC", "92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B", "3B576869-A4EC-4529-8536-B80A7769E899", "75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84", "D3E037E1-3EB8-44C8-A917-57927947596D", "BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550", "01443614-cd74-433a-b99e-2ecdc07bfc25", "c1db55ab-c21a-4637-bb3f-a12568109d35", "9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2", "d1e49aac-8f56-4280-b9ba-993a6d77406c", "b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4", "26190899-1602-49e8-8b27-eb1d0a1ce869", "7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c", "e6db77e5-3df2-4cf1-b95a-636979351e5b"
    $ASRGUIDString = ""
    
    for ($i=0; $i -lt $RadioArray.Length; $i++){
        $RadioCheckA = $RadioArray[$i]+"A"
        $RadioCheckD = $RadioArray[$i]+"D"
        $RadioCheckB = $RadioArray[$i]+"B"
        $ASRGUID = $ASRGUIDArray[$i]
        $RadioEmpty = 0
        
        If ($Form.FindName($RadioCheckA).isChecked -eq 1){$ASRAction = "AuditMode"}
        ElseIf ($Form.FindName($RadioCheckB).isChecked -eq 1){$ASRAction = "Enabled"}
        ElseIf ($Form.FindName($RadioCheckD).isChecked -eq 1){$ASRAction = "Disabled"}
        Else{$RadioEmpty = 1}
        
        If ($RadioEmpty -eq 0){
           
            If ($ASRGUIDString -eq ""){
                $ASRGUIDString = $ASRGUID
                $ASRActions = $ASRAction
                #Write-Host "Set-MpPreference -AttackSurfaceReductionRules_Ids $ASRGUID -AttackSurfaceReductionRules_Actions $ASRAction"
                Set-MpPreference -AttackSurfaceReductionRules_Ids $ASRGUID -AttackSurfaceReductionRules_Actions $ASRAction
            }Else{
                $ASRGUIDString = $ASRGUIDString+", "+$ASRGUID
                $ASRActions = $ASRActions+", "+$ASRAction
                #Write-Host "Add-MpPreference -AttackSurfaceReductionRules_Ids $ASRGUID -AttackSurfaceReductionRules_Actions $ASRAction"
                Add-MpPreference -AttackSurfaceReductionRules_Ids $ASRGUID -AttackSurfaceReductionRules_Actions $ASRAction
            }
        }
    } 
    
    ASRReset
    #Write-Host
    #Write-Host "Setting Successfull"
    #Write-Host ============================================================================
    #Write-Host
    
})





########## Removing All ASR Rules ###########
$btnClear = $Form.FindName("btnClear")
$btnClear.Add_Click({

    #Write-Host ====================================== Clearing ASR Rules ======================================
    #Write-Host 
    
    $RulesIds = Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionRules_Ids
    $RulesIdsArray = @()
    $RulesIdsArray += $RulesIds

    $counter = 0

    ForEach ($j in $RulesIds){

        $ASR = $RulesIdsArray[$counter]
        
        Remove-MpPreference -AttackSurfaceReductionRules_Ids $ASR
        
        #Write-Host "Removing "$ASR

        $counter++

    }
    ASRReset
    #Write-Host
    #Write-Host "Clearing Successfull"
    #Write-Host ============================================================================
    #Write-Host
})


$btnDocs = $Form.FindName("btnDocs")
$btnDocs.Add_Click({
    start ‘https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/attack-surface-reduction’
})

$btnInfo = $Form.FindName("btnInfo")
$btnInfo.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Version 1.0 - 18th May 2020$([System.Environment]::NewLine)Created by Hermann Maurer $([System.Environment]::NewLine)Inspired by Antonio Vasconcelos","Info")
})


########## Creating Report TXT in same Path ###########
$btnReport = $Form.FindName("btnReport")
$btnReport.Add_Click({
    $RulesIds = Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionRules_Ids
    $RulesActions = Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionRules_Actions
    $RulesExclusions = Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionOnlyExclusions
    $RulesIdsArray = @()
    $RulesIdsArray += $RulesIds
    $counter = 0
    $TotalDisabled = 0
    $TotalAudit = 0
    $TotalBlock = 0
    $timeStamp = Get-Date -Format FileDateTime
    $ReportName = "ASR Rules Report " + $timeStamp



    ForEach ($i in $RulesActions){
        If ($RulesActions[$counter] -eq 0){$TotalDisabled++}
        ElseIf ($RulesActions[$counter] -eq 1){$TotalBlock++}
        ElseIf ($RulesActions[$counter] -eq 2){$TotalAudit++}
        $counter++
    }
 
    Set-Content -Path .\$ReportName.txt "====================================== ASR Summary ===================================="
    
    Add-Content -Path .\$ReportName.txt -value (Get-Date)
    Add-Content -Path .\$ReportName.txt -value ("Hostname: " + $env:COMPUTERNAME)
    Add-Content -Path .\$ReportName.txt -value ("=> " + ($RulesIds).Count + " Attack Surface Reduction rules configured")
    Add-Content -Path .\$ReportName.txt -value ("=> "+$TotalDisabled + " in Disabled Mode ** " + $TotalAudit + " in Audit Mode ** " + $TotalBlock + " in Block Mode")

    Add-Content -Path .\$ReportName.txt "" 
    Add-Content -Path .\$ReportName.txt "====================================== ASR Rules ======================================"
    Add-Content -Path .\$ReportName.txt -value ("=> GUID`t`t`t`t`t`tAction Mode`t`tDescription")
    $counter = 0

    ForEach ($j in $RulesIds){
        ## Convert GUID into Rule Name
        If ($RulesIdsArray[$counter] -eq "D4F940AB-401B-4EFC-AADC-AD5F3C50688A"){$RuleName = "Block all Office applications from creating child processes"}
        ElseIf ($RulesIdsArray[$counter] -eq "5BEB7EFE-FD9A-4556-801D-275E5FFC04CC"){$RuleName = "Block execution of potentially obfuscated scripts"}
        ElseIf ($RulesIdsArray[$counter] -eq "92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B"){$RuleName = "Block Win32 API calls from Office macro"}
        ElseIf ($RulesIdsArray[$counter] -eq "3B576869-A4EC-4529-8536-B80A7769E899"){$RuleName = "Block Office applications from creating executable content"}
        ElseIf ($RulesIdsArray[$counter] -eq "75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84"){$RuleName = "Block Office applications from injecting code into other processes"}
        ElseIf ($RulesIdsArray[$counter] -eq "D3E037E1-3EB8-44C8-A917-57927947596D"){$RuleName = "Block JavaScript or VBScript from launching downloaded executable content"}
        ElseIf ($RulesIdsArray[$counter] -eq "BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550"){$RuleName = "Block executable content from email client and webmail"}
        ElseIf ($RulesIdsArray[$counter] -eq "01443614-cd74-433a-b99e-2ecdc07bfc25"){$RuleName = "Block executable files from running unless they meet a prevalence, age, or trusted list criteria"}
        ElseIf ($RulesIdsArray[$counter] -eq "c1db55ab-c21a-4637-bb3f-a12568109d35"){$RuleName = "Use advanced protection against ransomware"}
        ElseIf ($RulesIdsArray[$counter] -eq "9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2"){$RuleName = "Block credential stealing from the Windows local security authority subsystem (lsass.exe)"}
        ElseIf ($RulesIdsArray[$counter] -eq "d1e49aac-8f56-4280-b9ba-993a6d77406c"){$RuleName = "Block process creations originating from PSExec and WMI commands"}
        ElseIf ($RulesIdsArray[$counter] -eq "b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4"){$RuleName = "Block untrusted and unsigned processes that run from USB"}
        ElseIf ($RulesIdsArray[$counter] -eq "26190899-1602-49e8-8b27-eb1d0a1ce869"){$RuleName = "Block Office communication applications from creating child processes"}
        ElseIf ($RulesIdsArray[$counter] -eq "7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c"){$RuleName = "Block Adobe Reader from creating child processes"}
        ElseIf ($RulesIdsArray[$counter] -eq "e6db77e5-3df2-4cf1-b95a-636979351e5b"){$RuleName = "Block persistence through WMI event subscription"}
        ## Check the Action type
        If ($RulesActions[$counter] -eq 0){$RuleAction = "Disabled"}
        ElseIf ($RulesActions[$counter] -eq 1){$RuleAction = "Block   "}
        ElseIf ($RulesActions[$counter] -eq 2){$RuleAction = "Audit   "}
        ## Output Rule Id, Name and Action
        Add-Content -Path .\$ReportName.txt -value ("=> " + $RulesIdsArray[$counter]+ "`t`t" + "Action: " + $RuleAction + "`t" + $RuleName )
        $counter++
    }

    Add-Content -Path .\$ReportName.txt "" 
    Add-Content -Path .\$ReportName.txt "====================================== ASR Exclusions ================================="

    $counter = 0

    ## Output ASR exclusions
    ForEach ($f in $RulesExclusions){
        Add-Content -Path .\$ReportName.txt -value ("=> " + $RulesExclusions[$counter])
        $counter++
    }
})

#Display Form
$Form.ShowDialog() | Out-Null
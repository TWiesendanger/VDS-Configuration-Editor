#region disclaimer
	#===============================================================================
	# PowerShell script sample														
	# Author: Markus Koechl															
	# Copyright (c) Autodesk 2019													
	#																				
	# THIS SCRIPT/CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER     
	# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES   
	# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.    
	#===============================================================================
#endregion

#region ConnectToVault
[System.Reflection.Assembly]::LoadFrom('C:\Program Files (x86)\Autodesk\Autodesk Vault 2019 SDK\bin\x64\Autodesk.Connectivity.WebServices.dll')
$serverID = New-Object Autodesk.Connectivity.WebServices.ServerIdentities
    $serverID.DataServer = "192.168.85.128"
    $serverID.FileServer = "192.168.85.128"
$VaultName = "INV-Samples"
$UserName = "JobProcessor1"
$password = ""
#new in 2019 API: licensing agent enum "Client" "Server" or "None" (=readonly access). 2017 and 2018 required local client installed and licensed
$licenseAgent = [Autodesk.Connectivity.WebServices.LicensingAgent]::Client

$cred = New-Object Autodesk.Connectivity.WebServicesTools.UserPasswordCredentials($serverID, $VaultName, $UserName, $password, $licenseAgent)
$vault = New-Object Autodesk.Connectivity.WebServicesTools.WebServiceManager($cred)

#region ExecuteInVault

$mCustentDefId = ($vault.CustomEntityService.GetAllCustomEntityDefinitions() | Where-Object { $_.DispName -eq "Task"}).Id
$mCustentName = "AU-0269"
$mNewCustent = $vault.CustomEntityService.AddCustomEntity($mCustentDefId , $mCustentName)

$propInstParam = New-Object Autodesk.Connectivity.WebServices.PropInstParam
$propInstParamArray = New-Object Autodesk.Connectivity.WebServices.PropInstParamArray

$PropDefs = $vault.PropertyService.GetPropertyDefinitionsByEntityClassId("CUSTENT")
$propInstParam.PropDefId = ($PropDefs | Where-Object { $_.DispName -eq "Date Start"}).Id
$date = ("2019-05-03T04:00:00.000Z").Replace(".000Z", "")

$propInstParam.Val = [datetime]::ParseExact($date,'yyyy-MM-ddTHH:mm:ss', $null)
$propInstParamArray.Items += $propInstParam


$vault.CustomEntityService.UpdateCustomEntityProperties(@($mNewCustent.Id), $propInstParamArray)

#endregion ExecuteInVault

$vault.Dispose() #don't forget to release the connection


#endregion ConnectToVault
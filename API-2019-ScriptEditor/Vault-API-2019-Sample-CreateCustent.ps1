#region disclaimer
	#==================================================================
	# PowerShell script sample														
	# Author: Markus Koechl															
	# Copyright (c) Autodesk 2017													
	#																				
	# THIS SCRIPT/CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER     
	# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES  
	# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.    
	#==================================================================
#endregion

#region ConnectToVault
		[System.Reflection.Assembly]::LoadFrom('C:\Program Files (x86)\Autodesk\Autodesk Vault 2019 SDK\bin\x64\Autodesk.Connectivity.WebServices.dll')
		$serverID = New-Object Autodesk.Connectivity.WebServices.ServerIdentities
			$serverID.DataServer = "192.168.85.128"
			$serverID.FileServer = "192.168.85.128"
		$VaultName = "INV-Samples"
		$UserName = "CAD Admin"
		$password = ""
		#new in 2019 API: licensing agent enum "Client" "Server" or "None" (=readonly access). 2017 and 2018 required local client installed and licensed
		$licenseAgent = [Autodesk.Connectivity.WebServices.LicensingAgent]::Server
		
		$cred = New-Object Autodesk.Connectivity.WebServicesTools.UserPasswordCredentials($serverID, $VaultName, $UserName, $password, $licenseAgent)
		$vault = New-Object Autodesk.Connectivity.WebServicesTools.WebServiceManager($cred)

		#region ExecuteInVault
		#get custent id for class
		$mCustentDefs = $vault.CustomEntityService.GetAllCustomEntityDefinitions()
		$mClsEntDef = $Global:mCustentDefs | Where-Object { $_.DispName -eq "Class"}
			$vault.CustomEntityService.AddCustomEntity($mClsEntDef.id, "PShell Class")
			

		#endregion ExecuteInVault

		$vault.Dispose() #don't forget to release the connection
#endregion ConnectToVault
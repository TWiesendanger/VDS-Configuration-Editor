#region disclaimer
	#===============================================================================
	# PowerShell script sample														
	# Author: Markus Koechl															
	# Copyright (c) Autodesk 2020													
	#																				
	# THIS SCRIPT/CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER     
	# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES   
	# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.    
	#===============================================================================
#endregion

#region ConnectToVault

		# NOTE - click licensing v3 requires to copy AdskLicensingSDK_3.dll to PowerShell execution folder C:\Windows\System32\WindowsPowerShell\v1.0 before Powershell runtime starts

		Add-Type -Path "C:\Program Files\Autodesk\Autodesk Vault 2021 SDK\bin\x64\Autodesk.Connectivity.WebServices.dll"
		Add-Type -Path "C:\Program Files\Autodesk\Autodesk Vault 2021 SDK\bin\x64\Autodesk.DataManagement.Client.Framework.Vault.Forms.dll"

		$settings = New-Object Autodesk.DataManagement.Client.Framework.Vault.Forms.Settings.LoginSettings 
		$settings.PersistenceKey = "AlwaysTheSameKey"
		$settings.AutoLoginMode = "RestoreAndExecute"
		$connection = [Autodesk.DataManagement.Client.Framework.Vault.Forms.Library]::Login($settings)
		
		$vault = $connection.WebServiceManager

		#region ExecuteInVault

			#query vault, download files, etc....		
			
		#endregion ExecuteInVault
		
		#don't forget to release the connection
		$logOff = [Autodesk.DataManagement.Client.Framework.Vault.Forms.Library]::Logout($connection)

#endregion ConnectToVault
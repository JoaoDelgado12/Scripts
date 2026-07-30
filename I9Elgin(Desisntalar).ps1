$dispositivo = Get-PnpDevice -Class "AudioEndPoint" -PresentOnly | Where-Object {$_.FriendlyName -like "*Fone*"}

if ($dispositivo) {
    $id = $dispositivo.InstanceId
    Write-Host "Desinstalando: $($dispositivo.FriendlyName)..." -ForegroundColor Cyan

    # 2. desinstalar o dispositivo
    Pnputil /remove-device $id
 
	
	$null = Read-Host "Um pausa..."
	
    # 3. Encontrar o dispositivo novamente
    Pnputil /scan-devices -InstanceId $id
    Write-Host "Busca concluida com sucesso!" -ForegroundColor Cyan
	Start-Sleep -Seconds 2
} else {
    Write-Warning "Disposito $($dispositivo.FriendlyName)"
	Start-Sleep -Seconds 2
}
 
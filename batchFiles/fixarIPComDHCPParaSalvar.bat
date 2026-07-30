@echo off
title Configurar IP Fixo e Auxiliar

:: Captura de cor usando o ESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"

:: %ESC%[91m vermelho :: %ESC%[92m verde :: %ESC%[0m branco :: %ESC%[93m Amarelo

:: Informacoes da sua rede

set /p "NOME_CONEXAO= Qual o nome da conexao :"

set /p "IP_PRINCIPAL= Qual o IP PRINCIPAL :"
:testeIP
ping -4 -n 1 %IP_PRINCIPAL% | findstr /i "TTL" > nul
if %errorlevel%==0 (
	set /p IP_PRINCIPAL="IP_PRINCIPAL %IP_PRINCIPAL% ja e utilizado. Coloque outro IP :"
	goto :testeIP
)

set /p "MASCARA_PRINCIPAL= Qual a Mascara Principal %ESC%[93m (opcional) %ESC%[0m :"
if "%MASCARA_PRINCIPAL%"=="" (
	set "MASCARA_PRINCIPAL=255.255.255.0"
	echo MASCARA_PRINCIPAL=255.255.255.0
)

set /p "GATEWAY_PRINCIPAL= Qual o gateway :"
:gatewayVoid
if "%GATEWAY_PRINCIPAL%"=="" (
	set /p GATEWAY_PRINCIPAL="E necessario um gateway :"
	goto :gatewayVoid
)

set /p "DNS_PRIMARIO= Qual o DNS PRIMARIO %ESC%[93m (opcional) %ESC%[0m :"
if "%DNS_PRIMARIO%"=="" (
	set "DNS_PRIMARIO=8.8.8.8"
	echo DNS_PRIMARIO=8.8.8.8
)

set /p "DNS_SECUNDARIO= Qual o DNS SECUNDARIO %ESC%[93m (opcional) %ESC%[0m :"
if "%DNS_SECUNDARIO%"=="" (
	set "DNS_SECUNDARIO=8.8.4.4"
	echo DNS_SECUNDARIO=8.8.4.4
)

set /p "OP= ADICIONAR UM IP SECUNDARIO (S/N) :"

if "%OP%"=="N" (
	goto :passar
)

set /p "IP_AUXILIAR= Qual o IP da catraca %ESC%[93m (opcional) %ESC%[0m :"
if "%IP_AUXILIAR%"=="" (
	set "IP_AUXILIAR=192.168.20.1"
	echo IP_AUXILIAR=192.168.20.1
)

set /p "MASCARA_AUXILIAR= Qual a Mascara do ip da catraca %ESC%[93m (opcional) %ESC%[0m :"
if "%MASCARA_AUXILIAR%"=="" (
	set "MASCARA_AUXILIAR=255.255.255.0"
	echo MASCARA_AUXILIAR=255.255.255.0
)

:passar
:: Definindo IP principal, mascara e gateway...
netsh interface ip set address "%NOME_CONEXAO%" static %IP_PRINCIPAL% %MASCARA_PRINCIPAL% %GATEWAY_PRINCIPAL%
if %errorlevel% neq 0 (
    echo ERRO: Falha ao definir o IP principal. Verifique o nome da conexao e execute como administrador.
    goto :endERROR
)

:: Definindo servidor DNS primario...
netsh interface ip set dns "%NOME_CONEXAO%" static %DNS_PRIMARIO%
if %errorlevel% neq 0 (
    echo ERRO: Falha ao definir o DNS primario.
    goto :endERROR
)

:: Adicionando servidor DNS secundario...
netsh interface ip add dns "%NOME_CONEXAO%" %DNS_SECUNDARIO% index=2
if %errorlevel% neq 0 (
    echo ERRO: Falha ao adicionar o DNS secundario.
	goto :endERROR
)

if "%OP%"=="N" (
	goto :endFim
)

:: Adicionando IP auxiliar...
netsh interface ip add address "%NOME_CONEXAO%" %IP_AUXILIAR% %MASCARA_AUXILIAR%
if %errorlevel% neq 0 (
    echo ERRO: Falha ao adicionar o IP auxiliar.
    goto :endERROR
)

:endFim
echo %ESC%[92m Configuracao concluida com sucesso! %ESC%[0m
pause
exit /b

:endERROR
netsh interface ip set address name="%NOME_CONEXAO%" source=dhcp 
netsh interface ip set dnsservers name="%NOME_CONEXAO%" source=dhcp 
echo %ESC%[93m DHCP ATIVADO %ESC%[0m
pause
exit

:erroSintaxe
echo %ESC%[91m Erro : %ESC%[0m Sintaxe incorreta.
echo Uso correto: %~0 "Nome da Conexao" IP Mascara Gateway DNS1 DNS2 IPAuxiliar MascaraAuxiliar
pause
exit /b
 




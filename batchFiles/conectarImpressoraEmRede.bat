@echo on
title Conectar Impressora de Rede
color 0A

:: Captura de cor usando o ESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"

:: %ESC%[91m vermelho :: %ESC%[92m verde :: %ESC%[0m branco

:: Para a academia
if "%~1"=="" (
    if "%~2"=="" (
		@echo off
		cls
        goto :paraAcademia
    )
)

:: Para o suporte
if "%~1"=="-ip" (
	if not "%~2"=="" (
		if "%~3"=="-imp" (
			if not "%~4"=="" (
				goto :conectar
			)
		)
	)
) else (
	goto :erroSintaxe
)

:: Faltaram parâmetros
:erroSintaxe
echo %ESC%[91mErro: Parametros invalidos ou ausentes.%ESC%[0m
echo Uso correto: %~0 -ip IP_SERVIDOR -imp NOME_IMPRESSORA
pause
exit /b

:conectar
echo =========================================
echo Conectando a impressora %~4
echo IP do servidor: %~2
echo =========================================

echo [1] Verificando conectividade com o servidor...
ping -n 2 -4 %~2 >nul
if errorlevel 1 (
    echo %ESC%[91mERRO: Nao foi possivel acessar o IP %~2.%ESC%[0m
    echo Ocorreu uma expiracao do tempo limite ou host inacessivel.
    pause
    exit /b
)

echo %ESC%[92mOK - Servidor respondendo.%ESC%[0m

echo [2] Adicionando impressora \\%~2\%~4...
rundll32 printui.dll,PrintUIEntry /in /n "\\%~2\%~4" /q
if errorlevel 1 (
    echo.
    echo %ESC%[91mERRO ao adicionar impressora.%ESC%[0m
    echo Motivos possiveis:
    echo - O nome compartilhado nao esta correto
    echo - A impressora nao esta compartilhada no servidor
    echo - Sem permissao de acesso ou driver indisponivel
    pause
    exit /b
)

echo.
echo %ESC%[92m[3] Impressora instalada com sucesso!%ESC%[0m
echo Voce pode verificar em Dispositivos e Impressoras.
pause
exit /b

:paraAcademia
:: Preencha os valores abaixo para usar este bloco fixo
set "pc=NOME_OU_IP_DO_PC"
set "nomeImpressora=NOME_DA_IMPRESSORA_COMPARTILHAMENTO"
rundll32 printui.dll,PrintUIEntry /in /n "\\%pc%\%nomeImpressora%"
exit /b

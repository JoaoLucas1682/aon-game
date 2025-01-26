@echo off
setlocal enabledelayedexpansion
chcp 65001>nul
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do ( set Day=%%a set Month=%%b set Year=%%c )
for /f "tokens=1-4 delims=:,." %%a in ('echo %time%') do ( set Hour=%%a set Minute=%%b set Second=%%c set Millisecond=%%d )
set FormattedDate=%Day%-%Month%-%Year%_%Hour%-%Minute%-%Second%-%Millisecond%

goto init



:init
set /a answer=%random% %% 1001

echo Bem-vindo ao Jogo da Adivinhação!
echo O que deseja fazer:
echo 1. Jogar
echo 2. Histórico de tentativas
echo 3. Avançado
echo 4. Sair
set /p input="Digite um número válido> " 
IF "%input%"=="1" goto game
IF "%input%"=="2" goto histn
IF "%input%"=="3" goto ostngs
IF "%input%"=="4" exit /b

:game
set /p "guess=Adivinhe um número entre 0 e 1000 ou digite ENCERRAR A PARTIDA: "

:check
set /a attempts+=1
if "!guess!"=="ENCERRAR A PARTIDA" goto end
if !guess! equ !answer! (
    echo Parabéns! Você adivinhou corretamente em %attempts% tentativas.
    echo Isso foi salvo no seu histórico
    for /f "tokens=1-4 delims=/ " %%a in ('date /t') do ( set Day=%%a set Month=%%b set Year=%%c )
for /f "tokens=1-4 delims=:,." %%a in ('echo %time%') do ( set Hour=%%a set Minute=%%b set Second=%%c set Millisecond=%%d )
set FormattedDate=%Day%-%Month%-%Year%_%Hour%-%Minute%-%Second%-%Millisecond%
echo %username% advinhou o número %answer% em %attempts% tentativa^(s^)   
    pause
    goto init
) else (
    if !guess! lss !answer! (
        echo Muito baixo! Tente novamente.
    ) else (
        echo Muito alto! Tente novamente.
    )
    set /p "guess=Adivinhe novamente: "
    goto check
)

:ostngs
echo --- AVANÇADO ---
echo 1. Excluir histórico
rem echo 2. Mudar nome
rem echo 3. Reinstalar jogo 
echo 2. Sair do AVANÇADO 

set input=
set /p input="> "
if "%input%"=="1" goto dh
if "%input%"=="2" goto init

:dh
echo ALERTA
echo Tu tem certeza que deseja excluir seu histórico?
echo Você não terá backups e nada do que pode te recuperar este histórico 
echo Digite DELETAR MEU HISTORICO e será deletado seu histórico automaticamente.
echo Se você digitar errado, volta pro início.
set input=
set /p input="> "
if "%input%"=="DELETAR MEU HISTORICO" (
del /f /s /q history\*
) else goto init

:histn
explorer .\history
goto init

:end
echo Você perdeu. A rsposta era: %answer%
echo [ENTER] para voltar pro início
pause>nul
goto init
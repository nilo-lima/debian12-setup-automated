#!/bin/bash
# Script: run_automacao.sh
# Objetivo: Baixar scripts do GitHub, aplicar permissões e executar na ordem correta
set -e
LOGFILE="setup_log_$(date +%Y%m%d_%H%M%S).log"

echo ">>> Iniciando script de automação..." | tee -a "$LOGFILE"

echo ">>> Baixando arquivos do GitHub..." | tee -a "$LOGFILE"

git clone https://github.com/nilo-lima/debian12-setup-automated.git | tee -a "$LOGFILE"
cd debian12-setup-automated

chmod +x setup_automacao_debian12.sh instalacao_de_pacotes.sh

echo ">>> Executando setup_automacao_debian12.sh..." | tee -a "$LOGFILE"
./setup_automacao_debian12.sh 2>&1 | tee -a "$LOGFILE"
# 🚀 Automação de Ambiente Debian 12 para Desenvolvimento

Este projeto tem como objetivo automatizar a configuração de um ambiente completo no Debian 12 (Bookworm) para desenvolvimento, incluindo suporte a:

- Python 3.12
- Docker e Docker Compose
- PostgreSQL Client
- Interface gráfica XFCE com XRDP
- Visual Studio Code com suporte root
- Ferramentas de rede, compilação e produtividade
- Instalação do Ollama para uso de modelos de linguagem locais

---

## 🧰 Scripts incluídos

### `1. setup_automacao_debian12.sh`

Este script realiza a configuração inicial do sistema, incluindo:

- Atualização do sistema e repositórios oficiais do Debian 12.
- Configuração personalizada do Vim.
- Definição de endereço IP estático e DNS.
- Instalação do ambiente gráfico XFCE.
- Instalação e configuração do XRDP para acesso remoto.
- Instalação do Visual Studio Code com execução como root via alias.
- Instalação do **Ollama**.
- Execução do script `instalacao_de_pacotes.sh`.

> Logs detalhados são gerados automaticamente com carimbo de data/hora.

---

### `2. instalacao_de_pacotes.sh`

Script responsável por preparar o ambiente de desenvolvimento com:

- Ferramentas básicas (vim, git, curl, unzip, etc.).
- Ferramentas de rede (nmap, htop, iftop, tcpdump, etc.).
- Bibliotecas necessárias para compilar o Python 3.12.
- Docker + Docker Compose (via repositório oficial).
- PostgreSQL Client.
- Instalação do VSCode e dependências gráficas para desktop remoto.
- Ativação do modo gráfico padrão com XFCE e sessão via XRDP.

> Também possui geração automática de log para rastreabilidade.

---

### `3. run_automacao.sh`

Script opcional que automatiza o download e execução dos scripts anteriores diretamente do GitHub.

Ele realiza:
- Download do repositório via `git clone`.
- Aplicação de permissões de execução.
- Execução sequencial dos scripts com geração de log.

---

## 🚀 Como utilizar

### 1. Clone o repositório

```bash
git clone https://github.com/nilo-lima/debian12-setup-automated.git
cd debian12-setup-automated
```

### 2. Aplique permissões de execução

```bash
chmod 750 run_automacao.sh instalacao_de_pacotes.sh setup_automacao_debian12.sh
```

### 3. Execute o script principal

```bash
bash run_automacao.sh
```

---

## 📦 Requisitos

- Sistema operacional: **Debian 12 Bookworm**
- Permissões de **root** ou `sudo`
- Conexão com a internet
- Ferramenta `git` instalada

---

## 📝 Logs

Todos os scripts geram arquivos de log automaticamente no mesmo diretório da execução, com nomes como:

- `setup_log_YYYYMMDD_HHMMSS.log`
- `script_log_YYYYMMDD_HHMMSS.log`

Esses logs ajudam a auditar as etapas e identificar eventuais falhas.

---

## 👨‍💻 Autor

**NHLJ (Nilo Lima)**  
📧 nilo.lima@gmail.com  
🌐 [github.com/nilo-lima](https://github.com/nilo-lima)

---

## 🛡️ Licença

Este projeto está licenciado sob os termos da [MIT License](LICENSE).

---

## 💡 Sugestões e Contribuições

Pull requests e sugestões são bem-vindas!  
Para propor melhorias ou reportar problemas, abra uma [issue](https://github.com/nilo-lima/debian12-setup-automated/issues) neste repositório.

---

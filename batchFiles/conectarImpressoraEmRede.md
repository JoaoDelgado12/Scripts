# 📘 Documentação: Script de Conexão de Impressora de Rede

Este script em **Batch (`.bat`)** automatiza a instalação e mapeamento de impressoras de rede compartilhadas no Windows. Ele oferece duas formas de uso: uma interativa/pré-configurada (ideal para rotinas locais ou ambientes específicos como academias) e uma via linha de comando para uso rápido do suporte técnico.

---

## 🛠️ Funcionalidades

* **Modo Duplo de Operação:** Suporta execução rápida via parâmetros (linha de comando) ou modo padrão fixo para ambientes específicos.
* **Teste de Conectividade:** Faz um teste de ping prévio no servidor de impressão para garantir que ele está acessível na rede antes de tentar mapear a impressora.
* **Mapeamento Silencioso/Direto:** Utiliza o utilitário nativo do Windows (`printui.dll`) para adicionar a impressora compartilhada de forma limpa.
* **Validação de Sintaxe:** Exibe mensagens de erro amigáveis coloridas caso os parâmetros obrigatórios estejam faltando ou incorretos.

---

## 📋 Pré-requisitos para Execução

1. Sistema Operacional **Windows**.
2. **Permissões:** O usuário precisa ter permissão de rede para acessar o servidor e instalar drivers de impressão na máquina local, assim em dúvida execute como administrador.
3. **Compartilhamento Ativo:** O nome do compartilhamento da impressora no servidor precisa estar correto e acessível.

---

## 🚀 Como Usar o Script

Este script pode ser executado de duas maneiras diferentes, dependendo da sua necessidade:

### Opção 1: Modo Interativo / Padrão (Para a Academia / Uso Local)
Se você rodar o script **sem nenhum argumento** (apenas dando dois cliques nele), ele tentará buscar as variáveis pré-configuradas no código (`:paraAcademia`).
* *Nota:* Para usar esta opção, abra o arquivo em um editor de texto (como o Bloco de Notas) e edite as variáveis `set "pc=..."` e `set "nomeImpressora=..."` no final do código com os dados reais do seu ambiente.

### Opção 2: Modo Linha de Comando (Para o Suporte Técnico)
Ideal para chamadas rápidas via terminal (CMD ou PowerShell) informando o IP do servidor e o nome exato da impressora compartilhada.

**Sintaxe Correta:**
```cmd
nome_do_script.bat -ip IP_DO_SERVIDOR -imp NOME_DA_IMPRESSORA

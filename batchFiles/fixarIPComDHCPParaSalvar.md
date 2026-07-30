# 📘 Documentação: Script de Configuração de IP Fixo e Auxiliar

Este script em **Batch (`.bat`)** automatiza o processo de configuração de endereços IP estáticos no Windows. Ele permite definir um IP principal (com gateway e servidores DNS) e opcionalmente adicionar um IP secundário/auxiliar na mesma interface de rede, além de contar com validações inteligentes de ping e reversão automática para DHCP caso ocorra algum erro.

---

## 🛠️ Funcionalidades

* **Validação de IP Existente:** Verifica na rede se o IP principal informado já está sendo utilizado por outro dispositivo antes de aplicá-lo.
* **Valores Padrão Inteligentes:** Se você pressionar *Enter* sem digitar nada nos campos opcionais (Mascara, DNS, IP Auxiliar), o script assume valores padrão automaticamente.
* **IP Secundário (Auxiliar):** Permite adicionar um segundo endereço IP na mesma placa de rede (muito útil para integração com catracas, impressoras fiscais ou equipamentos de rede específicos).
* **Tratamento de Erros com Rollback:** Caso aconteça alguma falha na aplicação dos comandos de rede, o script reverte a interface automaticamente para **DHCP** para evitar que você fique sem conexão.
* **Interface Colorida:** Utiliza códigos de escape ANSI para destacar avisos e mensagens de sucesso no terminal.

---

## 📋 Pré-requisitos para Execução

1. Sistema Operacional **Windows**.
2. **Executar como Administrador:** O comando `netsh` exige privilégios elevados para alterar as configurações de rede da máquina. Clique com o botão direito no arquivo `.bat` e selecione **"Executar como Administrador"**.
3. **Nome da Conexão de Rede:** Você precisará saber o nome exato da sua interface de rede (geralmente chamada de `Ethernet` ou `Wi-Fi`). Você pode confirmar isso abrindo o Prompt de Comando e digitando `netsh interface show interface`.

---

## 🚀 Como Usar o Script passo a passo

1. Salve o código em um arquivo com a extensão `.bat` (por exemplo: `configura_ip.bat`).
2. Clique com o botão direito no arquivo e escolha **Executar como Administrador**.
3. Siga as instruções interativas solicitadas na tela:
   * **Qual o nome da conexao:** Digite o nome exato (ex: `Ethernet`).
   * **Qual o IP PRINCIPAL:** Digite o IP que deseja fixar. *(O script fará um teste de ping; se o IP estiver em uso, ele pedirá outro).*
   * **Qual a Mascara Principal:** Pressione *Enter* para usar `255.255.255.0` ou digite outra.
   * **Qual o gateway:** Informe o gateway padrão da rede *(obrigatório)*.
   * **Qual o DNS PRIMARIO:** Pressione *Enter* para assumir o padrão do Google (`8.8.8.8`) ou informe outro.
   * **Qual o DNS SECUNDARIO:** Pressione *Enter* para assumir o secundário (`8.8.4.4`) ou informe outro.
   * **ADICIONAR UM IP SECUNDARIO (S/N):** Digite `S` para sim ou `N` para não.
     * Caso digite `S`, informe os dados do IP auxiliar (como o IP da catraca/equipamento) e sua respectiva máscara.

---

## ⚠️ Comportamento em Caso de Erro

Se por algum motivo o script falhar ao aplicar o IP, máscara, gateway ou DNS, ele exibirá uma mensagem de erro vermelha, fará a reversão de segurança ativando o **DHCP** novamente e pausará a execução para que você possa analisar o ocorrido.

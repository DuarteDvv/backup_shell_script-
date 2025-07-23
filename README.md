Permisson: chmod +x backup.sh

Para agendar o script use o Cron

Por exemplo para agendar um script para rodar todo domingo à meia‑noite, siga estes passos:

- Abra o crontab no editor:
crontab -e
- Adicione a seguinte linha:
0 0 * * 0 /caminho/para/seu/script.sh
- Ative o service do seu SO, caso esteja desativado

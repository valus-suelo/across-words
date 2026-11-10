# Across-Words — Godot 4.7 / Android APK

Jogo de palavras cruzadas para celular. **Código do jogo preservado da v0.14**, incluindo o controle horizontal que foi corrigido.

## Como publicar o projeto no repositório

Repositório: https://github.com/valus-suelo/across-words

1. Extraia este arquivo ZIP no computador.
2. Copie o conteúdo da pasta extraída **para a raiz do repositório** (a raiz deve conter `project.godot`, nunca uma pasta extra com esse nome).
3. Inclua o arquivo `.github/workflows/android-apk.yml` (no GitHub web, criar esse arquivo com **Add file > Create new file** também funciona).
4. Confirme o envio (commit) na branch `main`.

## Como obter o APK

1. Abra https://github.com/valus-suelo/across-words/actions
2. Abra a ação **Gerar APK Android (teste)**.
3. Se não iniciar automaticamente, clique em **Run workflow** na branch `main`.
4. Quando concluir com sucesso, baixe **Across-Words-v0.14-Android-APK** em *Artifacts*.
5. Extraia o `.zip` baixado do GitHub. Dentro dele estará o arquivo `across-words-v014-debug.apk`.
6. Transfira o `.apk` para o celular Android e instale, autorizando a instalação de APKs para o aplicativo usado para abri-lo.

## Tecnologia e limitações

- Godot Standard **4.7.2**, retrocompatível com o projeto criado em 4.7.
- Android SDK 35, OpenJDK 17, template Android oficial da mesma versão.
- `arm64-v8a` apenas: a maioria dos celulares Android modernos; aparelhos antigos de 32 bits não são suportados por este APK.
- Assinatura de **debug**, apenas para testes, não publicar na Play Store.
- O workflow recria a chave debug a cada execução. Pode ser necessário desinstalar um APK antigo antes de instalar outra compilação (chaves diferentes).
- O primeiro download dos templates é grande (~1 GB). O GitHub Actions armazena em cache para próximas execuções.
- Os arquivos de CI foram verificados quanto à estrutura, mas **nenhuma execução real no GitHub foi concluída nesta sessão**.
- Para gerar AAB de publicação na Play Store, posteriormente será necessária uma configuração de assinatura de release, com keystore persistente e segura.

## Arquivos importantes

- `project.godot`: configurações do jogo e orientação vertical.
- `main.gd`: jogabilidade, câmera e seleção de letras da versão 0.14.
- `main.tscn`: cena inicial.
- `export_presets.cfg`: preset Android para exportação `.apk` de debug.
- `.github/workflows/android-apk.yml`: pipeline de compilação.
- `.gitignore`: ignora arquivos temporários e chaves de assinatura.

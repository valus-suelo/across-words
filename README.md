# Across-Words v0.17 — Web e Android

Este projeto inclui a versão v0.17 do jogo, a exportação Android e uma ação para publicar a versão Web no GitHub Pages.

## Publicar
1. Envie os arquivos à raiz do repositório, inclusive `.github/workflows/web-pages.yml`.
2. Em GitHub Settings > Pages, escolha **GitHub Actions** como fonte de publicação.
3. Vá a Actions > Publicar jogo no GitHub Pages > Run workflow (ou aguarde o push).
4. Quando a execução terminar com sucesso, acesse `https://valus-suelo.github.io/across-words/`.

O projeto deve estar em repositório público para o Pages gratuito no plano GitHub Free. Caso queira manter o código privado, avalie o suporte do seu plano ou outro serviço de hospedagem.

O workflow exporta HTML5 sem threads, para evitar a necessidade de headers COOP/COEP. O jogo ainda precisa ser testado no navegador, principalmente toque, dimensionamento da tela e áudio.

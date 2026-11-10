# Across-Words v0.15 — Menu e relógio por mapa

Projeto Godot 4.7.2, com exportação Android via GitHub Actions.

## Modos
- **História**: começa com 5 minutos; objetivo é alcançar a saída indicada no tabuleiro. Ao vencer, mostra pontuação e permite avançar para outra fase (o mesmo mapa-base pode se repetir).
- **Infinito**: começa com 6 minutos; não possui saída; objetivo é sobreviver e pontuar.
- **Relógio do mapa**: diminui continuamente enquanto a partida está ativa. Resolver uma palavra **não reinicia nem aumenta o relógio**. Itens de tempo ainda concedem 12 segundos e a penalidade de distância na História pode reduzir 3 segundos.
- **Menu inicial**: permite escolher História ou Infinito; o botão MENU no rodapé volta à seleção.
- **Fim de partida**: resultado com pontuação, repetir/próxima fase e voltar ao menu.

## Compatibilidade
Mantém o controle horizontal corrigido da v0.14 e a configuração ETC2/ASTC do Android.
O workflow `.github/workflows/android-apk.yml` produz `across-words-v015-debug.apk`.

## Limitação
O projeto foi conferido estruturalmente e o ZIP validado, mas não foi executado no Godot nesta sessão. Confirme a compilação no GitHub Actions.

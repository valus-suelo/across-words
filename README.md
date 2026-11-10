# Across-Words v0.14 — correção das setas horizontais

## Diagnóstico confirmado no código
Na v0.13, `_select_anchor_by_arrow` tratava `KEY_LEFT` como incremento de índice e `KEY_RIGHT` como decremento. Isso invertia a navegação horizontal, embora as setas verticais funcionassem.

## Correção
- Ordenação espacial por X crescente para palavras horizontais; Y crescente para verticais.
- Esquerda: índice -1; direita: índice +1; cima: índice -1; baixo: índice +1.
- A primeira tecla escolhe uma casa perto da extremidade correspondente; todas as casas permanecem acessíveis por navegação circular.
- As setas perpendiculares continuam mudando apenas o lado da ramificação.
- Câmera segue a palavra pré-visualizada como antes.
- Arrastar usa o mesmo manipulador das setas, portanto a correção horizontal também vale para o gesto.

## Teste manual
1. Resolva COLHER horizontal. Selecione O com o mouse. Pressione direita: deve ir a L. Pressione esquerda: deve voltar a O.
2. Com COLHER vertical, selecione O. Pressione baixo: deve ir a L. Pressione cima: deve voltar a O.
3. Arraste horizontalmente em área vazia do tabuleiro; deve percorrer letras na direção do gesto.
4. Observe a prévia vertical: ela pode mudar de palavra quando a âncora muda, pois as candidatas dependem da letra selecionada. Isso não deve mudar a ordem das âncoras.

O pacote não foi executado no editor Godot neste ambiente.

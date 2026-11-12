extends Node3D

# Across-Words v0.10 — Godot 4.7, resposta única sincronizada entre teclado, slots e tabuleiro.
const VISIBLE_RADIUS_X := 9
const VISIBLE_RADIUS_Y := 15
const GAP := 1.02
const WORD_TIME := 38.0
const STORY_MAP_TIME := 300.0
const INFINITE_MAP_TIME := 360.0
const ENERGY_MAX := 10
const REGEN_SECONDS := 20.0
const BG := Color("#2a222d")
const BASE := Color("#594551")
const ACTIVE := Color("#a4778d")
const SELECTED := Color("#e4aeb3")
const SOLVED := Color("#876a79")
const CURRENT_LETTER := Color("#ffe2a1")
const MAP_VISION_MOVES := 4
const GOLD := Color("#e6b96d")
const RED := Color("#df667b")

const DICTIONARY := [
    ["CASA", "Lugar onde moramos"], ["SOL", "Estrela que ilumina a Terra"],
    ["LUA", "Satélite natural da Terra"], ["MAR", "Grande extensão de água salgada"],
    ["RIO", "Curso natural de água"], ["FLOR", "Parte colorida de muitas plantas"],
    ["GATO", "Felino doméstico"], ["PATO", "Ave de bico largo"],
    ["ROSA", "Flor frequentemente associada ao amor"], ["VENTO", "Ar em movimento"],
    ["TERRA", "Planeta em que vivemos"], ["PEDRA", "Fragmento sólido de rocha"],
    ["PORTA", "Entrada que pode ser aberta"], ["LIVRO", "Obra formada por páginas"],
    ["PONTE", "Construção para atravessar um obstáculo"], ["TEMPO", "Pode ser medido em segundos"],
    ["NUVEM", "Conjunto de gotículas suspensas no céu"], ["AREIA", "Grãos finos encontrados na praia"],
    ["NOITE", "Período sem luz solar direta"], ["FOLHA", "Parte verde de muitas plantas"],
    ["RATO", "Pequeno roedor"], ["BOLO", "Doce comum em aniversários"],
    ["MESA", "Móvel com tampo e pernas"], ["JANELA", "Abertura que deixa entrar luz"],
    ["CAMPO", "Área aberta de terreno"], ["ESTRELA", "Astro que emite luz própria"],
    ["LAGO", "Corpo de água cercado por terra"], ["MATO", "Vegetação espontânea"],
    ["SAPO", "Anfíbio que costuma saltar"], ["FARO", "Sentido associado ao olfato"],
    ["PENA", "Revestimento do corpo das aves"], ["PRAIA", "Faixa de areia junto ao mar"],
    ["FONTE", "Local de onde brota água"], ["CARTA", "Mensagem escrita em papel"],
    ["TRIGO", "Cereal utilizado para fazer farinha"], ["NORTE", "Um dos pontos cardeais"],
    ["SUL", "Ponto cardeal oposto ao norte"], ["OESTE", "Direção em que o Sol se põe"],
    ["LESTE", "Direção em que o Sol nasce"], ["COROA", "Adorno usado sobre a cabeça"],
    ["OURO", "Metal precioso amarelo"], ["REDE", "Conjunto de fios entrelaçados"],
    ["MUNDO", "O planeta e tudo que nele existe"], ["MURAL", "Pintura feita em uma parede"],
    ["DOCE", "Alimento de sabor açucarado"], ["BARCO", "Embarcação pequena"],
    ["NAVIO", "Embarcação de grande porte"], ["MOTOR", "Máquina que produz movimento"],
    ["TREVO", "Planta associada à sorte"], ["LIMAO", "Fruta cítrica azeda"],
    ["MELAO", "Fruta grande e doce"], ["CINTO", "Acessório usado na cintura"],
    ["PULSO", "Região entre a mão e o antebraço"], ["CANTO", "Ato de cantar"],
    ["BANCO", "Assento comprido ou instituição financeira"], ["BOLSA", "Objeto para carregar pertences"],
    ["LAPIS", "Objeto usado para escrever e desenhar"], ["PAPEL", "Material usado para escrever"],
    ["LINHA", "Traço comprido e estreito"], ["PONTO", "Pequena marca ou sinal"],
    ["TINTA", "Substância usada para pintar"], ["FESTA", "Comemoração com convidados"],
    ["DANCA", "Movimentos do corpo ao ritmo da música"], ["MUSICA", "Arte de organizar sons"],
    ["PRATO", "Utensílio usado para servir comida"], ["GARFO", "Talher com pontas"],
    ["COLHER", "Talher usado para líquidos"], ["FACA", "Utensílio com lâmina cortante"],
    ["AMOR", "Sentimento profundo"], ["AMIGO", "Pessoa de quem se gosta"],
    ["AGUA", "Líquido essencial à vida"], ["ASA", "Parte usada pelas aves para voar"],
    ["AR", "Mistura de gases que respiramos"], ["ANEL", "Joia usada no dedo"],
    ["ABELHA", "Inseto que produz mel"], ["ARTE", "Expressão criativa"],
    ["ANJO", "Ser alado de tradição religiosa"], ["ACERTO", "Resposta correta"],
    ["BOLA", "Objeto redondo usado em jogos"], ["BICO", "Parte da boca de uma ave"],
    ["BEBE", "Criança muito pequena"], ["BRISA", "Vento leve"],
    ["CAMA", "Móvel usado para dormir"], ["COPO", "Recipiente para beber"],
    ["CEU", "Espaço acima da Terra"], ["CUBO", "Sólido de seis faces quadradas"],
    ["DADO", "Cubo usado em jogos"], ["DEDO", "Parte da mão"],
    ["DENTE", "Estrutura usada para mastigar"], ["DIA", "Período de luz solar"],
    ["ECO", "Reflexão de um som"], ["ERVA", "Planta de caule macio"],
    ["ESCOLA", "Lugar de aprender"], ["ESTADO", "Divisão de um país"],
    ["FADA", "Ser mágico dos contos"], ["FOGO", "Chama que aquece"],
    ["FRIO", "Temperatura baixa"], ["FITA", "Faixa de tecido ou papel"],
    ["GEMA", "Parte amarela do ovo"], ["GELO", "Água congelada"],
    ["GALO", "Ave que canta de manhã"], ["GOTA", "Pequena porção de líquido"],
    ["HORA", "Unidade de tempo"], ["HINO", "Canção oficial"],
    ["ILHA", "Terra cercada de água"], ["IMA", "Objeto que atrai ferro"],
    ["IDEIA", "Pensamento ou plano"], ["IOIO", "Brinquedo que sobe e desce"],
    ["JOGO", "Atividade com regras"], ["JARRA", "Recipiente com alça"],
    ["JOIA", "Objeto precioso de adorno"], ["JUIZ", "Pessoa que julga"],
    ["KIWI", "Fruta de casca marrom e polpa verde"], ["KART", "Veículo pequeno de corrida"],
    ["LADO", "Uma das faces ou direções"], ["LEAO", "Grande felino de juba"],
    ["LUZ", "Permite enxergar"], ["LOBO", "Canídeo selvagem"],
    ["MAO", "Extremidade do braço"], ["MALA", "Bagagem de viagem"],
    ["MEL", "Alimento doce produzido por abelhas"], ["MOEDA", "Peça de dinheiro"],
    ["NOME", "Palavra que identifica"], ["NARIZ", "Órgão usado para cheirar"],
    ["OVO", "Produzido por muitas aves"], ["OLHO", "Órgão da visão"],
    ["ONDA", "Movimento do mar"], ["OSSO", "Parte do esqueleto"],
    ["PIPA", "Brinquedo que voa com vento"], ["PEIXE", "Animal aquático"],
    ["PE", "Extremidade inferior da perna"], ["PAZ", "Ausência de guerra"],
    ["QUEIJO", "Alimento feito de leite"], ["QUADRO", "Objeto pendurado na parede"],
    ["QUEDA", "Ato de cair"], ["QUENTE", "De temperatura elevada"],
    ["RUA", "Via pública"], ["REI", "Soberano de um reino"],
    ["RODA", "Peça circular de veículos"], ["RAIZ", "Parte subterrânea da planta"],
    ["SALA", "Cômodo de estar"], ["SELO", "Pequena etiqueta postal"],
    ["SINO", "Objeto que toca ao ser balançado"], ["SUCO", "Bebida de frutas"],
    ["TETO", "Parte superior de um cômodo"], ["TREM", "Veículo que anda em trilhos"],
    ["TATU", "Mamífero de carapaça"], ["TOCA", "Abrigo de animais"],
    ["UVA", "Fruta em cachos"], ["URSO", "Mamífero grande e peludo"],
    ["UNHA", "Estrutura na ponta do dedo"], ["UNIAO", "Ato de juntar"],
    ["VIDA", "Existência de um ser"], ["VACA", "Fêmea do boi"],
    ["VALE", "Região baixa entre elevações"], ["VELA", "Objeto de cera com pavio"],
    ["WEB", "A rede mundial de páginas"], ["WIFI", "Conexão sem fio"],
    ["XADREZ", "Jogo de tabuleiro com peças"], ["XALE", "Peça de tecido sobre os ombros"],
    ["XICARA", "Recipiente para café"], ["XAROPE", "Líquido espesso e doce"],
    ["YOGA", "Prática corporal e meditativa"], ["YAKISOBA", "Prato de macarrão com vegetais"],
    ["ZEBRA", "Animal listrado"], ["ZERO", "Número que representa ausência"],
    ["ZONA", "Região ou área"], ["ZINCO", "Elemento químico metálico"]
]


var board: Dictionary = {}               # Vector2i -> MeshInstance3D
var tile_state: Dictionary = {}          # Vector2i -> String
var visual_nodes: Array[Node3D] = []
var words: Array[Dictionary] = []
var used: Dictionary = {}
var chosen: int = -1
var points: int = 0
var coins: int = 0
var crowns: int = 0
var energy: int = ENERGY_MAX
var combo: int = 0
const HINTS_PER_LEVEL := 3
var hints_remaining: int = HINTS_PER_LEVEL
var regen: float = 0.0
var elapsed: float = 0.0
var enemy_cell := Vector2i(-100, -100)
var enemy_node: MeshInstance3D
var pickups: Dictionary = {}
var game_over: bool = false
var rng := RandomNumberGenerator.new()
var camera: Camera3D
var hud_top: PanelContainer
var hud_bottom: PanelContainer
var hud_keyboard: VBoxContainer
var hud_menu_panel: PanelContainer
var hud_menu_title: Label
var hud_menu_subtitle: Label
var hud_menu_hint: Label
var hud_story_button: Button
var hud_infinite_button: Button
var ui: Control
var score_label: Label
var status_label: Label
var time_label: Label
var crown_label: Label
var energy_label: Label
var clue_label: Label
var entry: LineEdit
var message_label: Label
var selected_info: Label
var letter_slots: HBoxContainer
var material_cache: Dictionary = {}
var last_expire_update: int = -1
var map_vision_moves: int = 0
var path_time: float = STORY_MAP_TIME
var menu_overlay: ColorRect
var mode_button: Button
var typed_buffer: String = ""
var camera_target: Vector3 = Vector3(0, 25, 1.4)
var visible_origin: Vector2i = Vector2i(999999, 999999)
var shared_tile_mesh: BoxMesh
var pointer_start: Vector2 = Vector2.ZERO
var pointer_cell: Vector2i = Vector2i.ZERO
var pointer_down: bool = false
var pointer_dragged: bool = false
var pointer_pan: bool = false
var level_mode: bool = false
var exit_cell := Vector2i(0, -24)
const LEVEL_SAFE_RADIUS := 35
const CAMPAIGN_LEVELS := 10
const LEVEL_HALO := 9
const LEVEL_INTRO_SECONDS := 3.4
var level_intro_remaining: float = 0.0
var level_intro_start_size: float = 18.0

func _level_half_size() -> int:
    return 5 + clampi(level_number, 1, CAMPAIGN_LEVELS) - 1

func _inside_level(cell: Vector2i) -> bool:
    if not level_mode:
        return true
    var radius: int = _level_half_size()
    return absi(cell.x) <= radius and absi(cell.y) <= radius

func _inside_level_halo(cell: Vector2i) -> bool:
    if not level_mode:
        return true
    var radius: int = _level_half_size() + LEVEL_HALO
    return absi(cell.x) <= radius and absi(cell.y) <= radius

# Uma tentativa não altera words, used nem o tabuleiro permanente.
var preview: Dictionary = {}
var drafts: Dictionary = {}  # chave parent:anchor -> {text, dir}; permanece até CONFIRMAR
var preview_parent: int = -1
var preview_anchor: int = -1
var preview_dir := Vector2i.ZERO
var preview_choices: Array[Dictionary] = []
var preview_choice_index: int = 0
var direction_left: Button
var direction_right: Button
var next_clue_button: Button
var input_syncing: bool = false
var extra_branch_armed: bool = false
var last_solved_word: int = -1  # palavra mais recente para navegação sem clique
# Direção de ramificação e direção da última varredura de letras.
var preferred_branch_direction: Vector2i = Vector2i.ZERO
var last_navigation_arrow: Vector2i = Vector2i.ZERO
# Acumulador de deslocamento para gestos contínuos, em qualquer casa da área 3D.
var gesture_cursor: Vector2 = Vector2.ZERO
const DRAG_STEP_PX := 40.0
var result_overlay: ColorRect
var result_title: Label
var result_stats: Label
var result_action: Button
var level_number: int = 1
var run_points: int = 0
var completed_levels: Array[Dictionary] = []
var level_route: Array[Vector2i] = []
var word_bank: Array[Dictionary] = []
var words_by_initial: Dictionary = {}
var current_category: String = "GERAL"
var fixed_branch_answers: Dictionary = {}
var camera_pan_offset: Vector2 = Vector2.ZERO
var camera_zoom_factor: float = 1.0
var active_touches: Dictionary = {}
var pinch_last_distance: float = 0.0
var suppress_touch_until_release: bool = false
var panning_board: bool = false
var pan_last_screen: Vector2 = Vector2.ZERO
var hud_gesture_fade: bool = false
var hud_restore_delay: float = 0.0
const HUD_IDLE_ALPHA := 0.92
const HUD_GESTURE_ALPHA := 0.10

func _ready() -> void:
    get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND
    rng.randomize()
    _load_word_bank()
    _make_world()
    _make_ui()
    get_viewport().size_changed.connect(_layout_hud)
    _layout_hud()
    _new_game()
    _show_main_menu()

func _load_word_bank() -> void:
    word_bank.clear()
    words_by_initial.clear()
    var file := FileAccess.open("res://data/words.json", FileAccess.READ)
    if file != null:
        var parsed: Variant = JSON.parse_string(file.get_as_text())
        if parsed is Dictionary and parsed.has("words") and parsed["words"] is Array:
            for record in parsed["words"]:
                if not record is Dictionary:
                    continue
                var answer: String = String(record.get("answer", "")).to_upper()
                var clue: String = String(record.get("clue", "")).strip_edges()
                if answer.length() < 2 or clue.is_empty():
                    continue
                var valid: bool = true
                for letter in answer:
                    if letter < "A" or letter > "Z":
                        valid = false
                        break
                if not valid:
                    continue
                var item: Dictionary = {
                    "answer": answer,
                    "clue": clue,
                    "category": String(record.get("category", "GERAL")),
                    "difficulty": clampi(int(record.get("difficulty", 1)), 1, 3)
                }
                word_bank.append(item)
    if word_bank.is_empty():
        for pair in DICTIONARY:
            word_bank.append({"answer": String(pair[0]), "clue": String(pair[1]), "category": "GERAL", "difficulty": 1})
    for item in word_bank:
        var initial: String = String(item["answer"]).substr(0, 1)
        if not words_by_initial.has(initial):
            words_by_initial[initial] = []
        words_by_initial[initial].append(item)
    print("Across-Words: %d palavras carregadas" % word_bank.size())

func _word_difficulty_allowed(item: Dictionary) -> bool:
    if not level_mode:
        return true
    var allowed: int = 1 if level_number <= 2 else (2 if level_number <= 5 else 3)
    var difficulty: int = int(item.get("difficulty", 1))
    if level_number >= 9:
        return difficulty >= 2 and difficulty <= allowed
    if level_number >= 7:
        return difficulty <= allowed
    return difficulty <= allowed

func _choose_start_word() -> Dictionary:
    var pool: Array[Dictionary] = []
    for item in word_bank:
        var length: int = String(item["answer"]).length()
        if length < 4 or length > 8 or not _word_difficulty_allowed(item):
            continue
        if level_mode and level_number <= 2 and int(item["difficulty"]) != 1:
            continue
        if level_mode and level_number >= 7 and int(item["difficulty"]) < 2:
            continue
        pool.append(item)
    if pool.is_empty():
        return word_bank[rng.randi_range(0, word_bank.size() - 1)]
    return pool[rng.randi_range(0, pool.size() - 1)]

func _material_cached(name: String, color: Color, glow: bool = false) -> StandardMaterial3D:
    if material_cache.has(name):
        return material_cache[name]
    var mat := StandardMaterial3D.new()
    mat.albedo_color = color
    mat.roughness = 0.84
    if glow:
        mat.emission_enabled = true
        mat.emission = color
        mat.emission_energy_multiplier = 0.35
    material_cache[name] = mat
    return mat

func _make_world() -> void:
    var environment := WorldEnvironment.new()
    var env := Environment.new()
    env.background_mode = Environment.BG_COLOR
    env.background_color = BG
    env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
    env.ambient_light_color = Color.WHITE
    env.ambient_light_energy = 0.9
    environment.environment = env
    add_child(environment)
    var light := DirectionalLight3D.new()
    light.rotation_degrees = Vector3(-55, 25, 15)
    light.light_energy = 1.05
    add_child(light)
    camera = Camera3D.new()
    camera.projection = Camera3D.PROJECTION_ORTHOGONAL
    camera.size = 20.0
    camera.position = Vector3(0, 25, 1.4)
    camera.rotation_degrees = Vector3(-90, 0, 0)
    camera.current = true
    add_child(camera)
    shared_tile_mesh = BoxMesh.new()
    shared_tile_mesh.size = Vector3(0.94, 0.17, 0.94)
    # Os blocos visíveis são criados após a interface estar pronta.

func _panel_style(fill: Color, edge: Color) -> StyleBoxFlat:
    var style := StyleBoxFlat.new()
    style.bg_color = fill
    style.border_color = edge
    style.set_border_width_all(2)
    style.set_corner_radius_all(22)
    style.content_margin_left = 16
    style.content_margin_right = 16
    style.content_margin_top = 10
    style.content_margin_bottom = 10
    return style

func _make_label(text_value: String, size: int = 23) -> Label:
    var label := Label.new()
    label.text = text_value
    label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
    label.add_theme_font_size_override("font_size", size)
    label.add_theme_color_override("font_color", Color("#f9dfe0"))
    return label

func _layout_hud() -> void:
    if not is_instance_valid(hud_top) or not is_instance_valid(hud_bottom):
        return
    var screen: Vector2 = get_viewport().get_visible_rect().size
    if screen.x < 1.0 or screen.y < 1.0:
        return
    var wide: bool = screen.x > screen.y
    var compact: bool = screen.x < 660.0
    hud_top.set_anchors_and_offsets_preset(Control.PRESET_TOP_WIDE)
    hud_top.offset_left = 0.0
    hud_top.offset_right = 0.0
    hud_top.offset_top = 0.0
    hud_top.offset_bottom = 112.0 if wide else 145.0

    # Teclado centralizado, com largura maxima (como no Termo).
    # Nao estica as teclas ate as bordas de monitores ultrawide.
    var keyboard_width: float = minf(screen.x - 12.0, 900.0 if wide else 720.0)
    hud_bottom.anchor_left = 0.5
    hud_bottom.anchor_right = 0.5
    hud_bottom.anchor_top = 1.0
    hud_bottom.anchor_bottom = 1.0
    hud_bottom.offset_left = -keyboard_width * 0.5
    hud_bottom.offset_right = keyboard_width * 0.5
    hud_bottom.offset_top = -365.0 if wide else -405.0
    hud_bottom.offset_bottom = 0.0

    var key_height: float = 57.0 if wide else 60.0
    var key_font: int = 20 if wide else 21
    for key_row in hud_keyboard.get_children():
        for key_button in key_row.get_children():
            if key_button is Button:
                key_button.custom_minimum_size.y = key_height
                key_button.add_theme_font_size_override("font_size", key_font)

    if is_instance_valid(hud_menu_panel):
        # Tamanho maior no computador, limitado pelo viewport para nao cortar no celular.
        var menu_width: float = minf(screen.x - 28.0, 900.0 if wide else 590.0)
        var menu_height: float = minf(screen.y - 28.0, 620.0 if wide else 530.0)
        hud_menu_panel.custom_minimum_size = Vector2(menu_width, menu_height)
        hud_menu_title.add_theme_font_size_override("font_size", 56 if wide else 40)
        hud_menu_subtitle.add_theme_font_size_override("font_size", 28 if wide else 23)
        hud_menu_hint.add_theme_font_size_override("font_size", 20 if wide else 17)
        hud_story_button.custom_minimum_size.y = 92.0 if wide else 75.0
        hud_infinite_button.custom_minimum_size.y = 92.0 if wide else 75.0
        hud_story_button.add_theme_font_size_override("font_size", 25 if wide else 20)
        hud_infinite_button.add_theme_font_size_override("font_size", 25 if wide else 20)

    camera.size = (23.0 if wide else 27.0) if map_vision_moves > 0 else (17.0 if wide else 20.0)
    visible_origin = Vector2i(999999, 999999)
    _sync_visible_board(true)

func _make_ui() -> void:
    var layer := CanvasLayer.new()
    add_child(layer)
    ui = Control.new()
    ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
    layer.add_child(ui)

    var top := PanelContainer.new()
    hud_top = top
    top.set_anchors_and_offsets_preset(Control.PRESET_TOP_WIDE)
    top.offset_bottom = 152.0
    top.add_theme_stylebox_override("panel", _panel_style(Color(0.22, 0.17, 0.23, 0.22), Color(0.47, 0.33, 0.37, 0.28)))
    ui.add_child(top)
    var top_column := VBoxContainer.new()
    top_column.add_theme_constant_override("separation", 3)
    top.add_child(top_column)
    var title := _make_label("ACROSS-WORDS", 24)
    top_column.add_child(title)
    var indicators := HBoxContainer.new()
    indicators.alignment = BoxContainer.ALIGNMENT_CENTER
    indicators.add_theme_constant_override("separation", 10)
    top_column.add_child(indicators)
    time_label = _make_label("TEMPO 0:38", 19)
    crown_label = _make_label("COROAS 0/3", 19)
    energy_label = _make_label("ENERGIA 10/10", 19)
    indicators.add_child(time_label)
    indicators.add_child(crown_label)
    indicators.add_child(energy_label)
    score_label = _make_label("PONTOS 0  |  MOEDAS 0  |  COMBO 0", 17)
    top_column.add_child(score_label)
    var clue_panel := PanelContainer.new()
    clue_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.50, 0.34, 0.43, 0.38), Color(0.93, 0.72, 0.78, 0.45)))
    top_column.add_child(clue_panel)
    clue_label = _make_label("Resolva a palavra destacada para começar.", 22)
    clue_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    clue_label.custom_minimum_size.y = 45
    clue_label.add_theme_color_override("font_color", Color("#fff1d8"))
    var clue_row := HBoxContainer.new()
    clue_panel.add_child(clue_row)
    clue_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    clue_row.add_child(clue_label)
    next_clue_button = Button.new()
    next_clue_button.text = "💡 3"
    next_clue_button.tooltip_text = "Trocar pista (3 por fase)"
    next_clue_button.pressed.connect(_next_preview_clue)
    clue_row.add_child(next_clue_button)

    var bottom := PanelContainer.new()
    hud_bottom = bottom
    bottom.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_WIDE)
    bottom.offset_top = -430.0
    bottom.add_theme_stylebox_override("panel", _panel_style(Color(0.22, 0.17, 0.23, 0.22), Color(0.47, 0.33, 0.37, 0.28)))
    ui.add_child(bottom)
    var column := VBoxContainer.new()
    column.add_theme_constant_override("separation", 3)
    bottom.add_child(column)
    selected_info = _make_label("TOQUE NUMA PALAVRA OU LETRA", 16)
    selected_info.visible = false
    column.add_child(selected_info)
    entry = LineEdit.new()
    entry.placeholder_text = "Entrada interna"
    entry.virtual_keyboard_enabled = false
    entry.max_length = 18
    entry.alignment = HORIZONTAL_ALIGNMENT_CENTER
    # Entrada interna: não é exibida como caixa de texto.
    # No Android, o botão de teclado pode focá-la para abrir o teclado nativo.
    entry.custom_minimum_size = Vector2(1, 1)
    entry.modulate.a = 0.0
    entry.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
    entry.add_theme_font_size_override("font_size", 1)
    entry.text_submitted.connect(func(_value: String): _submit())
    entry.text_changed.connect(_on_entry_changed)
    column.add_child(entry)
    letter_slots = HBoxContainer.new()
    letter_slots.alignment = BoxContainer.ALIGNMENT_CENTER
    letter_slots.add_theme_constant_override("separation", 4)
    letter_slots.visible = false
    column.add_child(letter_slots)
    var direction_row := HBoxContainer.new()
    direction_row.add_theme_constant_override("separation", 8)
    column.add_child(direction_row)
    direction_left = Button.new()
    direction_left.text = "↑ CIMA"
    direction_left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    direction_left.custom_minimum_size.y = 44
    direction_left.pressed.connect(func(): _set_preview_direction(-1))
    direction_row.add_child(direction_left)
    direction_right = Button.new()
    direction_right.text = "↓ BAIXO"
    direction_right.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    direction_right.custom_minimum_size.y = 44
    direction_right.pressed.connect(func(): _set_preview_direction(1))
    direction_row.add_child(direction_right)
    if preview_parent >= 0 and preview_parent < words.size():
        var source: Dictionary = words[preview_parent]
        var source_name: String = String(source["answer"])
        selected_info.text = "ORIGEM: %s  ·  LETRA %d/%d" % [source_name, preview_anchor + 1, source_name.length()]
    direction_left.visible = false
    direction_right.visible = false
    var actions := HBoxContainer.new()
    actions.add_theme_constant_override("separation", 12)
    column.add_child(actions)
    var confirm := Button.new()
    confirm.text = "CONFIRMAR"
    confirm.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    confirm.custom_minimum_size.y = 46
    confirm.add_theme_font_size_override("font_size", 22)
    confirm.pressed.connect(_submit)
    actions.add_child(confirm)
    var buy := Button.new()
    buy.text = "+ RAMO (3)"
    buy.custom_minimum_size = Vector2(148, 46)
    buy.add_theme_font_size_override("font_size", 18)
    buy.pressed.connect(_buy_path)
    actions.add_child(buy)
    message_label = _make_label("", 17)
    message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    message_label.custom_minimum_size.y = 26
    column.add_child(message_label)
    # Teclado integrado à HUD: sempre visível durante a partida.
    var keyboard := VBoxContainer.new()
    hud_keyboard = keyboard
    keyboard.add_theme_constant_override("separation", 4)
    column.add_child(keyboard)
    _add_keyboard_row(keyboard, "QWERTYUIOP")
    _add_keyboard_row(keyboard, "ASDFGHJKL")
    _add_keyboard_row(keyboard, "ZXCVBNM", true)
    # Controles de sessao no topo, fora do teclado.
    var header_buttons := HBoxContainer.new()
    header_buttons.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT)
    header_buttons.offset_left = -215.0
    header_buttons.offset_right = -8.0
    header_buttons.offset_top = 8.0
    header_buttons.offset_bottom = 44.0
    header_buttons.add_theme_constant_override("separation", 6)
    ui.add_child(header_buttons)
    mode_button = Button.new()
    mode_button.text = "MENU"
    mode_button.focus_mode = Control.FOCUS_NONE
    mode_button.custom_minimum_size = Vector2(92, 34)
    mode_button.pressed.connect(_show_main_menu)
    header_buttons.add_child(mode_button)
    var restart := Button.new()
    restart.text = "REINICIAR"
    restart.focus_mode = Control.FOCUS_NONE
    restart.custom_minimum_size = Vector2(106, 34)
    restart.pressed.connect(_new_game)
    header_buttons.add_child(restart)
    status_label = _make_label("Arraste para selecionar", 14)
    status_label.visible = false

    # Tela modal acima da HUD. Só é exibida no fim da partida.
    var result_layer := CanvasLayer.new()
    result_layer.layer = 10
    add_child(result_layer)
    result_overlay = ColorRect.new()
    result_overlay.color = Color(0.10, 0.07, 0.12, 0.91)
    result_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    result_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
    result_layer.add_child(result_overlay)
    var result_center := CenterContainer.new()
    result_center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    result_overlay.add_child(result_center)
    var result_panel := PanelContainer.new()
    result_panel.custom_minimum_size = Vector2(560, 390)
    result_panel.add_theme_stylebox_override("panel", _panel_style(Color("#382b39"), Color("#ad8193")))
    result_center.add_child(result_panel)
    var result_column := VBoxContainer.new()
    result_column.add_theme_constant_override("separation", 22)
    result_panel.add_child(result_column)
    result_title = _make_label("FIM DE JOGO", 42)
    result_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    result_column.add_child(result_title)
    result_stats = _make_label("", 25)
    result_stats.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    result_stats.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    result_column.add_child(result_stats)
    result_action = Button.new()
    result_action.text = "JOGAR NOVAMENTE"
    result_action.custom_minimum_size.y = 72
    result_action.pressed.connect(_result_continue)
    result_column.add_child(result_action)
    var result_menu := Button.new()
    result_menu.text = "VOLTAR AO MENU"
    result_menu.custom_minimum_size.y = 56
    result_menu.pressed.connect(_show_main_menu)
    result_column.add_child(result_menu)
    result_overlay.hide()

    # Menu inicial separado da HUD e da tela de resultado.
    var menu_layer := CanvasLayer.new()
    menu_layer.layer = 20
    add_child(menu_layer)
    menu_overlay = ColorRect.new()
    menu_overlay.color = Color("#201924")
    menu_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    menu_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
    menu_layer.add_child(menu_overlay)
    var menu_center := CenterContainer.new()
    menu_center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    menu_overlay.add_child(menu_center)
    var menu_panel := PanelContainer.new()
    hud_menu_panel = menu_panel
    menu_panel.custom_minimum_size = Vector2(590, 540)
    menu_panel.add_theme_stylebox_override("panel", _panel_style(Color("#382b39"), Color("#ad8193")))
    menu_center.add_child(menu_panel)
    var menu_col := VBoxContainer.new()
    menu_col.add_theme_constant_override("separation", 22)
    menu_panel.add_child(menu_col)
    var menu_title := _make_label("ACROSS-WORDS", 42)
    hud_menu_title = menu_title
    menu_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    menu_col.add_child(menu_title)
    var subtitle := _make_label("Escolha sua aventura", 23)
    hud_menu_subtitle = subtitle
    subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    menu_col.add_child(subtitle)
    var story := Button.new()
    hud_story_button = story
    story.text = "HISTÓRIA  ·  ENCONTRE A SAÍDA"
    story.custom_minimum_size.y = 80
    story.pressed.connect(func() -> void: _start_mode(true))
    menu_col.add_child(story)
    var infinite := Button.new()
    hud_infinite_button = infinite
    infinite.text = "INFINITO  ·  SOBREVIVA"
    infinite.custom_minimum_size.y = 80
    infinite.pressed.connect(func() -> void: _start_mode(false))
    menu_col.add_child(infinite)
    var hint := _make_label("Um relógio por mapa. O tempo não reinicia ao resolver palavras.", 18)
    hud_menu_hint = hint
    hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    menu_col.add_child(hint)

func _add_keyboard_row(parent: VBoxContainer, letters: String, with_erase: bool = false) -> void:
    var keys := HBoxContainer.new()
    keys.alignment = BoxContainer.ALIGNMENT_CENTER
    keys.add_theme_constant_override("separation", 4)
    parent.add_child(keys)
    for i in range(letters.length()):
        var character: String = letters.substr(i, 1)
        var key_button := Button.new()
        key_button.text = character
        key_button.focus_mode = Control.FOCUS_NONE
        key_button.custom_minimum_size.y = 52
        key_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        key_button.add_theme_font_size_override("font_size", 22)
        key_button.add_theme_stylebox_override("normal", _panel_style(Color("#604957"), Color("#8d6b7b")))
        key_button.add_theme_stylebox_override("hover", _panel_style(Color("#8a6577"), Color("#d7afbb")))
        key_button.add_theme_stylebox_override("pressed", _panel_style(Color("#b88b9f"), Color("#f1cbd7")))
        key_button.pressed.connect(_type_character.bind(character))
        keys.add_child(key_button)
    if with_erase:
        var erase_button := Button.new()
        erase_button.text = "APAGAR"
        erase_button.tooltip_text = "Apagar última letra"
        erase_button.focus_mode = Control.FOCUS_NONE
        erase_button.custom_minimum_size = Vector2(88, 43)
        erase_button.add_theme_font_size_override("font_size", 24)
        erase_button.pressed.connect(_erase_character)
        keys.add_child(erase_button)

func _show_main_menu() -> void:
    game_over = true
    if is_instance_valid(result_overlay):
        result_overlay.hide()
    if is_instance_valid(menu_overlay):
        menu_overlay.show()
    if is_instance_valid(entry):
        entry.release_focus()

func _start_mode(story: bool) -> void:
    level_mode = story
    level_number = 1
    run_points = 0
    completed_levels.clear()
    _new_game()
    menu_overlay.hide()
    _message("HISTÓRIA: encontre a saída!" if story else "INFINITO: sobreviva e acumule pontos!")

func _run_summary() -> String:
    var summary: String = "Fases concluídas: %d  |  Pontos totais: %d" % [completed_levels.size(), run_points + points]
    if level_mode:
        for record in completed_levels:
            summary += "\nFase %d: %d/3 coroas · %d pontos" % [record["level"], record["crowns"], record["points"]]
    return summary

func _show_result(victory: bool, reason: String) -> void:
    if game_over and result_overlay.visible:
        return
    game_over = true
    if victory and level_mode:
        var time_penalty: int = int(elapsed) * (2 + level_number)
        points = maxi(0, points - time_penalty)
        completed_levels.append({"level": level_number, "crowns": mini(crowns, 3), "points": points})
    result_title.text = "FASE CONCLUÍDA!" if victory else "GAME OVER"
    result_title.add_theme_color_override("font_color", Color("#e5bd74") if victory else Color("#df7587"))
    if level_mode:
        result_stats.text = "%s\n\nCoroas opcionais: %d/3 · Bônus: %d pontos\nTempo: %d:%02d · Penalidade de tempo: %d pontos\n\n%s\n\nPalavras nesta fase: %d" % [reason, crowns, crowns * 500, int(elapsed) / 60, int(elapsed) % 60, int(elapsed) * (2 + level_number), _run_summary(), _solved_count()]
    else:
        result_stats.text = "%s\n\nPontuação: %d\nPalavras: %d  ·  Combo: %d" % [reason, points, _solved_count(), combo]
    result_action.text = ("RECOMEÇAR CAMPANHA" if level_number >= CAMPAIGN_LEVELS else "PRÓXIMO NÍVEL") if victory and level_mode else ("NOVA PARTIDA" if not victory else "CONTINUAR")
    result_overlay.show()

func _result_continue() -> void:
    if result_title.text == "FASE CONCLUÍDA!":
        run_points += points
        level_number += 1
        if level_number > CAMPAIGN_LEVELS:
            level_number = 1
            run_points = 0
            completed_levels.clear()
    else:
        level_number = 1
        run_points = 0
        completed_levels.clear()
    _new_game()

func _new_game() -> void:
    for node in visual_nodes:
        if is_instance_valid(node): node.queue_free()
    visual_nodes.clear()
    if is_instance_valid(enemy_node): enemy_node.queue_free()
    enemy_node = null
    words.clear()
    used.clear()
    pickups.clear()
    chosen = -1
    last_solved_word = -1
    preferred_branch_direction = Vector2i.ZERO
    last_navigation_arrow = Vector2i.ZERO
    if is_instance_valid(result_overlay):
        result_overlay.hide()
    preview.clear()
    drafts.clear()
    fixed_branch_answers.clear()
    preview_parent = -1
    preview_anchor = -1
    preview_dir = Vector2i.ZERO
    preview_choices.clear()
    preview_choice_index = 0
    extra_branch_armed = false
    points = 0
    coins = 0
    crowns = 0
    energy = ENERGY_MAX
    combo = 0
    hints_remaining = HINTS_PER_LEVEL
    regen = 0.0
    elapsed = 0.0
    path_time = STORY_MAP_TIME if level_mode else INFINITE_MAP_TIME
    map_vision_moves = 0
    _layout_hud()
    typed_buffer = ""
    camera_pan_offset = Vector2.ZERO
    camera_zoom_factor = 1.0
    active_touches.clear()
    pinch_last_distance = 0.0
    suppress_touch_until_release = false
    hud_gesture_fade = false
    hud_restore_delay = 0.0
    if is_instance_valid(hud_top):
        hud_top.modulate.a = HUD_IDLE_ALPHA
    if is_instance_valid(hud_bottom):
        hud_bottom.modulate.a = HUD_IDLE_ALPHA
    camera_target = Vector3(0, 25, 1.4)
    camera.position = camera_target
    level_intro_remaining = 0.0
    camera.size = 18.0
    game_over = false
    enemy_cell = Vector2i(-100, -100)
    var initial: Dictionary = _choose_start_word()
    current_category = String(initial["category"])
    var first_answer: String = String(initial["answer"])
    var first: Dictionary = {"answer": first_answer, "clue": String(initial["clue"]), "category": current_category, "difficulty": int(initial["difficulty"]), "start": Vector2i(-int(first_answer.length() / 2), 0), "dir": Vector2i(1, 0), "time": WORD_TIME, "state": "solved", "spawned": false}
    words.append(first)
    used[first_answer] = true
    if level_mode:
        _plan_level()
        _place_campaign_objectives()
    if not level_mode:
        _spawn_pickup(Vector2i(4, -2), "coin")
        _spawn_pickup(Vector2i(-4, 3), "energy")
        _spawn_pickup(Vector2i(-5, -3), "vision")
    else:
        _place_level_resources()
        if level_number >= 7:
            _spawn_enemy()
    if not level_mode:
        _spawn_pickup(Vector2i(3, 4), "crown")
    # A palavra inicial ja aparece resolvida nos dois modos.
    # Seleciona automaticamente sua primeira letra para liberar as setas,
    # as pistas de ramificacao e a digitacao sem clicar no tabuleiro.
    _assign_entry("")
    entry.release_focus()
    _sync_visible_board(true)
    last_navigation_arrow = Vector2i.ZERO
    last_solved_word = 0
    _focus_word(words[0])
    if level_mode:
        level_intro_remaining = LEVEL_INTRO_SECONDS
        level_intro_start_size = maxf(18.0, float(_level_half_size() * 2 + 4) * GAP * 1.65)
        camera.size = level_intro_start_size
        camera.position = Vector3(0.0, 25.0, 0.0)
    _refresh_board()
    _message("A palavra %s ja esta pronta. Use as setas para escolher a letra e o lado da proxima palavra!" % first_answer)

# Constrói uma rota possível sem revelar nem fixar as palavras no mapa.
# A simulação é revertida; o jogador continua livre para escolher seus ramos.
func _place_first_level_objectives() -> void:
    # Tres coroas distintas em casas livres do quadrado 11x11.
    # A saida fica na regiao de um canto, longe da palavra inicial.
    var corners: Array[Vector2i] = [
        Vector2i(-5, -5), Vector2i(-5, 5),
        Vector2i(5, -5), Vector2i(5, 5)
    ]
    exit_cell = corners[rng.randi_range(0, corners.size() - 1)]
    var occupied_start: Array[Vector2i] = _cells(words[0])
    var available: Array[Vector2i] = []
    for y in range(-5, 6):
        for x in range(-5, 6):
            var cell: Vector2i = Vector2i(x, y)
            if cell == exit_cell or occupied_start.has(cell):
                continue
            available.append(cell)
    available.shuffle()
    for i in range(3):
        _spawn_pickup(available[i], "crown")
    level_route = occupied_start.duplicate()

# Objetivos independentes do planejador de rotas: presentes em todas as fases.
func _place_campaign_objectives() -> void:
    # Remove coroas de uma simulacao anterior; nao interfere com outros itens.
    for cell in pickups.keys():
        if pickups[cell] == "crown":
            pickups.erase(cell)
    var radius: int = _level_half_size()
    var start_cells: Array[Vector2i] = _cells(words[0])
    var corners: Array[Vector2i] = [
        Vector2i(-radius, -radius), Vector2i(radius, -radius),
        Vector2i(-radius, radius), Vector2i(radius, radius)
    ]
    corners.shuffle()
    var corner: Vector2i = corners[0]
    var exit_options: Array[Vector2i] = []
    var inset: int = 1 if level_number <= 3 else 2
    for dy in range(inset + 1):
        for dx in range(inset + 1):
            var candidate: Vector2i = corner + Vector2i(-signi(corner.x) * dx, -signi(corner.y) * dy)
            if not start_cells.has(candidate):
                exit_options.append(candidate)
    exit_cell = exit_options[rng.randi_range(0, exit_options.size() - 1)]
    # Cada coroa ocupa uma regiao diferente e nao sobrepoe saida/origem.
    var regions: Array[Vector2i] = corners.slice(1)
    var occupied: Dictionary = {exit_cell: true}
    for cell in start_cells:
        occupied[cell] = true
    for region in regions:
        var candidates: Array[Vector2i] = []
        for y in range(-radius, radius + 1):
            for x in range(-radius, radius + 1):
                var cell: Vector2i = Vector2i(x, y)
                if occupied.has(cell):
                    continue
                if signi(x) != signi(region.x) or signi(y) != signi(region.y):
                    continue
                if absi(x) + absi(y) < 3 + level_number:
                    continue
                candidates.append(cell)
        if candidates.is_empty():
            continue
        var chosen: Vector2i = candidates[rng.randi_range(0, candidates.size() - 1)]
        _spawn_pickup(chosen, "crown")
        occupied[chosen] = true
    # Reserva para o caso de alguma regiao nao ter candidatos.
    var fallback: Array[Vector2i] = []
    for y in range(-radius, radius + 1):
        for x in range(-radius, radius + 1):
            var cell: Vector2i = Vector2i(x, y)
            if not occupied.has(cell):
                fallback.append(cell)
    fallback.shuffle()
    while pickups.size() < 3 and not fallback.is_empty():
        var chosen: Vector2i = fallback.pop_back()
        _spawn_pickup(chosen, "crown")

func _place_level_resources() -> void:
    # Distribui recursos em casas diferentes das coroas, da saida e da origem.
    var options: Array[Vector2i] = []
    for y in range(-_level_half_size(), _level_half_size() + 1):
        for x in range(-_level_half_size(), _level_half_size() + 1):
            var cell: Vector2i = Vector2i(x, y)
            if pickups.has(cell) or cell == exit_cell or _cells(words[0]).has(cell):
                continue
            if absi(x) + absi(y) < 3 + level_number:
                continue
            options.append(cell)
    options.shuffle()
    var kinds: Array[String] = []
    if level_number >= 3:
        kinds.append("energy")
    if level_number >= 5:
        kinds.append("time")
    if level_number >= 6:
        kinds.append("vision")
    if level_number >= 9:
        kinds.append("energy")
    for kind in kinds:
        if options.is_empty():
            break
        _spawn_pickup(options.pop_back(), kind)

func _plan_level() -> void:
    level_route.clear()
    if level_number == 1:
        _place_first_level_objectives()
        return
    if level_number == 2:
        # Tutorial: uma unica ramificacao, com saida e coroas perto da origem.
        var first: Dictionary = words[0]
        var possible: Array[Dictionary] = []
        var directions: Array[Vector2i] = [Vector2i(0, -1), Vector2i(0, 1)]
        for anchor in range(String(first["answer"]).length()):
            for direction in directions:
                var options: Array[Dictionary] = _possible_children(0, anchor, direction)
                for option in options:
                    var cells: Array[Vector2i] = _cells(option)
                    if cells.size() >= (7 if level_number == 1 else 8) and cells.size() <= (9 if level_number == 1 else 10):
                        possible.append({"word": option, "anchor": anchor, "direction": direction})
        if not possible.is_empty():
            var chosen_route: Dictionary = possible[rng.randi_range(0, possible.size() - 1)]
            var route_word: Dictionary = chosen_route["word"]
            var route_cells: Array[Vector2i] = _cells(route_word)
            var route_direction: Vector2i = chosen_route["direction"]
            var route_anchor: int = int(chosen_route["anchor"])
            var route_key: String = "%d:%d:%d:%d" % [0, route_anchor, route_direction.x, route_direction.y]
            fixed_branch_answers[route_key] = String(route_word["answer"])
            level_route = _cells(first)
            for cell in route_cells:
                if not level_route.has(cell):
                    level_route.append(cell)
            exit_cell = route_cells.back()
            # Espalha as coroas ao longo da rota, sem tres casas consecutivas.
            # Fase 1: indices 1, 3 e 5; fase 2: 1, 4 e 6.
            var crown_positions: Array[int] = [1, 3, 5] if level_number == 1 else [1, 4, 6]
            for crown_index in crown_positions:
                _spawn_pickup(route_cells[crown_index], "crown")
            return
    _plan_advanced_level()

func _plan_advanced_level() -> void:
    level_route.clear()
    var first_word: Dictionary = words[0].duplicate(true)
    var best_route: Array[Vector2i] = []
    var best_exit: Vector2i = Vector2i(0, -6)
    var best_distance: int = -1
    var best_pins: Dictionary = {}
    var target_steps: int = mini(maxi(2, level_number), 10)
    for attempt in range(28):
        words.resize(1)
        words[0] = first_word.duplicate(true)
        words[0]["state"] = "solved"
        var route: Array[Vector2i] = _cells(words[0])
        var parent_idx: int = 0
        var trial_pins: Dictionary = {}
        for depth in range(target_steps):
            var parent: Dictionary = words[parent_idx]
            var candidates: Array[Dictionary] = []
            var parent_cells: Array[Vector2i] = _cells(parent)
            var directions: Array[Vector2i] = [Vector2i(0, -1), Vector2i(0, 1)] if Vector2i(parent["dir"]).x != 0 else [Vector2i(-1, 0), Vector2i(1, 0)]
            for anchor in range(parent_cells.size()):
                for direction in directions:
                    for option in _possible_children(parent_idx, anchor, direction):
                        candidates.append({"word": option, "anchor": anchor, "direction": direction})
            if candidates.is_empty():
                break
            var choice: Dictionary = candidates[rng.randi_range(0, candidates.size() - 1)]
            var selected: Dictionary = choice["word"]
            selected = selected.duplicate(true)
            var chosen_dir: Vector2i = choice["direction"]
            var pin_key: String = "%d:%d:%d:%d" % [parent_idx, int(choice["anchor"]), chosen_dir.x, chosen_dir.y]
            trial_pins[pin_key] = String(selected["answer"])
            selected["state"] = "solved"
            parent["spawned"] = true
            words[parent_idx] = parent
            words.append(selected)
            parent_idx = words.size() - 1
            for cell in _cells(selected):
                if not route.has(cell):
                    route.append(cell)
        if words.size() > 1:
            var start_cells: Array[Vector2i] = _cells(words[0])
            for cell in _cells(words.back()):
                if start_cells.has(cell):
                    continue
                var distance: int = absi(cell.x) + absi(cell.y)
                if _inside_level(cell) and distance > best_distance:
                    best_distance = distance
                    best_exit = cell
                    best_route = route.duplicate()
                    best_pins = trial_pins.duplicate()
        if best_distance >= 4 + level_number * 3:
            break
    words.resize(1)
    words[0] = first_word
    fixed_branch_answers.merge(best_pins, true)
    exit_cell = best_exit
    level_route = best_route
    if level_route.is_empty():
        level_route = _cells(first_word)
    if not _inside_level(exit_cell):
        for cell in level_route:
            if _inside_level(cell) and not _cells(first_word).has(cell):
                exit_cell = cell
    # As coroas ficam em casas alcançáveis pela rota planejada.
    var candidates: Array[Vector2i] = []
    var initial_cells: Array[Vector2i] = _cells(first_word)
    for cell in level_route:
        if not initial_cells.has(cell) and cell != exit_cell:
            candidates.append(cell)
    if candidates.size() < 3:
        for cell in level_route:
            if cell != exit_cell and not candidates.has(cell):
                candidates.append(cell)
    candidates.shuffle()
    if candidates.size() < 3:
        for cell in _cells(first_word):
            if cell != exit_cell and not candidates.has(cell):
                candidates.append(cell)
    for i in range(mini(3, candidates.size())):
        _spawn_pickup(candidates[i], "crown")

func _cells(word: Dictionary) -> Array[Vector2i]:
    var result: Array[Vector2i] = []
    var answer: String = word["answer"]
    var start: Vector2i = word["start"]
    var direction: Vector2i = word["dir"]
    for i in range(answer.length()):
        result.append(start + direction * i)
    return result

func _inside(_p: Vector2i) -> bool:
    # O tabuleiro é logicamente infinito; só a região visível é desenhada.
    return true

func _occupied_letters() -> Dictionary:
    var occupied: Dictionary = {}
    for word in words:
        if word["state"] == "destroyed" or word["state"] == "expired":
            continue
        var cells := _cells(word)
        var answer: String = word["answer"]
        for i in range(cells.size()):
            occupied[cells[i]] = answer[i]
    return occupied

# Retorna os caminhos que usam precisamente a letra escolhida do pai.
# Todas as opções válidas começam na letra selecionada, na direção escolhida.
func _possible_children(index: int, anchor: int, direction: Vector2i) -> Array[Dictionary]:
    var choices: Array[Dictionary] = []
    if index < 0 or index >= words.size():
        return choices
    var parent: Dictionary = words[index]
    if parent["state"] != "solved":
        return choices
    if bool(parent["spawned"]) and not extra_branch_armed:
        return choices
    var parent_cells: Array[Vector2i] = _cells(parent)
    if anchor < 0 or anchor >= parent_cells.size():
        return choices
    var parent_dir: Vector2i = parent["dir"]
    if direction == Vector2i.ZERO or parent_dir.x * direction.x + parent_dir.y * direction.y != 0:
        return choices
    var crossing: Vector2i = parent_cells[anchor]
    if not _inside_level(crossing):
        return choices
    var parent_answer: String = parent["answer"]
    var occupied: Dictionary = _occupied_letters()
    # Impedimento por inimigo: não é permitido traçar uma palavra sobre ele.
    if enemy_cell == crossing:
        return choices
    var initial_letter: String = parent_answer.substr(anchor, 1)
    var source: Array = words_by_initial.get(initial_letter, [])
    for item in source:
        if not _word_difficulty_allowed(item):
            continue
        var answer: String = String(item["answer"])
        if used.has(answer):
            continue
        var trial: Dictionary = {
            "answer": answer, "clue": String(item["clue"]), "category": String(item["category"]), "difficulty": int(item["difficulty"]), "start": crossing,
            "dir": direction, "time": WORD_TIME,
            "state": "active", "spawned": false
        }
        var cells: Array[Vector2i] = _cells(trial)
        var valid := true
        var new_count := 0
        for k in range(cells.size()):
            var cell: Vector2i = cells[k]
            if not _inside_level_halo(cell) or cell == enemy_cell:
                valid = false
                break
            if occupied.has(cell):
                if occupied[cell] != answer[k]:
                    valid = false
                    break
            else:
                new_count += 1
        # Permite cruzamentos múltiplos e comprimentos curtos; não há limite de mapa.
        if valid and new_count >= 1:
            choices.append(trial)
    # Sorteia alternativas validas: a ordem do JSON nao define a resposta.
    # O tema da fase continua tendo uma preferencia leve.
    choices.shuffle()
    choices.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
        var a_theme: bool = String(a.get("category", "")) == current_category
        var b_theme: bool = String(b.get("category", "")) == current_category
        return a_theme and not b_theme)
    return choices

# Cada letra de origem guarda SEU rascunho; direção não cria outro rascunho.
# Ex.: ABELHA à direita e à esquerda são o mesmo texto, apenas as coordenadas mudam.
func _draft_key(parent_idx: int, anchor: int) -> String:
    return "%d:%d" % [parent_idx, anchor]

func _anchor_letter(parent_idx: int, anchor: int) -> String:
    if parent_idx < 0 or parent_idx >= words.size():
        return ""
    var answer: String = words[parent_idx]["answer"]
    if anchor < 0 or anchor >= answer.length():
        return ""
    return answer.substr(anchor, 1)

func _save_preview_draft() -> void:
    if preview_parent < 0 or preview_anchor < 0:
        return
    var key: String = _draft_key(preview_parent, preview_anchor)
    var value: String = entry.text.strip_edges().to_upper()
    var prefix: String = _anchor_letter(preview_parent, preview_anchor)
    if not value.begins_with(prefix):
        value = prefix
    drafts[key] = {"text": value, "dir": preview_dir}
    typed_buffer = value

func _answer_limit() -> int:
    if not preview.is_empty():
        return String(preview["answer"]).length()
    if chosen >= 0 and chosen < words.size() and words[chosen]["state"] == "active":
        return String(words[chosen]["answer"]).length()
    return 0

# Letras resolvidas do tabuleiro nao precisam ser digitadas novamente.
# A entrada armazena apenas o texto ate a ultima casa preenchida.
func _locked_letters_for_preview() -> Dictionary:
    var locked: Dictionary = {}
    if preview.is_empty():
        return locked
    var occupied: Dictionary = _occupied_letters()
    var cells: Array[Vector2i] = _cells(preview)
    for i in range(cells.size()):
        if occupied.has(cells[i]):
            locked[i] = String(occupied[cells[i]])
    return locked

func _fill_locked_letters(value: String) -> String:
    if preview.is_empty():
        return value
    var locked: Dictionary = _locked_letters_for_preview()
    var result: String = value
    var limit: int = String(preview["answer"]).length()
    while result.length() < limit and locked.has(result.length()):
        result += String(locked[result.length()])
    return result

func _remove_last_editable_letter(value: String) -> String:
    var locked: Dictionary = _locked_letters_for_preview()
    var i: int = value.length() - 1
    while i > 0 and locked.has(i):
        i -= 1
    if i <= 0:
        return value
    return _fill_locked_letters(value.substr(0, i))

func _on_entry_changed(value: String) -> void:
    if input_syncing:
        return
    var clean: String = value.strip_edges().to_upper()
    var max_letters: int = _answer_limit()
    if preview_parent >= 0 and preview_anchor >= 0:
        var prefix: String = _anchor_letter(preview_parent, preview_anchor)
        var old_text: String = entry.text.to_upper()
        if not clean.begins_with(prefix):
            clean = prefix
        elif not preview.is_empty():
            if clean.length() < old_text.length() and old_text.begins_with(clean):
                clean = _remove_last_editable_letter(old_text)
            elif clean.length() > old_text.length() and clean.begins_with(old_text):
                var appended: String = clean.substr(old_text.length())
                clean = old_text
                for j in range(appended.length()):
                    clean = _fill_locked_letters(clean)
                    if clean.length() < max_letters:
                        clean += appended[j]
            clean = _fill_locked_letters(clean)
    if max_letters > 0 and clean.length() > max_letters:
        clean = clean.substr(0, max_letters)
    if preview_parent >= 0 and preview_anchor >= 0:
        drafts[_draft_key(preview_parent, preview_anchor)] = {"text": clean, "dir": preview_dir}
    if entry.text != clean:
        _assign_entry(clean)
    typed_buffer = clean
    _focus_current_typing_cell()
    _refresh_board()

func _focus_current_typing_cell() -> void:
    if preview.is_empty():
        return
    var cells: Array[Vector2i] = _cells(preview)
    if cells.is_empty():
        return
    # A proxima casa vazia e o destino; ao completar, fica na ultima.
    var next_index: int = clampi(entry.text.length(), 0, cells.size() - 1)
    _focus_cell(cells[next_index])

func _assign_entry(value: String) -> void:
    input_syncing = true
    entry.text = value
    entry.caret_column = entry.text.length()
    input_syncing = false

# O teclado físico envia caracteres diretamente para os quadrados, sem clicar na entrada.
# O LineEdit invisível ainda é usado somente para receber o teclado virtual no Android.
func _type_character(character: String) -> void:
    if game_over or (preview_parent < 0 and chosen < 0):
        return
    var limit: int = _answer_limit()
    if limit <= 0 or entry.text.length() >= limit:
        return
    _on_entry_changed(entry.text + character)

func _erase_character() -> void:
    if game_over or (preview_parent < 0 and chosen < 0):
        return
    if entry.text.is_empty():
        return
    var minimum: int = 1 if preview_parent >= 0 else 0
    if entry.text.length() <= minimum:
        return
    _on_entry_changed(entry.text.substr(0, entry.text.length() - 1))

func _open_mobile_keyboard() -> void:
    # Campo transparente: o usuário vê apenas os espaços da palavra.
    entry.grab_focus()
    if DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD):
        DisplayServer.virtual_keyboard_show(entry.text)

func _clear_preview(save: bool = true) -> void:
    if save:
        _save_preview_draft()
    preview.clear()
    preview_parent = -1
    preview_anchor = -1
    preview_dir = Vector2i.ZERO
    preview_choices.clear()
    preview_choice_index = 0

func _preview_default_direction(index: int) -> Vector2i:
    var d: Vector2i = words[index]["dir"]
    return Vector2i(0, 1) if d.x != 0 else Vector2i(1, 0)

func _select_anchor(index: int, anchor: int) -> void:
    if index < 0 or index >= words.size():
        return
    if anchor < 0 or anchor >= _cells(words[index]).size():
        return
    if not _inside_level(_cells(words[index])[anchor]):
        _message("Esta letra está fora da área principal e não pode gerar outra palavra.")
        return
    if preview_parent == index and preview_anchor == anchor:
        return
    _save_preview_draft()
    preview_parent = index
    last_solved_word = index
    # Nao zerar last_navigation_arrow aqui: esta funcao e usada pelas setas.
    preview_anchor = anchor
    chosen = -1
    var key: String = _draft_key(index, anchor)
    var old: Dictionary = drafts.get(key, {})
    # O lado escolhido tem prioridade ao avançar para outra letra.
    var remembered_direction: Vector2i = preferred_branch_direction
    var parent_direction: Vector2i = words[index]["dir"]
    if remembered_direction == Vector2i.ZERO or parent_direction.x * remembered_direction.x + parent_direction.y * remembered_direction.y != 0:
        remembered_direction = old.get("dir", _preview_default_direction(index))
    preview_dir = remembered_direction
    preferred_branch_direction = remembered_direction
    var text_value: String = String(old.get("text", _anchor_letter(index, anchor)))
    typed_buffer = text_value
    _assign_entry(text_value)
    _load_preview_choices()

func _move_anchor(step: int) -> void:
    if preview_parent < 0 or preview_parent >= words.size():
        return
    var count: int = _cells(words[preview_parent]).size()
    var next_anchor: int = clampi(preview_anchor + step, 0, count - 1)
    if next_anchor != preview_anchor:
        _select_anchor(preview_parent, next_anchor)

func _set_preview_direction(side: int) -> void:
    if preview_parent < 0 or preview_parent >= words.size() or game_over:
        return
    var original: Vector2i = words[preview_parent]["dir"]
    _apply_direction(Vector2i(0, side) if original.x != 0 else Vector2i(side, 0))

func _load_preview_choices() -> void:
    preview.clear()
    preview_choices = _possible_children(preview_parent, preview_anchor, preview_dir)
    # Uma resposta estavel por letra e direcao, sem trocar a cada visita.
    var branch_key: String = "%d:%d:%d:%d" % [preview_parent, preview_anchor, preview_dir.x, preview_dir.y]
    var pinned: String = String(fixed_branch_answers.get(branch_key, ""))
    if not pinned.is_empty():
        for i in range(preview_choices.size()):
            if String(preview_choices[i]["answer"]) == pinned:
                var pinned_choice: Dictionary = preview_choices[i]
                preview_choices.remove_at(i)
                preview_choices.insert(0, pinned_choice)
                break
    elif not preview_choices.is_empty():
        fixed_branch_answers[branch_key] = String(preview_choices[0]["answer"])
    if level_mode and level_number <= 4 and preview_choices.size() > 1:
        preview_choices.resize(1)
    preview_choice_index = 0
    # Se a lista mudar ao inverter o sentido, a resposta digitada NÃO muda.
    if preview_choices.is_empty():
        var anchor_cells: Array[Vector2i] = _cells(words[preview_parent])
        if preview_anchor >= 0 and preview_anchor < anchor_cells.size():
            var selected_cell: Vector2i = anchor_cells[preview_anchor]
            camera_target = Vector3(float(selected_cell.x) * GAP, 25.0, float(selected_cell.y) * GAP + 1.4)
        _refresh_board()
        _message("Nenhuma candidata conhecida nesse sentido. O rascunho continua editável.")
        return
    _show_preview_choice()

func _show_preview_choice() -> void:
    if preview_choices.is_empty():
        return
    preview = preview_choices[preview_choice_index].duplicate(true)
    var key: String = _draft_key(preview_parent, preview_anchor)
    var stored: Dictionary = drafts.get(key, {})
    var typed: String = String(stored.get("text", _anchor_letter(preview_parent, preview_anchor)))
    typed_buffer = typed
    _assign_entry(_fill_locked_letters(typed))
    typed_buffer = entry.text
    drafts[key] = {"text": entry.text, "dir": preview_dir}
    _focus_current_typing_cell()
    _refresh_board()
    _message("Digite sem clicar. Setas paralelas mudam a letra; perpendiculares invertem o sentido.")

func _next_preview_clue() -> void:
    if preview_choices.size() <= 1 or game_over:
        return
    if hints_remaining <= 0:
        _message("Suas 3 trocas de pista acabaram nesta fase.")
        return
    hints_remaining -= 1
    _save_preview_draft()
    preview_choice_index = (preview_choice_index + 1) % preview_choices.size()
    _show_preview_choice()

func _update_letter_slots() -> void:
    if not is_instance_valid(letter_slots):
        return
    for child in letter_slots.get_children():
        child.queue_free()
    var count: int = 0
    var typed: String = entry.text.to_upper()
    if not preview.is_empty():
        count = String(preview["answer"]).length()
    elif chosen >= 0 and chosen < words.size() and words[chosen]["state"] == "active":
        count = String(words[chosen]["answer"]).length()
    elif preview_parent >= 0:
        count = maxi(typed.length(), 1)
    count = mini(count, entry.max_length)
    for i in range(count):
        var panel := PanelContainer.new()
        panel.custom_minimum_size = Vector2(31, 43)
        var color: Color = Color("#c58c9b") if i < typed.length() else Color("#604653")
        panel.add_theme_stylebox_override("panel", _panel_style(color, Color("#b99aa9")))
        panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
        var letter := _make_label(typed.substr(i, 1) if i < typed.length() else "", 23)
        letter.add_theme_color_override("font_color", Color("#32252f") if i < typed.length() else Color("#f9dfe0"))
        letter.mouse_filter = Control.MOUSE_FILTER_IGNORE
        panel.add_child(letter)
        letter_slots.add_child(panel)


func _choose(index: int) -> void:
    if index < 0 or index >= words.size():
        return
    if words[index]["state"] != "active":
        return
    _clear_preview()
    chosen = index
    _assign_entry(typed_buffer)
    _focus_word(words[index])
    _update_hud()
    _refresh_board()

func _click_tile(p: Vector2i) -> void:
    if game_over:
        return
    # Prioriza a palavra de origem atual em casas compartilhadas.
    # Nunca seleciona uma palavra antiga bloqueada se uma nova pode ramificar.
    var eligible: Array[int] = []
    if preview_parent >= 0 and preview_parent < words.size():
        eligible.append(preview_parent)
    for i in range(words.size() - 1, -1, -1):
        if not eligible.has(i):
            eligible.append(i)
    var blocked_hit: bool = false
    for i in eligible:
        var word: Dictionary = words[i]
        if word["state"] != "solved":
            continue
        var anchor: int = _cells(word).find(p)
        if anchor < 0:
            continue
        if bool(word["spawned"]) and not extra_branch_armed:
            blocked_hit = true
            continue
        last_navigation_arrow = Vector2i.ZERO
        _select_anchor(i, anchor)
        return
    if blocked_hit:
        _message("Esta palavra ja foi usada. Selecione uma letra iluminada da palavra atual.")
        return
    for i in range(words.size() - 1, -1, -1):
        if words[i]["state"] == "active" and _cells(words[i]).has(p):
            _choose(i)
            _message("Palavra selecionada. Digite a resposta e confirme.")
            return
    _message("Toque numa letra resolvida para testar um novo caminho.")

func _submit() -> void:
    if game_over:
        return
    var word: Dictionary = {}
    var committed_from_preview := not preview.is_empty()
    if committed_from_preview:
        word = preview.duplicate(true)
    elif chosen >= 0 and chosen < words.size():
        word = words[chosen].duplicate(true)
    else:
        _message("Selecione uma palavra ou uma letra e direção válidas.")
        return
    if energy <= 0:
        _message("Sem raios! Aguarde recarga ou colete energia.")
        return
    var typed: String = entry.text.strip_edges().to_upper()
    if committed_from_preview and not typed.begins_with(_anchor_letter(preview_parent, preview_anchor)):
        _message("A resposta deve começar com a letra de origem selecionada.")
        return
    if typed != String(word["answer"]):
        combo = 0
        _message("Resposta incorreta. Você pode continuar editando sem perder o caminho.")
        _update_hud()
        return
    if committed_from_preview:
        # Revalida contra o tabuleiro no momento da confirmação.
        var options := _possible_children(preview_parent, preview_anchor, preview_dir)
        var still_valid := false
        for option in options:
            if option["answer"] == word["answer"]:
                still_valid = true
                break
        if not still_valid or (not level_mode and path_time <= 0.0):
            _message("Caminho indisponível. Escolha outra letra ou direção.")
            return
        var parent: Dictionary = words[preview_parent]
        if bool(parent["spawned"]):
            if not extra_branch_armed or coins < 3:
                _message("Para reutilizar esta palavra, ative um ramo extra (◆3).")
                return
            coins -= 3
            extra_branch_armed = false
        else:
            parent["spawned"] = true
            words[preview_parent] = parent
        word["state"] = "solved"
        words.append(word)
        last_solved_word = words.size() - 1
        last_navigation_arrow = Vector2i.ZERO
        used[String(word["answer"])] = true
    else:
        if word["state"] != "active":
            return
        word["state"] = "solved"
        words[chosen] = word
        last_solved_word = chosen
        last_navigation_arrow = Vector2i.ZERO
    if map_vision_moves > 0:
        map_vision_moves -= 1
        if map_vision_moves == 0:
            _layout_hud()
    energy -= 1
    # Conta palavras resolvidas distintas que cruzam esta palavra, nao letras ou acertos seguidos.
    var crossed_words: int = 0
    var new_cells: Array[Vector2i] = _cells(word)
    for i in range(words.size()):
        if i == last_solved_word or words[i]["state"] != "solved":
            continue
        var overlaps: bool = false
        for cell in _cells(words[i]):
            if new_cells.has(cell):
                overlaps = true
                break
        if overlaps:
            crossed_words += 1
    combo += crossed_words
    points += 100 + crossed_words * 75 + mini(combo, 20) * 10
    _clear_preview(false)
    _focus_word(words[last_solved_word])
    drafts.clear()  # Só CONFIRMAR descarta alternativas.
    typed_buffer = ""
    if level_mode:
        var solved_cells: Array[Vector2i] = _cells(word)
        var last_cell: Vector2i = solved_cells.back()
        var dist: int = absi(last_cell.x - exit_cell.x) + absi(last_cell.y - exit_cell.y)
        if dist > LEVEL_SAFE_RADIUS:
            var penalty: int = (dist - LEVEL_SAFE_RADIUS) * 15
            points = maxi(0, points - penalty)
            elapsed += 3.0
        if solved_cells.has(exit_cell):
            _collect_pickups()
            _show_result(true, "Você encontrou a saída da fase %d!" % level_number)
            _refresh_board()
            return
    _collect_pickups()
    # Apenas o alvo atual provoca derrota; os demais custam pontos.
    if not level_mode or level_number >= 7:
        _enemy_turn()
    if game_over:
        _refresh_board()
        return
    if not level_mode and points >= 400 and enemy_cell.x == -100:
        _spawn_enemy()
    chosen = -1
    _assign_entry("")
    for i in range(words.size()):
        if words[i]["state"] == "active":
            chosen = i
            break
    _refresh_board()
    if not game_over:
        _message("Confirmada! Use setas paralelas à palavra para escolher uma letra, ou clique nela.")
    _check_end()

func _collect_pickups() -> void:
    var solved_cells: Dictionary = {}
    for word in words:
        if word["state"] == "solved":
            for p in _cells(word):
                solved_cells[p] = true
    for p in pickups.keys():
        if not solved_cells.has(p):
            continue
        match pickups[p]:
            "coin":
                coins += 1
                points += 50
            "crown":
                if level_mode:
                    crowns = mini(3, crowns + 1)
                points += 500
            "energy":
                energy = mini(ENERGY_MAX, energy + 3)
            "time":
                if level_mode:
                    elapsed = maxf(0.0, elapsed - 12.0)
                else:
                    path_time += 12.0
            "vision":
                map_vision_moves = MAP_VISION_MOVES + 1
                _message("Visão ampliada por %d palavras!" % MAP_VISION_MOVES)
                _layout_hud()
        pickups.erase(p)
    if rng.randf() < 0.35:
        var last: Dictionary = words.back()
        var around: Array[Vector2i] = _cells(last)
        var center: Vector2i = around[around.size() / 2]
        for attempt in range(20):
            var p := center + Vector2i(rng.randi_range(-6, 6), rng.randi_range(-6, 6))
            if not solved_cells.has(p) and not pickups.has(p):
                var kinds: Array[String] = ["coin", "energy", "time", "vision"]
                if not level_mode:
                    kinds.append("crown")
                _spawn_pickup(p, kinds[rng.randi_range(0, kinds.size() - 1)])
                break

func _spawn_pickup(p: Vector2i, kind: String) -> void:
    pickups[p] = kind

func _buy_path() -> void:
    if game_over:
        return
    if coins < 3:
        _message("Você precisa de três moedas para habilitar um ramo extra.")
        return
    extra_branch_armed = not extra_branch_armed
    _message("Ramo extra %s. Toque numa palavra já utilizada. Moedas só serão gastas ao confirmar." % ("ativado" if extra_branch_armed else "desativado"))
    _update_hud()

func _spawn_enemy() -> void:
    var targets: Array[Vector2i] = []
    for word in words:
        if word["state"] == "solved":
            targets.append_array(_cells(word))
    if targets.is_empty():
        return
    var target: Vector2i = targets[rng.randi_range(0, targets.size() - 1)]
    enemy_cell = target + Vector2i(4, 4)
    if level_mode:
        var radius: int = _level_half_size()
        var candidates: Array[Vector2i] = [Vector2i(-radius, -radius), Vector2i(radius, -radius), Vector2i(-radius, radius), Vector2i(radius, radius)]
        candidates.shuffle()
        for candidate in candidates:
            if candidate != exit_cell and not pickups.has(candidate) and not targets.has(candidate):
                enemy_cell = candidate
                break
    if level_mode:
        enemy_cell.x = clampi(enemy_cell.x, -_level_half_size(), _level_half_size())
        enemy_cell.y = clampi(enemy_cell.y, -_level_half_size(), _level_half_size())
    enemy_node = MeshInstance3D.new()
    var mesh := BoxMesh.new()
    mesh.size = Vector3(0.72, 0.40, 0.72)
    enemy_node.mesh = mesh
    enemy_node.material_override = _material_cached("enemy", RED, true)
    add_child(enemy_node)
    _update_enemy_visual()

func _enemy_turn() -> void:
    if enemy_cell.x == -100:
        return
    var targets: Array[Vector2i] = []
    for word in words:
        if word["state"] == "solved":
            targets.append_array(_cells(word))
    if targets.is_empty():
        return
    var closest: Vector2i = targets[0]
    var best: int = 99999
    for p in targets:
        var dist: int = absi(p.x - enemy_cell.x) + absi(p.y - enemy_cell.y)
        if dist < best:
            best = dist
            closest = p
    var dx: int = signi(closest.x - enemy_cell.x)
    var dy: int = signi(closest.y - enemy_cell.y)
    var step: Vector2i = Vector2i(dx, 0) if absi(closest.x - enemy_cell.x) >= absi(closest.y - enemy_cell.y) else Vector2i(0, dy)
    enemy_cell += step
    _update_enemy_visual()
    # A palavra atual é a última confirmada. Colisão com ela encerra a partida.
    # O inimigo continua perigoso mesmo se a palavra estiver em um cruzamento.
    if last_solved_word >= 0 and last_solved_word < words.size():
        var current_word: Dictionary = words[last_solved_word]
        if current_word["state"] == "solved" and _cells(current_word).has(enemy_cell):
            _show_result(false, "O inimigo alcançou sua palavra atual!")
            return
    for i in range(words.size()):
        if words[i]["state"] == "solved" and _cells(words[i]).has(enemy_cell):
            var word: Dictionary = words[i]
            word["state"] = "destroyed"
            words[i] = word
            points = maxi(0, points - 75)
            enemy_cell = Vector2i(-100, -100)
            if is_instance_valid(enemy_node):
                enemy_node.queue_free()
            enemy_node = null
            _message("Inimigo destruiu outra palavra! -75 pontos")
            break

func _update_enemy_visual() -> void:
    if is_instance_valid(enemy_node):
        enemy_node.position = Vector3(enemy_cell.x * GAP, 0.72, enemy_cell.y * GAP)

func _draw_text(p: Vector2i, caption: String, color: Color, height: float, font_size: int = 78) -> void:
    var label := Label3D.new()
    label.text = caption
    label.font_size = font_size
    label.pixel_size = 0.006
    label.modulate = color
    label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
    label.no_depth_test = true
    label.position = Vector3(p.x * GAP, height, p.y * GAP)
    add_child(label)
    visual_nodes.append(label)

func _draw_branch_arrows() -> void:
    if preview_parent < 0 or preview_parent >= words.size() or preview_anchor < 0:
        return
    var parent_cells: Array[Vector2i] = _cells(words[preview_parent])
    if preview_anchor >= parent_cells.size():
        return
    var anchor: Vector2i = parent_cells[preview_anchor]
    var horizontal: bool = Vector2i(words[preview_parent]["dir"]).x != 0
    var sides: Array[Vector2i] = []
    if horizontal:
        sides.append(Vector2i(0, -1))
        sides.append(Vector2i(0, 1))
    else:
        sides.append(Vector2i(-1, 0))
        sides.append(Vector2i(1, 0))
    for side in sides:
        var active: bool = side == preview_dir
        var arrow := Label3D.new()
        arrow.text = ("^" if side.y < 0 else "v") if horizontal else ("<" if side.x < 0 else ">")
        arrow.font_size = 72 if active else 65
        arrow.pixel_size = 0.005
        arrow.modulate = Color("#fff0b8") if active else Color("#7e6577")
        arrow.outline_modulate = Color("#392b3a")
        arrow.outline_size = 8
        arrow.billboard = BaseMaterial3D.BILLBOARD_ENABLED
        arrow.no_depth_test = true
        arrow.position = Vector3((float(anchor.x) + float(side.x) * 0.43) * GAP, 0.93, (float(anchor.y) + float(side.y) * 0.43) * GAP)
        add_child(arrow)
        visual_nodes.append(arrow)

func _try_tap_branch_arrow(screen_pos: Vector2) -> bool:
    if preview_parent < 0 or preview_parent >= words.size() or preview_anchor < 0:
        return false
    var parent_cells: Array[Vector2i] = _cells(words[preview_parent])
    if preview_anchor >= parent_cells.size():
        return false
    var anchor: Vector2i = parent_cells[preview_anchor]
    var horizontal: bool = Vector2i(words[preview_parent]["dir"]).x != 0
    var sides: Array[Vector2i] = []
    if horizontal:
        sides.append(Vector2i(0, -1))
        sides.append(Vector2i(0, 1))
    else:
        sides.append(Vector2i(-1, 0))
        sides.append(Vector2i(1, 0))
    for side in sides:
        var world_pos := Vector3((float(anchor.x) + float(side.x) * 0.43) * GAP, 0.93, (float(anchor.y) + float(side.y) * 0.43) * GAP)
        if camera.unproject_position(world_pos).distance_to(screen_pos) < 24.0:
            _apply_direction(side)
            return true
    return false

func _refresh_board() -> void:
    for node in visual_nodes:
        if is_instance_valid(node):
            node.queue_free()
    visual_nodes.clear()
    tile_state.clear()
    var letters: Dictionary = {}
    for word in words:
        if word["state"] == "destroyed" or word["state"] == "expired":
            continue
        var cells: Array[Vector2i] = _cells(word)
        var answer: String = word["answer"]
        for i in range(cells.size()):
            var p: Vector2i = cells[i]
            if word["state"] == "solved":
                tile_state[p] = "solved"
                letters[p] = answer[i]
            elif not tile_state.has(p):
                tile_state[p] = "active"
    # Uma única orientação visual por âncora. Ao inverter, a prévia antiga desaparece.
    # Outros rascunhos (em outras letras) permanecem até uma confirmação.
    for key in drafts.keys():
        var parts: PackedStringArray = String(key).split(":")
        if parts.size() != 2:
            continue
        var pidx: int = int(parts[0])
        var anchor: int = int(parts[1])
        if pidx < 0 or pidx >= words.size() or anchor < 0 or anchor >= _cells(words[pidx]).size():
            continue
        var d: Vector2i = drafts[key].get("dir", Vector2i.ZERO)
        if d == Vector2i.ZERO:
            continue
        var start: Vector2i = _cells(words[pidx])[anchor]
        var typed: String = String(drafts[key].get("text", "")).to_upper()
        for j in range(typed.length()):
            var cell: Vector2i = start + d * j
            if tile_state.get(cell, "") != "solved":
                tile_state[cell] = "draft"
                letters[cell] = typed[j]
    if chosen >= 0 and chosen < words.size() and words[chosen]["state"] == "active":
        var initial_cells: Array[Vector2i] = _cells(words[chosen])
        var entered: String = entry.text.strip_edges().to_upper()
        for i in range(initial_cells.size()):
            var p: Vector2i = initial_cells[i]
            if tile_state.get(p, "") != "solved":
                tile_state[p] = "selected"
                if i < entered.length():
                    letters[p] = entered[i]
    if not preview.is_empty():
        var cells: Array[Vector2i] = _cells(preview)
        var typed: String = entry.text.strip_edges().to_upper()
        for i in range(cells.size()):
            var p: Vector2i = cells[i]
            if tile_state.get(p, "") != "solved":
                tile_state[p] = "selected"
                if i < typed.length():
                    letters[p] = typed[i]
    # Realce da proxima letra a digitar, diretamente no tabuleiro.
    var focus_cell: Vector2i = Vector2i(999999, 999999)
    var focus_cells: Array[Vector2i] = []
    if not preview.is_empty():
        focus_cells = _cells(preview)
    elif chosen >= 0 and chosen < words.size() and words[chosen]["state"] == "active":
        focus_cells = _cells(words[chosen])
    if not focus_cells.is_empty():
        var next_index: int = mini(entry.text.length(), focus_cells.size() - 1)
        focus_cell = focus_cells[next_index]
    elif preview_parent >= 0 and preview_anchor >= 0:
        focus_cell = _cells(words[preview_parent])[preview_anchor]
    # Marca TODAS as letras da palavra que pode gerar o proximo ramo.
    # Palavras anteriores permanecem no tabuleiro, mas sem este destaque.
    var highlighted_parent: int = preview_parent if preview_parent >= 0 else last_solved_word
    if highlighted_parent >= 0 and highlighted_parent < words.size():
        var source_word: Dictionary = words[highlighted_parent]
        if source_word["state"] == "solved" and (not bool(source_word["spawned"]) or extra_branch_armed):
            for source_cell in _cells(source_word):
                if board.has(source_cell):
                    tile_state[source_cell] = "branch_source"
    # A letra de cruzamento da palavra antiga permanece iluminada,
    # mesmo quando a proxima letra da palavra nova esta em outra casa.
    if preview_parent >= 0 and preview_parent < words.size():
        var parent_cells: Array[Vector2i] = _cells(words[preview_parent])
        if preview_anchor >= 0 and preview_anchor < parent_cells.size():
            var crossing_cell: Vector2i = parent_cells[preview_anchor]
            if board.has(crossing_cell):
                tile_state[crossing_cell] = "anchor_focus"
    if board.has(focus_cell):
        tile_state[focus_cell] = "focus"
    for p in board.keys():
        var tile: MeshInstance3D = board[p]
        var kind: String = tile_state.get(p, "base")
        var mat: StandardMaterial3D = _material_cached("base", BASE)
        match kind:
            "solved":
                mat = _material_cached("solved", SOLVED)
            "active":
                mat = _material_cached("active", ACTIVE, true)
            "selected":
                mat = _material_cached("selected", SELECTED, true)
            "draft":
                mat = _material_cached("draft", Color("#846777"))
            "focus":
                mat = _material_cached("focus", CURRENT_LETTER, true)
            "anchor_focus":
                mat = _material_cached("anchor_focus", Color("#f2c79d"), true)
            "branch_source":
                mat = _material_cached("branch_source", Color("#f3d46a"), true)
            _:
                if level_mode and p == exit_cell:
                    mat = _material_cached("exit", Color("#6ab79a"), true)
                elif pickups.has(p):
                    mat = _material_cached("gold", GOLD, true) if pickups[p] in ["coin", "crown"] else _material_cached("blue", Color("#72a5ae"), true)
        if level_mode and not _inside_level(p):
            mat = _material_cached("outer_solved", Color("#514354")) if letters.has(p) else _material_cached("outer_zone", Color("#24202e"))
        tile.material_override = mat
        if letters.has(p):
            _draw_text(p, String(letters[p]), Color("#342632"), 0.64)
        elif kind == "selected" or kind == "active" or kind == "focus" or kind == "anchor_focus" or kind == "branch_source":
            _draw_text(p, "·", Color("#f7d7db"), 0.42, 66)
        elif level_mode and p == exit_cell:
            _draw_text(p, "⇧", Color("#c7f6d5"), 0.55, 84)
        elif pickups.has(p):
            var symbol: String = "$"
            match pickups[p]:
                "energy": symbol = "+"
                "time": symbol = "T"
                "crown": symbol = "C"
                "vision": symbol = "V"
            _draw_text(p, symbol, Color("#fff0dc"), 0.50, 64)
    _draw_branch_arrows()
    _update_hud()

func _update_hud() -> void:
    var seconds: int = maxi(0, int(ceil(path_time)))
    if not preview.is_empty():
        clue_label.text = "[%s] %s  (%d letras)" % [String(preview.get("category", "GERAL")).capitalize(), preview["clue"], String(preview["answer"]).length()]
        selected_info.text = "RASCUNHO · %d/%d PISTAS" % [preview_choice_index + 1, preview_choices.size()]
    elif chosen >= 0 and chosen < words.size() and words[chosen]["state"] == "active":
        var word: Dictionary = words[chosen]
        clue_label.text = "[%s] %s  (%d letras)" % [String(word.get("category", "GERAL")).capitalize(), word["clue"], String(word["answer"]).length()]
        selected_info.text = "PALAVRA SELECIONADA"
    elif preview_parent >= 0:
        clue_label.text = "Nenhuma palavra do dicionário neste sentido; experimente outra direção."
        selected_info.text = "LETRA SELECIONADA · TEMPO CORRENDO"
    else:
        clue_label.text = "Selecione uma letra resolvida e escolha uma direção."
        selected_info.text = "ESCOLHA UMA LETRA PARA RAMIFICAR"
    direction_left.visible = false
    direction_right.visible = false
    next_clue_button.visible = true
    next_clue_button.disabled = preview_choices.size() <= 1 or hints_remaining <= 0 or game_over
    next_clue_button.text = "💡 %d" % hints_remaining
    var shown_seconds: int = maxi(0, int(elapsed)) if level_mode else seconds
    time_label.text = "TEMPO %d:%02d" % [shown_seconds / 60, shown_seconds % 60]
    crown_label.text = "FASE %d  ·  COROAS %d/3" % [level_number, crowns] if level_mode else "INFINITO"
    energy_label.text = "ENERGIA %d/%d" % [energy, ENERGY_MAX]
    score_label.text = "PONTOS %d  |  MOEDAS %d  |  COMBO %d%s" % [points, coins, combo, "  |  VISAO %d" % map_vision_moves if map_vision_moves > 0 else ""]

func _message(value: String) -> void:
    message_label.text = value

func _has_possible_path() -> bool:
    for i in range(words.size()):
        if words[i]["state"] != "solved":
            continue
        if bool(words[i]["spawned"]) and not (extra_branch_armed and coins >= 3):
            continue
        var directions: Array[Vector2i] = []
        var original: Vector2i = words[i]["dir"]
        if original.x != 0:
            directions = [Vector2i(0, -1), Vector2i(0, 1)]
        else:
            directions = [Vector2i(-1, 0), Vector2i(1, 0)]
        for j in range(_cells(words[i]).size()):
            for direction in directions:
                if not _possible_children(i, j, direction).is_empty():
                    return true
    return false

func _check_end() -> void:
    if game_over:
        return
    if level_mode:
        # Não existem paredes. A penalidade por sair da área será aplicada em _submit.
        pass
    # Modo infinito: o fim depende de tempo/recursos, nunca do tamanho da grade.

func _solved_count() -> int:
    var result: int = 0
    for word in words:
        if word["state"] == "solved":
            result += 1
    return result

func _process(delta: float) -> void:
    elapsed += delta
    if hud_gesture_fade:
        hud_restore_delay = 0.45
    elif hud_restore_delay > 0.0:
        hud_restore_delay = maxf(0.0, hud_restore_delay - delta)
    var hud_target_alpha: float = HUD_GESTURE_ALPHA if hud_gesture_fade or hud_restore_delay > 0.0 else HUD_IDLE_ALPHA
    if is_instance_valid(hud_top):
        hud_top.modulate.a = move_toward(hud_top.modulate.a, hud_target_alpha, delta * 3.6)
    if is_instance_valid(hud_bottom):
        hud_bottom.modulate.a = move_toward(hud_bottom.modulate.a, hud_target_alpha, delta * 3.6)
    if level_intro_remaining > 0.0:
        level_intro_remaining = maxf(0.0, level_intro_remaining - delta)
        var progress: float = 1.0 - level_intro_remaining / LEVEL_INTRO_SECONDS
        var eased: float = progress * progress * (3.0 - 2.0 * progress)
        camera.size = lerpf(level_intro_start_size, 18.0 * camera_zoom_factor, eased)
        if level_intro_remaining <= 0.0:
            _sync_visible_board(true)
    if not game_over and level_intro_remaining <= 0.0:
        # Energia e um recurso de sobrevivencia, sem regeneracao passiva.
        if energy <= 0:
            _show_result(false, "Sua energia acabou!")
        if not level_mode:
            path_time = maxf(0.0, path_time - delta)
            if path_time <= 0.0:
                _show_result(false, "O tempo acabou!")
        _update_hud()
    # A câmera segue suavemente o centro da palavra selecionada.
    var desired_camera: Vector3 = camera_target + Vector3(camera_pan_offset.x, 0.0, camera_pan_offset.y)
    camera.position = camera.position.lerp(desired_camera, minf(1.0, delta * 4.0))
    _sync_visible_board()
    for p in board.keys():
        var tile: MeshInstance3D = board[p]
        var kind: String = tile_state.get(p, "base")
        if kind == "solved":
            tile.position.y = 0.26
        elif kind == "active" or kind == "selected" or kind == "focus":
            tile.position.y = 0.10 + sin(elapsed * 2.6 + float(p.x) * 0.7 + float(p.y) * 0.45) * 0.06
        else:
            tile.position.y = sin(elapsed * 1.5 + float(p.x) * 0.35 + float(p.y) * 0.4) * 0.04
    if is_instance_valid(enemy_node):
        enemy_node.position.y = 0.7 + sin(elapsed * 3.0) * 0.10

func _screen_to_cell(screen_pos: Vector2) -> Vector2i:
    var origin := camera.project_ray_origin(screen_pos)
    var direction := camera.project_ray_normal(screen_pos)
    var hit: Variant = Plane(Vector3.UP, 0.0).intersects_ray(origin, direction)
    if hit == null:
        return Vector2i(-1000, -1000)
    var point: Vector3 = hit
    return Vector2i(roundi(point.x / GAP), roundi(point.z / GAP))

# Navegação espacial determinística. Não usa a lista de palavras candidatas.
# O eixo e os índices são calculados pela posição real da casa, sem usar o
# sentido em que a palavra foi escrita. Nunca altera a direção perpendicular.
func _select_anchor_by_arrow(arrow: Vector2i) -> void:
    var parent_index: int = preview_parent if preview_parent >= 0 else last_solved_word
    if parent_index < 0 or parent_index >= words.size():
        return
    var parent: Dictionary = words[parent_index]
    if parent["state"] != "solved":
        return
    if bool(parent["spawned"]) and not extra_branch_armed:
        _message("Esta palavra já gerou um ramo. Escolha outra ou compre um ramo extra.")
        return
    var cells: Array[Vector2i] = _cells(parent)
    var count: int = cells.size()
    if count == 0:
        return

    # Ordem VISUAL: esquerda -> direita, cima -> baixo.
    # A seta sempre desloca no mesmo sentido que aponta na tela.
    var order: Array[int] = []
    for i in range(count):
        order.append(i)
    var horizontal: bool = abs(cells[count - 1].x - cells[0].x) > 0
    if horizontal:
        if arrow.y != 0:
            return
        order.sort_custom(func(a: int, b: int) -> bool: return cells[a].x < cells[b].x)
    else:
        if arrow.x != 0:
            return
        order.sort_custom(func(a: int, b: int) -> bool: return cells[a].y < cells[b].y)

    var slot: int = order.find(preview_anchor) if preview_parent == parent_index else -1
    var step: int = arrow.x if horizontal else arrow.y
    if slot < 0:
        # Começar perto do cruzamento inicial sem bloquear nenhuma letra.
        slot = mini(1, count - 1) if step > 0 else maxi(0, count - 2)
    else:
        # UMA casa no sentido físico da seta; sem inverter no eixo X.
        slot = posmod(slot + step, count)

    last_navigation_arrow = arrow
    var anchor_index: int = order[slot]
    var checked: int = 0
    while checked < count and not _inside_level(cells[anchor_index]):
        slot = posmod(slot + step, count)
        anchor_index = order[slot]
        checked += 1
    if not _inside_level(cells[anchor_index]):
        _message("Nenhuma letra desta palavra está na área principal.")
        return
    _select_anchor(parent_index, anchor_index)
    _message("Letra %s (%d/%d)" % [_anchor_letter(parent_index, anchor_index), slot + 1, count])

func _input(event: InputEvent) -> void:
    if game_over or (is_instance_valid(menu_overlay) and menu_overlay.visible):
        return
    var key_event := event as InputEventKey
    if key_event == null:
        return
    if not key_event.pressed or key_event.echo or key_event.ctrl_pressed or key_event.alt_pressed or key_event.meta_pressed:
        return
    var arrow := Vector2i.ZERO
    match key_event.keycode:
        KEY_UP: arrow = Vector2i(0, -1)
        KEY_DOWN: arrow = Vector2i(0, 1)
        KEY_LEFT: arrow = Vector2i(-1, 0)
        KEY_RIGHT: arrow = Vector2i(1, 0)
    if arrow != Vector2i.ZERO:
        _navigate_arrow_from_anywhere(arrow)
        get_viewport().set_input_as_handled()
        return
    if key_event.keycode == KEY_ENTER or key_event.keycode == KEY_KP_ENTER:
        if not entry.has_focus():
            _submit()
            get_viewport().set_input_as_handled()
        return
    if entry.has_focus():
        # Teclado nativo no celular: o próprio LineEdit atualiza os quadrados.
        return
    if key_event.keycode == KEY_BACKSPACE:
        _erase_character()
        get_viewport().set_input_as_handled()
        return
    if key_event.unicode > 0:
        var letter: String = String.chr(key_event.unicode).to_upper()
        if letter.length() == 1 and "ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÚÂÊÔÃÕÇ".contains(letter):
            _type_character(letter)
            get_viewport().set_input_as_handled()

func _navigate_arrow(direction: Vector2i) -> void:
    if preview_parent < 0 or preview_parent >= words.size():
        return
    var parent_dir: Vector2i = words[preview_parent]["dir"]
    var dot_product: int = parent_dir.x * direction.x + parent_dir.y * direction.y
    if dot_product != 0:
        # As setas paralelas percorrem letras na ordem visual, sem consultar
        # o dicionário e sem redefinir a direção perpendicular já escolhida.
        _select_anchor_by_arrow(direction)
    else:
        _apply_direction(direction)

func _clamp_camera_pan() -> void:
    var min_x: float = INF
    var max_x: float = -INF
    var min_y: float = INF
    var max_y: float = -INF
    for word in words:
        if word["state"] != "solved":
            continue
        for cell in _cells(word):
            min_x = minf(min_x, float(cell.x) * GAP)
            max_x = maxf(max_x, float(cell.x) * GAP)
            min_y = minf(min_y, float(cell.y) * GAP)
            max_y = maxf(max_y, float(cell.y) * GAP)
    if min_x == INF:
        return
    var margin: float = GAP * 1.5
    camera_pan_offset.x = clampf(camera_pan_offset.x, min_x - margin - camera_target.x, max_x + margin - camera_target.x)
    camera_pan_offset.y = clampf(camera_pan_offset.y, min_y - margin - (camera_target.z - 1.4), max_y + margin - (camera_target.z - 1.4))

func _pan_camera(screen_delta: Vector2) -> void:
    var viewport_height: float = maxf(1.0, get_viewport().get_visible_rect().size.y)
    var scale_factor: float = camera.size / viewport_height
    camera_pan_offset -= screen_delta * scale_factor
    _clamp_camera_pan()

func _zoom_camera(zoom_in: bool) -> void:
    _set_camera_zoom(camera_zoom_factor * (0.94 if zoom_in else 1.06))

func _set_camera_zoom(factor: float) -> void:
    camera_zoom_factor = clampf(factor, 0.85, 1.15)
    camera.size = 18.0 * camera_zoom_factor
    _sync_visible_board(true)

func _pinch_distance() -> float:
    var ids: Array = active_touches.keys()
    if ids.size() < 2:
        return 0.0
    return Vector2(active_touches[ids[0]]).distance_to(Vector2(active_touches[ids[1]]))

func _unhandled_input(event: InputEvent) -> void:
    if game_over or (is_instance_valid(menu_overlay) and menu_overlay.visible):
        return
    if event is InputEventMouseButton and event.pressed:
        if event.button_index == MOUSE_BUTTON_WHEEL_UP:
            _zoom_camera(true)
            return
        if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
            _zoom_camera(false)
            return
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if event.pressed:
                _start_pointer(event.position)
            else:
                _stop_pointer()
    elif event is InputEventMouseMotion and (pointer_down or panning_board):
        _move_pointer(event.position)
    elif event is InputEventScreenTouch:
        if event.pressed:
            active_touches[event.index] = event.position
            if active_touches.size() >= 2:
                suppress_touch_until_release = true
                pointer_down = false
                panning_board = false
                pointer_dragged = true
                pinch_last_distance = _pinch_distance()
                hud_gesture_fade = true
            elif not suppress_touch_until_release:
                _start_pointer(event.position)
        else:
            active_touches.erase(event.index)
            if active_touches.is_empty():
                if not suppress_touch_until_release:
                    _stop_pointer()
                suppress_touch_until_release = false
                pinch_last_distance = 0.0
                pointer_down = false
                panning_board = false
                hud_gesture_fade = false
            elif active_touches.size() == 1:
                pinch_last_distance = 0.0
    elif event is InputEventScreenDrag:
        if active_touches.has(event.index):
            active_touches[event.index] = event.position
        if active_touches.size() >= 2:
            var new_distance: float = _pinch_distance()
            if pinch_last_distance > 1.0 and new_distance > 1.0:
                _set_camera_zoom(camera_zoom_factor * pinch_last_distance / new_distance)
            pinch_last_distance = new_distance
        elif not suppress_touch_until_release and (pointer_down or panning_board):
            _move_pointer(event.position)

func _start_pointer(screen_pos: Vector2) -> void:
    pointer_start = screen_pos
    gesture_cursor = screen_pos
    pointer_cell = _screen_to_cell(screen_pos)
    # Gestos so comecam sobre uma letra resolvida e selecionavel.
    # Arrastar sobre espaco vazio nao deve alterar a palavra.
    pointer_down = false
    pointer_dragged = false
    panning_board = true
    pan_last_screen = screen_pos
    for i in range(words.size() - 1, -1, -1):
        if words[i]["state"] != "solved":
            continue
        if bool(words[i]["spawned"]) and not extra_branch_armed:
            continue
        if _inside_level(pointer_cell) and _cells(words[i]).has(pointer_cell):
            pointer_down = true
            panning_board = false
            break
    # As setas desenhadas continuam clicaveis fora das letras.
    if not pointer_down and _try_tap_branch_arrow(screen_pos):
        return

func _stop_pointer() -> void:
    panning_board = false
    hud_gesture_fade = false
    if pointer_down and not pointer_dragged:
        if not _try_tap_branch_arrow(pointer_start):
            _click_tile(pointer_cell)
    pointer_down = false

func _move_pointer(screen_pos: Vector2) -> void:
    if panning_board:
        if screen_pos.distance_to(pointer_start) >= 18.0:
            hud_gesture_fade = true
            _pan_camera(screen_pos - pan_last_screen)
        pan_last_screen = screen_pos
        return
    if not pointer_down or game_over:
        return
    if screen_pos.distance_to(pointer_start) < 30.0 and not pointer_dragged:
        return
    if not pointer_dragged:
        pointer_dragged = true
        hud_gesture_fade = true
        # O gesto so existe se comecou sobre uma letra valida.
        var drag_sources: Array[int] = []
        if preview_parent >= 0 and preview_parent < words.size():
            drag_sources.append(preview_parent)
        for i in range(words.size() - 1, -1, -1):
            if not drag_sources.has(i):
                drag_sources.append(i)
        for i in drag_sources:
            if words[i]["state"] != "solved":
                continue
            if bool(words[i]["spawned"]) and not extra_branch_armed:
                continue
            var anchor: int = _cells(words[i]).find(pointer_cell)
            if anchor >= 0:
                if preview_parent != i or preview_anchor != anchor:
                    last_navigation_arrow = Vector2i.ZERO
                    _select_anchor(i, anchor)
                break
        gesture_cursor = pointer_start

    var movement: Vector2 = screen_pos - gesture_cursor
    var attempts: int = 0
    while movement.length() >= DRAG_STEP_PX and attempts < 8:
        var arrow: Vector2i = _gesture_direction(movement)
        _navigate_arrow_from_anywhere(arrow)
        gesture_cursor += Vector2(float(arrow.x), float(arrow.y)) * DRAG_STEP_PX
        movement = screen_pos - gesture_cursor
        attempts += 1

func _gesture_direction(delta: Vector2) -> Vector2i:
    if absf(delta.x) > absf(delta.y):
        return Vector2i(1 if delta.x > 0.0 else -1, 0)
    return Vector2i(0, 1 if delta.y > 0.0 else -1)

func _navigate_arrow_from_anywhere(direction: Vector2i) -> void:
    if game_over:
        return
    if preview_parent >= 0:
        _navigate_arrow(direction)
        return
    if last_solved_word < 0 or last_solved_word >= words.size():
        return
    var parent_dir: Vector2i = words[last_solved_word]["dir"]
    if parent_dir.x * direction.x + parent_dir.y * direction.y != 0:
        _select_anchor_by_arrow(direction)
    else:
        # First perpendicular key selects the first physical letter, then sets direction.
        # Do not fabricate an extra arrow press or advance the cursor twice.
        _select_anchor(last_solved_word, 0)
        last_navigation_arrow = Vector2i.ZERO
        _apply_direction(direction)

func _apply_direction(direction: Vector2i) -> void:
    if preview_parent < 0 or preview_parent >= words.size():
        return
    var parent_dir: Vector2i = words[preview_parent]["dir"]
    if direction == Vector2i.ZERO or parent_dir.x * direction.x + parent_dir.y * direction.y != 0:
        return
    if direction == preview_dir:
        return
    # Manter a mesma palavra e a mesma ordem no LineEdit.
    # O array de casas muda de sentido, logo no tabuleiro ABELHA vira AHLEBA.
    _save_preview_draft()
    preview_dir = direction
    preferred_branch_direction = direction
    var key: String = _draft_key(preview_parent, preview_anchor)
    drafts[key] = {"text": entry.text.to_upper(), "dir": direction}
    _load_preview_choices()

func _focus_cell(cell: Vector2i) -> void:
    camera_pan_offset = Vector2.ZERO
    camera_target = Vector3(float(cell.x) * GAP, 25.0, float(cell.y) * GAP + 1.4)

func _focus_word(word: Dictionary) -> void:
    var cells: Array[Vector2i] = _cells(word)
    if cells.is_empty():
        return
    var midpoint: Vector2i = cells[cells.size() / 2]
    _focus_cell(midpoint)

func _sync_visible_board(force: bool = false) -> void:
    var center := Vector2i(roundi(camera.position.x / GAP), roundi(camera.position.z / GAP))
    if not force and center == visible_origin:
        return
    visible_origin = center
    var needed: Dictionary = {}
    # A malha cobre toda a largura projetada da camera, mesmo em ultrawide.
    var view_size: Vector2 = get_viewport().get_visible_rect().size
    var aspect: float = view_size.x / maxf(1.0, view_size.y)
    var radius_x: int = maxi(VISIBLE_RADIUS_X, ceili(camera.size * aspect / (2.0 * GAP)) + 4)
    var radius_y: int = maxi(VISIBLE_RADIUS_Y, ceili(camera.size / (2.0 * GAP)) + 4)
    for y in range(center.y - radius_y, center.y + radius_y + 1):
        for x in range(center.x - radius_x, center.x + radius_x + 1):
            var cell: Vector2i = Vector2i(x, y)
            if _inside_level_halo(cell):
                needed[cell] = true
    for p in board.keys():
        if not needed.has(p):
            board[p].queue_free()
            board.erase(p)
    for p in needed.keys():
        if board.has(p):
            continue
        var tile := MeshInstance3D.new()
        tile.mesh = shared_tile_mesh
        tile.material_override = _material_cached("outer_zone", Color("#24202e")) if level_mode and not _inside_level(p) else _material_cached("base", BASE)
        tile.position = Vector3(p.x * GAP, 0.0, p.y * GAP)
        add_child(tile)
        board[p] = tile
    _refresh_board()

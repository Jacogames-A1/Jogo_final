extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var cor_esperada: String
var ocupada: bool = false
var acertou: bool = false
var caixa_colocada = null

func _ready() -> void:
	add_to_group("base_puzzle")
	cor_esperada = sprite.animation
	body_exited.connect(_on_body_exited)

func receber_caixa(caixa) -> void:
	if ocupada:
		return
	ocupada = true
	caixa_colocada = caixa
	acertou = (caixa.cor == cor_esperada)
	caixa.colocar_em(global_position)
	_verificar_puzzle()

func devolver_caixa() -> Variant:
	if not ocupada or acertou:
		return null
	var caixa = caixa_colocada
	caixa_colocada = null
	ocupada = false
	caixa.pegar()
	return caixa

func _verificar_puzzle() -> void:
	var bases = get_tree().get_nodes_in_group("base_puzzle")
	if bases.all(func(b): return b.acertou):
		Global.puzzle_solved = true

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("entrar_base"):
		body.entrar_base(self)

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("sair_base"):
		body.sair_base(self)

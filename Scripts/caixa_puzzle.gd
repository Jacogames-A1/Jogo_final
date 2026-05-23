extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var cor: String

func _ready() -> void:
	cor = sprite.animation
	body_exited.connect(_on_body_exited)

func pegar() -> void:
	hide()
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)

func colocar_em(posicao: Vector2) -> void:
	global_position = posicao
	show()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("entrar_caixa"):
		body.entrar_caixa(self)

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("sair_caixa"):
		body.sair_caixa(self)

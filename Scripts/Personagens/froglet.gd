extends CharacterBody2D


var estados = ["andar", "ataque1"]
var estado_sorteado = "andar"
var hit = false
var flag_boss = false
var alvo: Node2D = null
@onready var animacao = $Animacao
@onready var colisao = $Colisao


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	alvo = get_tree().get_first_node_in_group("jogador")
	if alvo == null:
		alvo = get_node_or_null("/root/Nivel_2/Bethany")


func _physics_process(delta: float) -> void:
	if estado_sorteado == "idle":
		animacao.hide()
		colisao.disabled = true
		velocity.x = move_toward(velocity.x, 0, SPEED)
	elif estado_sorteado == "andar" and not hit:
		animacao.show()
		animacao.play("andar")
		colisao.disabled = false
		_mover_para_alvo()
	elif estado_sorteado == "ataque1" and not hit:
		animacao.show()
		animacao.play("ataque1")
		colisao.disabled = false
		velocity.x = move_toward(velocity.x, 0, SPEED)
	elif hit:
		animacao.show()
		animacao.play("hit")
		colisao.disabled = false
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func _mover_para_alvo() -> void:
	if alvo == null:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		return
	var direcao = sign(alvo.global_position.x - global_position.x)
	velocity.x = direcao * SPEED
	animacao.flip_h = direcao < 0


func _on_boss_visivel_screen_entered() -> void:
	flag_boss = true
	if alvo == null:
		alvo = get_node_or_null("/root/Nivel_2/Bethany")
	_loop_FCM()


func _on_boss_visivel_screen_exited() -> void:
	flag_boss = false
	estado_sorteado = "idle"


func _loop_FCM() -> void:
	while flag_boss:
		estado_sorteado = estados.pick_random()
		await get_tree().create_timer(2.0).timeout

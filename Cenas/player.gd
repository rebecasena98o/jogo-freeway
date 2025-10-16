extends Area2D

signal pontua
@export var speed: float = 100.0
var screen_size: Vector2
var posicao_inicial: Vector2 = Vector2(369,696)

func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = posicao_inicial

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("sobe"):
		velocity.y -= 1
	if Input.is_action_pressed("desce"):
		velocity.y += 1
	if Input.is_action_pressed("esquerda"):
		velocity.x -= 1
	if Input.is_action_pressed("direita"):
		velocity.x += 1
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.y = clamp(position.y, 0.0, screen_size.y)
		
	if velocity.y > 0: 
		$Animacao.play("baixo")
	elif velocity.y < 0:
		$Animacao.play("cima")
	else:
		$Animacao.stop()


func _on_body_entered(body: Node2D) -> void:
	print("Sinal pontua emitido!")
	if body.name == "LinhaChegada":
		emit_signal("pontua")
	else:
		$Audio.play()
		position = posicao_inicial
		

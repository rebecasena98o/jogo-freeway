extends Area2D

signal pontua2
@export var speed: float = 100.0
var screen_size: Vector2
var posicao_inicial: Vector2 = Vector2(896,696)

func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = posicao_inicial

func _process(delta: float) -> void:
	var velocity2 = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity2.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity2.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity2.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity2.x += 1
	if velocity2 != Vector2.ZERO:
		velocity2 = velocity2.normalized() * speed
		
	position += velocity2 * delta
	position.y = clamp(position.y, 0.0, screen_size.y)
		
	if velocity2.y > 0: 
		$Animacao2.play("Baixo")
	elif velocity2.y < 0:
		$Animacao2.play("Cima")
	else:
		$Animacao2.stop()


func _on_body_entered(body: Node2D) -> void:
	print("Sinal pontua emitido!")
	if body.name == "LinhaChegada":
		emit_signal("pontua2")
	else:
		$Audio2.play()
		position = posicao_inicial
	

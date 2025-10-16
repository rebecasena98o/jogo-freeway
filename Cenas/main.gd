extends Node

var cena_carros = preload("res://cenas/carros.tscn")
var pistas_rapidas_y = [104, 272, 488]
var pistas_lentas_y = [160, 216, 324, 384, 438, 544, 600]

var score = 0
var score2 = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = $TimerGame
	
	timer.start()
	$HUD/Placar.text = str(score)
	$HUD/Mensagem.text = " "
	$HUD/Button.hide()
	$AudioTema.play()
	$HUD/Perdeu.hide()
	

func _on_timer_carros_rapidos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro)
	var pista_y = pistas_rapidas_y[randi_range(0, pistas_rapidas_y.size() -1)]
	carro.position = Vector2(1294, pista_y)  # Inicia à direita da tela
	
	carro.set_linear_velocity(Vector2(randf_range(-453, -460), 0))  # Velocidade negativa
	carro.set_linear_damp(0)


func _on_timer_carros_lentos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro)
	var pista_y = pistas_lentas_y[randi_range(0, pistas_lentas_y.size() -1)]
	carro.position = Vector2(-10, pista_y)
	carro.set_linear_velocity(Vector2(randf_range(290, 270), 0))
	carro.set_linear_damp(0)


	

func _on_player_pontua() -> void:
	if score <= 10:
		score += 1
		$HUD/Placar.text = str(score)
		$AudioPonto.play()
		$Player.position = $Player.posicao_inicial
		# Adicionando um prêmio especial ao atingir 5 pontos
	
	if score == 5:
		$Player.speed += 50  # Aumenta a velocidade do jogador
		$HUD/Mensagem.text = "Player 1 você ganhou um prêmio especial!"
		await get_tree().create_timer(3).timeout
		$HUD/Mensagem.text = " "

	if score == 10:
		$HUD/Mensagem.text = "Parabéns, você venceu"
		$HUD/Button.show()
		$TimerCarrosRapidos.stop()
		$TimerCarrosLentos.stop()
		$AudioTema.stop()
		$AudioVitoria.stop()
		$TimerGame.stop()
		$Player.speed = 0
		$Player2.speed = 0
		$Player.position = $Player.posicao_inicial
		$Player2.position = $Player2.posicao_inicial
		


func _on_hud_reinicia() -> void:
	get_tree().reload_current_scene()


func _on_audio_tema_finished() -> void:
	$AudioTema.play()


func _on_player_2_pontua_2() -> void:
	print("Teste")
	if score2 <= 10:
		score2 += 1
		$HUD/Placar2.text = str(score2)
		$AudioPonto.play()
		$Player2.position = $Player2.posicao_inicial
		# Adicionando um prêmio especial ao atingir 5 pontos
	
	if score2 == 5:
		$Player2.speed += 50  # Aumenta a velocidade do jogador
		$HUD/Mensagem.text = "Player 2 você ganhou um prêmio especial!"
		await get_tree().create_timer(3).timeout
		$HUD/Mensagem.text = " "
		
	if score2 == 10:
		$HUD/Mensagem.text = "Parabéns, você venceu"
		$HUD/Button.show()
		$TimerCarrosRapidos.stop()
		$TimerCarrosLentos.stop()
		$AudioTema.stop()
		$AudioVitoria.stop()
		$TimerGame.stop()
		$Player.speed = 0
		$Player2.speed = 0
		$Player.position = $Player.posicao_inicial
		$Player2.position = $Player2.posicao_inicial
		
		


func _on_timer_game_timeout() -> void:
	$HUD/Perdeu.show()
	$TimerCarrosRapidos.stop()
	$TimerCarrosLentos.stop()
	$AudioTema.stop()
	$HUD/Button.show()
	$TimerGame.stop()
	$Player.speed = 0
	$Player2.speed = 0
	$Player.position = $Player.posicao_inicial
	$Player2.position = $Player2.posicao_inicial
	
	if score > score2:
		$HUD/Perdeu.hide()
		$HUD/Mensagem.text = "Parabéns player 1 você venceu"
		
	if score2 > score:
		$HUD/Perdeu.hide()
		$HUD/Mensagem.text = "Parabéns player 2 você venceu"
		
	
		
	

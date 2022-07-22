=begin 
	Primer paso: Crear archivo de texto con las preguntas y respuestas que tendra el juego.
	Segundo paso: Plantear que clases necesitaré, así como cada uno de sus atributos y métodos.
	Tercer paso: Escribir cada uno de los métodos y hacer pruebas de estos.
	Cuarto paso: Finalizar con la interfaz de la consola (inputs, mensajes al usuario etc).
=end

class Datos
	def almacenarPreguntasYRespuestas
		preguntas = []
		respuestas = []

		File.open('data.txt', 'r') do |file|
			file.readlines.each_with_index do |line, i|
				if line.start_with?('¿')
					preguntas << line
				end
			end
		end

		File.open('data.txt', 'r') do |file|
			file.readlines.each_with_index do |line, i|
				if line.start_with?('R:')
					line.delete!('R: ')
					respuestas << line
				end
			end
		end

		data = {}

		preguntas.each_with_index do |pregunta, index|
			data[pregunta.delete("\n")] = respuestas[index].delete("\n")
		end

		return data
	end

end

class Usuario

	def obtenerRespuesta
		print "Adivinar: "
		respuesta = gets.chomp
		puts
		return respuesta
	end

	def validarRespuesta(respuestaUsuario, respuestaCorrecta)
		if respuestaUsuario.downcase == respuestaCorrecta.downcase
			puts "Correcto!"
			puts
			return true
		else 
			puts "Incorrecto, intenta de nuevo"
			puts
			return false
		end
	end

end



class Main

	def iniciar
		datos = Datos.new
		user = Usuario.new
		data = datos.almacenarPreguntasYRespuestas

		puts "Bienvenido a reto 5, Para jugar, solo ingresa el termino correcto para cada una de las definiciones, Listo? Vamos!"
		puts
     		
		data.each do |key, value|
			puts "Definición:\n\n#{key}"
			puts
			loop do
				respuesta = user.obtenerRespuesta

				validacionRespuesta = user.validarRespuesta(respuesta, value)

				if validacionRespuesta == true
					break
				end
			end
		end
	end

end

partida = Main.new
partida.iniciar
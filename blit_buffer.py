import st7789
from tft_config import config

tft = config()
tft.init()

# Crear un buffer de tamaño adecuado, 240 (ancho) x 135 (alto) = 32400 pixeles
# RGB565 necesita 2 bytes por pixel, por lo que el tamaño del buffer sera 240 * 135 * 2
width = 240
height = 135
buffer = bytearray(width * height * 2)

# Llenar el buffer con datos, por ejemplo, un color solido(RGB565, 2 bytes por pixel)
color = 0xF800 # Rojo en formato RGB565
for i in range(0, len(buffer), 2):
    buffer[i] = color >> 8 # Primer byte (MSB)
    buffer[i + 1] = color & 0xFF # Segundo byte (LSB)

# Blit (copiar) el buffer a la pantalla
tft.blit_buffer(buffer, 0, 0, width, height)
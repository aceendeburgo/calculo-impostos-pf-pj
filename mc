import pygame
import math
import sys
import random


# Inicializa o Pygame
pygame.init()


# Configurações da tela
largura, altura = 800, 600
tela = pygame.display.set_mode((largura, altura))
pygame.display.set_caption("Coração de Maria Clara 💘")


# Cores
VERMELHO = (255, 0, 0)
ROXO = (180, 0, 255)
BRANCO = (255, 255, 255)
VERDE = (60, 179, 113)
ROSA = (255, 182, 193)
PRETO = (0, 0, 0)
AMARELO = (255, 220, 120)


# Fonte
fonte_grande = pygame.font.SysFont("arial", 80, True)
fonte_media = pygame.font.SysFont("arial", 50, True)


# Flores animadas (melhor desenho: pétalas + caule)
flores = []
for _ in range(60):
    flores.append({
        "x": random.randint(20, largura - 20),
        "y": random.randint(altura // 2, altura - 30),
        "fase": random.uniform(0, 2 * math.pi),
        "vel": random.uniform(0.005, 0.02),
        "tam": random.uniform(6, 12),
        "petalas": random.randint(4, 6),
        "cor": (
            random.randint(240, 255),
            random.randint(120, 200),
            random.randint(150, 255)
        )
    })




def desenhar_flor(tela, flor, t):
    # leve balanço
    flor["fase"] += flor["vel"]
    sway = math.sin(flor["fase"]) * 6
    x = flor["x"] + sway
    y = flor["y"]


    # caule
    pygame.draw.line(tela, (30, 120, 60), (int(x), int(y)), (int(x), altura), 2)


    # pétalas: desenhadas como elipses rotacionadas (aproximação)
    petals = flor["petalas"]
    angle_offset = flor["fase"] * 20
    for i in range(petals):
        ang = i * (2 * math.pi / petals) + angle_offset
        px = x + math.cos(ang) * flor["tam"]
        py = y + math.sin(ang) * (flor["tam"] * 0.7)
        # pétala com leve gradiente (círculos sobrepostos)
        pygame.draw.ellipse(tela, flor["cor"], (int(px - flor["tam"] * 0.8 / 2), int(py - flor["tam"] * 0.5 / 2), int(flor["tam"] * 0.8), int(flor["tam"] * 0.5)))
        pygame.draw.circle(tela, BRANCO, (int(px), int(py)), max(1, int(flor["tam"] * 0.12)))


    # miolo
    pygame.draw.circle(tela, AMARELO, (int(x), int(y)), max(3, int(flor["tam"] * 0.35)))




# Função: desenhar fundo verde com flores que balançam
def desenhar_fundo(t):
    tela.fill(VERDE)
    # algumas manchas de grama para profundidade
    for i in range(40):
        gx = (i * 37) % largura
        gy = altura - 10 + int(math.sin(t + i) * 4)
        pygame.draw.circle(tela, (40, 150, 80), (gx, gy), random.randint(2, 4))


    for flor in flores:
        desenhar_flor(tela, flor, t)




# Função: desenhar o coração (com leve brilho)
def desenhar_coracao(surface, x, y, tamanho, cor=VERMELHO, contorno=BRANCO):
    pontos = []
    # maior resolução para suavidade
    for deg in range(0, 360, 1):
        ang = math.radians(deg)
        px = 16 * math.sin(ang) ** 3
        py = 13 * math.cos(ang) - 5 * math.cos(2 * ang) - 2 * math.cos(3 * ang) - math.cos(4 * ang)
        pontos.append((x + px * tamanho, y - py * tamanho))
    pygame.draw.polygon(surface, cor, pontos)
    # contorno suave
    pygame.draw.aalines(surface, contorno, True, pontos, 1)




# Função: partículas de explosão
class Particula:
    def __init__(self, x, y):
        self.x = x + random.uniform(-10, 10)
        self.y = y + random.uniform(-10, 10)
        self.vx = random.uniform(-4, 4)
        self.vy = random.uniform(-4, 4)
        self.tamanho = random.randint(2, 5)
        self.vida = 255


    def atualizar(self):
        self.x += self.vx
        self.y += self.vy
        self.vida -= 6
        self.vy += 0.12  # gravidade suave


    def desenhar(self, tela):
        if self.vida > 0:
            cor = (ROSA[0], ROSA[1], ROSA[2], max(0, int(self.vida)))
            superficie = pygame.Surface((self.tamanho * 2 + 4, self.tamanho * 2 + 4), pygame.SRCALPHA)
            pygame.draw.circle(superficie, cor, (superficie.get_width() // 2, superficie.get_height() // 2), self.tamanho)
            tela.blit(superficie, (int(self.x - superficie.get_width() // 2), int(self.y - superficie.get_height() // 2)))




# Função auxiliar: desenhar texto com alpha
def desenhar_texto_alpha(tela, texto_str, fonte, cor_texto, x, y, alpha=255):
    texto = fonte.render(texto_str, True, cor_texto)
    superficie_texto = pygame.Surface(texto.get_size(), pygame.SRCALPHA)
    superficie_texto.blit(texto, (0, 0))
    superficie_texto.set_alpha(alpha)
    tela.blit(superficie_texto, (x, y))




# Loop principal
relogio = pygame.time.Clock()
rodando = True
etapa = 0
tempo_inicial = pygame.time.get_ticks()
particulas = []
alpha_texto = 0
t = 0


# Layout positions
HEART_X = largura // 2
HEART_Y = altura // 2 - 120  # coração acima das frases
tamanho_base_coracao = 5.2   # maior, pois agora fica mais acima


# Posições das frases (acima das flores)
NOME_X = largura // 2
NOME_Y = altura // 2 - 50


FRASE_X = largura // 2
FRASE_Y = altura // 2 - 10


while rodando:
    for evento in pygame.event.get():
        if evento.type == pygame.QUIT:
            rodando = False


    t += 0.03
    desenhar_fundo(t)


    if etapa == 0:
        # Coração pulsando suavemente (acima das frases)
        tamanho = tamanho_base_coracao + math.sin(t * 2.2) * 0.25
        # leve flutuação vertical do coração
        y_offset = math.sin(t * 1.2) * 6
        desenhar_coracao(tela, HEART_X, HEART_Y + y_offset, tamanho)
        if pygame.time.get_ticks() - tempo_inicial > 3000:
            # Sem flecha: ir direto para explosão
            etapa = 2
            for _ in range(140):
                # partículas surgem perto do local das frases para um efeito centralizado
                particulas.append(Particula(NOME_X, NOME_Y + 20))
            tempo_inicial = pygame.time.get_ticks()
            alpha_texto = 0
    elif etapa == 2:
        # Explosão + Nome surgindo (as partículas surgem onde as frases estarão)
        # desenhar coração por trás (permanece acima visualmente porque está em y menor)
        desenhar_coracao(tela, HEART_X, HEART_Y, tamanho_base_coracao)
        for p in particulas:
            p.atualizar()
            p.desenhar(tela)
        particulas = [p for p in particulas if p.vida > 0]


        # fade-in do nome (acima das flores)
        if alpha_texto < 255:
            alpha_texto += 4
        nome_texto = "Te amo, Clara"
        nome_render = fonte_grande.render(nome_texto, True, ROSA)
        desenhar_texto_alpha(tela, nome_texto, fonte_grande, ROSA, NOME_X - nome_render.get_width() // 2, NOME_Y, alpha_texto)


        # transição para texto final após alguns segundos
        if pygame.time.get_ticks() - tempo_inicial > 4000:
            etapa = 3
            tempo_inicial = pygame.time.get_ticks()
            alpha_texto = 0
    elif etapa == 3:
       
        # desenhar o coração acima das frases (no topo), ainda pulsando levemente
        pulsar = 1.0 + math.sin(t * 2) * 0.03
        desenhar_coracao(tela, HEART_X, HEART_Y, tamanho_base_coracao * pulsar)


    pygame.display.flip()
    relogio.tick(60)


pygame.quit()
# 🧮 Cálculo de Impostos — Pessoa Física e Jurídica

Este projeto tem como objetivo calcular os impostos sobre a renda mensal de um contribuinte, identificando se ele é **Pessoa Física (PF)** ou **Pessoa Jurídica (PJ)**.  
O código foi desenvolvido em **Python** e serve como uma aplicação prática dos conceitos de **estruturas condicionais**, **funções** e **tratamento de erros**.

---

## 📘 Descrição do Programa

O programa solicita ao usuário:

- Nome do contribuinte  
- Renda mensal (em reais)  
- Tipo de pessoa — **PF (Pessoa Física)** ou **PJ (Pessoa Jurídica)**  

Com base nesses dados, o sistema realiza o cálculo de impostos conforme as regras de tributação aplicáveis a cada tipo de contribuinte.

---

## 👤 Funcionamento — Pessoa Física (PF)

O cálculo é realizado de acordo com as faixas do **Imposto de Renda da Pessoa Física (IRPF)** vigentes em **2025**, conforme a tabela da Receita Federal.  
O programa identifica automaticamente a faixa de renda e aplica a alíquota correspondente, retornando:

- Faixa aplicada (em %)  
- Valor do imposto devido  
- Renda líquida após o desconto  

---

## 🏢 Funcionamento — Pessoa Jurídica (PJ)

A simulação utiliza um modelo simplificado do regime de **Lucro Presumido**, aplicando as seguintes alíquotas:

| Tributo | Alíquota |
|----------|-----------|
| IRPJ     | 15%       |
| CSLL     | 9%        |
| PIS      | 0,65%     |
| COFINS   | 3%        |

O programa calcula cada tributo individualmente e apresenta:

- O valor de cada imposto  
- O total de tributos pagos  
- A receita líquida restante  

---

## 💻 Exemplo de Execução

=== Cálculo de Impostos ===

Nome do contribuinte: Ana Souza
Renda mensal (R$): 4200
Pessoa Física (PF) ou Jurídica (PJ)? PF

--- Resultado ---
Contribuinte: Ana Souza

Tipo: Pessoa Física

Renda Bruta: R$ 4.200,00

Faixa aplicada: 15.0%

IRPF devido: R$ 353,89

Renda Líquida: R$ 3.846,11


---

## 🧩 Estrutura do Código

- `calcular_imposto_pf(renda)`: calcula o IRPF conforme a faixa de renda.  
- `calcular_imposto_pj(renda)`: calcula IRPJ, CSLL, PIS e COFINS.  
- `main()`: executa o programa, solicita os dados do usuário e exibe os resultados.

O código também realiza o **tratamento de erros** para garantir que o usuário insira valores válidos.

---

## 🧠 Conceitos Aplicados

- Funções em Python  
- Estruturas condicionais (`if`, `else`)  
- Estruturas de repetição (`for`)  
- Manipulação de strings  
- Conversão de tipos e tratamento de exceções (`try/except`)

---

## ⚙️ Como Executar

1. Certifique-se de ter o **Python 3.12** ou superior instalado.  
2. Salve o código em um arquivo chamado **`IR.py`**.  
3. No terminal, acesse o diretório do arquivo e execute:

   ```bash
   python3 IR.py
Siga as instruções exibidas na tela.

🎓 Finalidade Educacional

Este código foi desenvolvido como exercício prático no curso de Bacharelado em Sistemas de Informação, com o intuito de demonstrar a aplicação de lógica de programação e noções básicas de tributação no Brasil.

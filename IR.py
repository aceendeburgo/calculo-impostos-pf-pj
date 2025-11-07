def calcular_imposto_pf(renda):
    # Faixas do IRPF 2025 - Receita Federal
    faixas = [
        (2259.20, 0.0),
        (2826.65, 0.075),
        (3751.05, 0.15),
        (4664.68, 0.225),
        (float("inf"), 0.275)
    ]

    base_anterior = 0
    imposto_total = 0
    aliquota_aplicada = 0

    # Calcula o imposto conforme as faixas
    for limite, aliquota in faixas:
        if renda > limite:
            imposto_total += (limite - base_anterior) * aliquota
            base_anterior = limite
        else:
            imposto_total += (renda - base_anterior) * aliquota
            aliquota_aplicada = aliquota
            break

    return imposto_total, aliquota_aplicada


def calcular_imposto_pj(renda):
    # Simulação simples de tributos PJ (Lucro Presumido)
    irpj = renda * 0.15
    csll = renda * 0.09
    pis = renda * 0.0065
    cofins = renda * 0.03

    total = irpj + csll + pis + cofins
    return total, {"IRPJ": irpj, "CSLL": csll, "PIS": pis, "COFINS": cofins}


def main():
    print("=== Cálculo de Impostos ===\n")

    nome = input("Nome do contribuinte: ").strip()
    entrada = input("Renda mensal (R$): ").strip().replace(",", ".")
    
    try:
        renda = float(entrada)
    except ValueError:
        print("Valor inválido. Digite apenas números, por exemplo: 4500.00")
        return

    tipo = input("Pessoa Física (PF) ou Jurídica (PJ)? ").strip().upper()

    print("\n--- Resultado ---")

    if tipo == "PF":
        imposto, aliquota = calcular_imposto_pf(renda)
        print(f"Contribuinte: {nome}")
        print(f"Tipo: Pessoa Física")
        print(f"Renda Bruta: R$ {renda:,.2f}")
        print(f"Faixa aplicada: {aliquota * 100:.1f}%")
        print(f"IRPF devido: R$ {imposto:,.2f}")
        print(f"Renda Líquida: R$ {renda - imposto:,.2f}")

    elif tipo == "PJ":
        imposto, detalhes = calcular_imposto_pj(renda)
        print(f"Contribuinte: {nome}")
        print(f"Tipo: Pessoa Jurídica")
        print(f"Receita Bruta: R$ {renda:,.2f}")
        print("\nTributos aplicados:")
        for nome_trib, valor in detalhes.items():
            print(f" • {nome_trib}: R$ {valor:,.2f}")
        print(f"\nTotal de Tributos: R$ {imposto:,.2f}")
        print(f"Receita Líquida: R$ {renda - imposto:,.2f}")

    else:
        print("Tipo inválido. Digite apenas 'PF' ou 'PJ'.")


if __name__ == "__main__":
    main()
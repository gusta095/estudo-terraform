import json
import random

def lambda_handler(event, context):
    nome_completo = "Gustavo Ferreira de Souza"
    idade_aleatoria = random.randint(20, 40)

    mensagem = f"Nome: {nome_completo}, Idade: {idade_aleatoria}"
    print(mensagem)

    return {
        "statusCode": 200,
        "body": json.dumps({"mensagem": mensagem})
    }

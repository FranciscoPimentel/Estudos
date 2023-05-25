n1 = int(input('digite um valor: '))
n2 =int(input('digite um outro valor:'))
s = n1 + n2 
print('A soma vale entre {} e {}, vale {}'.format (n1,n2,s))
#len = comprimento
#count =  contagem exemplo frase.count('o',0,13) conta quantidade da letra o da posição zero até a 13.
#find('string')
#exemplo in frase = operador in
#replace substituir fase.replace('o que procura','o que quer')
#frase.upper() transforma para maísculo
#lower transforma para minísculo
#capitalize() vai jogar os caracteres para minisculo e manter a primeira maisculo
#title() ele analisa a frase a frase em titulo. 
#strip() remover os espaços inuteis. 
#rstrip() remove espaços pela direita 
#lstri() esquerda 
#split() é feito em espaços divide 
#join() junção da frase '-'.join(frase)
frase = 'cursO em video python'
print (frase[3:13])
print (frase[1: :2])
print(frase.count('o'))
print(frase.upper().count('O'))
print(len(frase))

velocidade =  float(input("Qual a velocidade atual do carro?  "))
if velocidade > 80:
    print ("multado")
    multa =  (velocidade-80) * 7
    print("vc deve pagar a multa de R${:.2f}!" .format(multa))
print("dirija com segurança")    
----
numero = int(input("digite um numero: "))
resultado = numero % 2
if resultado == 0:
    print (" o número {} é PAR ".format(numero))
else:
    print (" o número {} é IMPAR ".format(numero))
    
    https://cienciaprogramada.com.br/2022/03/formatacao-strings-python/#:~:text=M%C3%A9todo%20format,-Forma%20introduzida%20no&text=print('Controlando%20%7B2%7D,ser%20reutilizada%3A%20%7Bp%7D.
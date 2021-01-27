# prime numbers under N
def PrimeNums(N):
	for num in range(2, N + 1):
		if N == 2:
			prime = True
		prime = True
		for i in range(2, num):
			if num % i == 0:
				prime = False
		if prime :
			print(num)

PrimeNums(10)

#put prime numbers in a list, and calc the count
def PrimeList(N):
	primes = []
	for num in range(2, N + 1):
		
		if N == 2:
			prime = True
		prime = True
		for i in range(2, num):
			if num % i == 0:
				prime = False
		if prime :
			primes.append(num)
	print(primes)
	print(len(primes))



PrimeList(9)
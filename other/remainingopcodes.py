fref = open("finishedOpcodes.txt", "r")

x = fref.read().split("\n")
j = 0

print("DONE")
for i in range(0,256):
	if i > 0 and i % 16 == 0:
			print("")
	if str(hex(i)) == x[j].lower():
		print("0x{:02X}".format(int(x[j], 16)), end=" ")
		if j == len(x)-1:
			print("end")
			break
		j+=1
	else:
		print("     ", end="")

print("--------------------------"*3+"-")
print("NOT DONE")
fref = open("finishedOpcodes.txt", "r")
x = fref.read().split("\n")
j = 0

for i in range(0,257):
	if (i > 0 and i % 16 == 0): #or i == 256:
			print("")
	try:
		if str(hex(i)) != x[j].lower():
			print("0x{:02X}".format(i), end=" ")
		else:
			print("     ", end="")
			j+=1
	except:
		print("", end="")

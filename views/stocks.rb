import urllib
import os
import string

def readWebPage(url):
    assert(url.startswith("http://"))
    fin = contents = None
    try:
        fin = urllib.urlopen(url)
        contents = fin.read()
    finally:
        if (fin != None): fin.close()
    return contents

# confirmed
def getEPS(source):
	start = source.find(">EPS next Y")
	start = source.find("<b>",start)
	end = source.find("</b>",start)
	start += len("<b>")
	global epsTtm
	epsTtm = float(source[start:end])
	print "epsTtm -->",epsTtm

# confirmed
def getDividend(source):
	start = source.find(">Dividend %")
	start = source.find("<b>",start)
	end = source.find("%",start)
	start += len("<b>")
	global dividend
	dividend = source[start:end]
	if dividend[0] != "-":
		dividend = float(dividend)/100
	else:
		dividend = 0
	print "Dividend -->",dividend*100,"%"

# confirmed
def getPrice(source):
	start = source.find("Prev Close")
	start = source.find("Price",start)
	start = source.find("<b>",start)
	end = source.find("</b>",start)
	start += len("<b>")
	global price
	price = float(source[start:end])
	print "Price -->",price

# confirmed - with colors
def getFuturePE(source):
	start = source.find("Forward P/E")
	start = source.find("<b>",start)
	end = source.find("</b>",start)
	start += len("<b>")
	global futurePE
	futurePE = source[start:end]
	if futurePE == "-":
		print "ERROR: No Forward P/E"
		raise Exception("No Forward P/E")
	if not(futurePE[0].isdigit()):
		start = source.find('>',start) + len(">") # start + 1
		end = source.find("<",start)
	futurePE = float(source[start:end])
	print "Forward PE -->",futurePE

# confirmed 
def getEpsGrowth(source):
	start = source.find("EPS next 5Y")
	start = source.find("<b>",start)
	end = source.find("%</b>",start)
	start += len("<b>")
	global epsGrowth
	epsGrowth = source[start:end]
	if epsGrowth[0] == "-":
		print "ERROR: No EPS Projection"
		raise Exception("No EPS Projection")
	if not(epsGrowth[0].isdigit()):
		start = source.find('>',start) + len(">") # start + 1
		end = source.find("%",start)
	epsGrowth = source[start:end]

	epsGrowth = float(source[start:end]) / 100
	print "EPS Growth -->",epsGrowth

def getData(company):
	print company.upper() + "\n"
	url = "http://finviz.com/quote.ashx?t=%s&ty=c&ta=1&p=d" % company
	source = readWebPage(url)

	epsTtm = getEPS(source)

	dividend = getDividend(source)

	price = getPrice(source)

	futurePE = getFuturePE(source)

	epsGrowth = getEpsGrowth(source)

def writeFile(filename, contents, mode="wt"):
    # wt = "write text"
    with open(filename, mode) as fout:
        fout.write(contents)

###################################################################

# C105
def priceNeededForAnnualReturn():
	# C104
	endPrice = endPriceFunc()
	result = endPrice / ((1+desiredReturn)**holdingTime)
	return result

# C104
def endPriceFunc():
	# C101
	expectedPrice = expectedPriceFunc()
	# C103
	dividendsReceived = dividendsReceivedFunc()
	result = expectedPrice + dividendsReceived
	return result

# C103
def dividendsReceivedFunc():
	# C102
	epsReceived = epsReceivedFunc()
	# C99
	dividendPayoutRatio = dividendPayoutRatioFunc()
	result = epsReceived * dividendPayoutRatio
	return result

# C102
def epsReceivedFunc():
	tempEPS = epsTtm
	totalResult = 0
	# sum of years until holding time times their respective values of EPS (ttm)
	for y in xrange(1,holdingTime+1):
		tempEPS *= (1+epsGrowth)
		totalResult += tempEPS
	return totalResult

# C101
def expectedPriceFunc():
	# C100
	endEPS = endEPSFunc()
	result = endEPS * futurePE
	return result

# C100
def endEPSFunc():
	result = epsTtm*(1+epsGrowth)**holdingTime
	return result

# C99
def dividendPayoutRatioFunc():
	# C98
	divPerShare = price*dividend
	result = divPerShare / (epsTtm * (1 + epsGrowth)**holdingTime)
	return result

def main(companies):
	stockList = "Ticker\tCurrent Price\tProjected Price"
	for company in companies.splitlines():
		try:
			getData(company)
		except:
			# values missing for company
			continue
		priceNeeded = priceNeededForAnnualReturn()
		projectedPrice = endPriceFunc()
		print "Projected Price -->", projectedPrice
		if priceNeeded > price:
			print "\n*** Buy ***\n"
			string = company.upper() + "\t" + str(price) + "\t" + str(projectedPrice) + "\t" + "Buy"
		else:
			print "\n*** Too Expensive ***\n"
			string = company.upper() + "\t" + str(price) + "\t" + str(projectedPrice)
		stockList += "\n" + string
		writeFile("stockProjections.txt",stockList)
	print "\nFinished!"

def companies():
	return """cmg"""

desiredReturn = .15 # % per annum
holdingTime = 1 # years

main(companies())
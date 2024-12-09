def cleanDomain(domain: str):
    cleandomain = domain.split("/")[2]
    return cleandomain

print(cleanDomain(input("domain :")))
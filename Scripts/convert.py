import json
import sys
import uuid

origPath = sys.argv[1]
origFile = open(str(origPath), "r")
origJson = json.load(origFile)

schoolType = origJson["scuolaType"]
categorie = origJson["categorie"]

newCategorie = list()
for cat in categorie:
	oldDomande = cat["domande"]
	newDomande = list()

	for oldDomanda in oldDomande:
		newDomanda = {
			"id" : str(uuid.uuid4()),
			"str" : oldDomanda
		}
		newDomande.append(newDomanda)

	newCat = {
		"name" : cat["nome"],
		"id" : str(uuid.uuid4()),
		"domande" : newDomande
	}
	newCategorie.append(newCat)

newObj = {
	"schoolType" : schoolType,
	"categorie" : newCategorie
}


if len(sys.argv) > 2:
	with open(sys.argv[2], 'w', encoding='utf-8') as f:
		json.dump(newObj, f, ensure_ascii=False, indent=4)





jar = {
    "lineSkips": 1, # Skip the base of the jar
    "height": 11, # Height you want filled to, 12 will be the very top of the jar
    "width": 20,
    "fillLines": [(3,16),(2,17),(2,17),(2,17),(2,17),(2,17),(2,17),(2,17),(2,17),(2,17),(2,17),(3,16)], 
    "text":"""  |              |
 |                |
||                ||
||                ||
||                ||
||                ||
||                ||
||                ||
||                ||
||                ||
||                ||
 \\\\              //
   --------------"""}

class AwesomeJar:
    def __init__(self, jarObject):
        self.jarObject = jarObject
        self.progress = 0.00
        self.dropletLine = 0
        self.dropletDelta = 1
    
    def drawJar(self):
        jarRepresentation = self.jarObject["text"].split("\n")
        linesToFill = int(self.progress * self.jarObject["height"])

        dropletX = self.jarObject["width"] // 2
        if (self.progress < 1):
            jarRepresentation[self.dropletLine] = jarRepresentation[self.dropletLine][0:dropletX] + "O" + jarRepresentation[self.dropletLine][(dropletX+1):]

        for y_fill in range(self.jarObject["height"] - linesToFill + self.jarObject["lineSkips"], self.jarObject["height"]+self.jarObject["lineSkips"]):
            jarRepresentation[y_fill] = "".join(list(map(lambda x: 
                    "X" if x in range(self.jarObject["fillLines"][y_fill][0],self.jarObject["fillLines"][y_fill][1]+1) 
                        else jarRepresentation[y_fill][x], range(len(jarRepresentation[y_fill])))))

        return jarRepresentation

    def setProgress(self, progress):
        linesToFill = int(self.progress * self.jarObject["height"])
        self.dropletLine += self.dropletDelta
        if self.dropletLine > self.jarObject["height"]-linesToFill:
            self.progress = progress
            self.dropletLine = 0

    def __str__(self):
        return "".join([x + "\n" for x in self.drawJar()])

if __name__ == "__main__":
    newJar = AwesomeJar(jar)
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())
    newJar.setProgress(0.2)
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())
    print(newJar.drawJar())

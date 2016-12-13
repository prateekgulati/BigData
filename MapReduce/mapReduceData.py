import sys
from multiprocessing import Pool
import csv
import psutil
import os

def memory():
    process = psutil.Process(os.getpid())
    print ("%.2f MB" % float(process.memory_info().rss/(1024.0*1024)))

def Map(line):
    results = []
    for word in line:
        if word.isalnum():
            results.append((word.lower(), 1))
    return results


def Reduce(Mapping):
    return [Mapping[0], sum(mapped[1] for mapped in Mapping[1])]


def Ordering(data):
    orderedMap = {}
    for sublist in data:
        for word in sublist:
            try:
                orderedMap[word[0]].append(word)
            except KeyError:
                orderedMap[word[0]] = [word]
    return orderedMap


def getText(path):
    word_list = []
    f = open(path, "r")
    for line in f:
        word_list.append(line.strip())
    return (''.join(word_list)).split()


def chunks(l, n):
    for i in xrange(0, len(l), n):
        yield l[i:i + n]


if __name__ == '__main__':
    if (len(sys.argv) != 3):
      print "Provide filename and number of processes"
      sys.exit(1)

    text = getText (sys.argv[1])
    processes=int(sys.argv[2])      # creating nodes
    #text = getText('pagerank.txt')  # testing
    #processes = 8

    node = Pool(processes=processes, )

    nodeData = list(chunks(text, len(text) / processes))  # data for each node

    mappedData = node.map(Map, nodeData)    #Map

    orderedMap = Ordering(mappedData)

    wordFrequency = node.map(Reduce, orderedMap.items())    #Reduce

    with open('wordFrequency.csv', 'wb') as myfile:
        wr = csv.writer(myfile)
        wr.writerows(wordFrequency)

    memory()

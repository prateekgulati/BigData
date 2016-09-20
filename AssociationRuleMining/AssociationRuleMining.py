__author__ = 'Prateek'

from itertools import combinations
import os
import psutil


def memory():
    process = psutil.Process(os.getpid())
    print ("%.2f MB" % float(process.memory_info().rss / (1024.0 * 1024)))


def Check(itemSet, transaction):
    for eachItem in itemSet:
        if eachItem not in transaction:
            return False
    return True


def Support(Items, Transactions, iter):
    support = dict()
    for itemSet in combinations(Items, iter):
        itemSet = sorted(itemSet)
        itemSet = ''.join(itemSet)
        support[itemSet] = 0
        for transaction in Transactions:
            if Check(itemSet, ''.join(transaction)):
                # print itemSet,transaction
                support[itemSet] += 1
    return support


def frequentItemset(support, threshold):
    Items = []
    for x, y in support.items():
        if y >= threshold:
            Items = Items.__add__(list(x))
    Items = set(Items)
    return Items


def AssociationRule(Items, Transactions, threshold):
    iter = 0
    while Items != (set([])):
        iter += 1
        support = Support(Items, Transactions, iter)
        print iter, 'iteration'
        print support.items()
        Items = frequentItemset(support, threshold)


if __name__ == '__main__':
    Transactions = (('A', 'B', 'C'), ('A', 'C'), ('A', 'D', 'E'), ('B', 'C'))  # Sample Data
    Items = set([items for i in Transactions for items in i])
    threshold = 2
    AssociationRule(Items, Transactions, threshold)
    memory()
